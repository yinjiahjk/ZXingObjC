/*
 * Copyright 2014 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "ZXByteArray.h"

@implementation ZXByteArray

- (id)initWithLength:(unsigned int)length {
  if (self = [super init]) {
    _array = (int8_t *)calloc(length, sizeof(BOOL));
    _length = length;
  }

  return self;
}

- (id)initWithBytes:(int8_t)byte1, ... {
  va_list args;
  va_start(args, byte1);
  unsigned int length = 0;
  for (int8_t byte = byte1; byte != -1; byte = va_arg(args, int)) {
    length++;
  }
  va_end(args);

  if (self = [self initWithLength:length]) {
    va_list args;
    va_start(args, byte1);
    int i = 0;
    for (int8_t byte = byte1; byte != -1; byte = va_arg(args, int)) {
      _array[i++] = byte;
    }
    va_end(args);
  }

  return self;
}

- (void)dealloc {
  if (_array) {
    free(_array);
  }
}

- (NSString *)description {
  NSMutableString *s = [NSMutableString stringWithFormat:@"length=%u, array=(", self.length];

  for (int i = 0; i < self.length; i++) {
    [s appendFormat:@"%d", self.array[i]];
    if (i < self.length - 1) {
      [s appendString:@", "];
    }
  }

  [s appendString:@")"];
  return s;
}

@end
