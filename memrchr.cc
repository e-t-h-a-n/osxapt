/*
 * Copyright (c) 2007 Todd C. Miller <Todd.Miller@courtesan.com>
 * Adapted into APT by Ethan Sherriff
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#ifndef __APT_DARWIN_MEMRCHR_H_ // Header guard.

#include "memrchr.h"

extern "C" {

/*
 * Reverse memchr()
 * Find the last occurrence of 'c' in the buffer 's' of size 'n'.
 */
void* memrchr(const void* s, int c, size_t n) {
  const unsigned char *cp;

  if (n != 0) {
	  cp = (unsigned char *)s + n;
	  do {
	    if (*(--cp) == (unsigned char)c)
		    return (void *) cp;
	  } while (--n != 0);
  }
  return (void* ) 0;
}

}

#define __APT_DARWIN_MEMRCHR_H_ // Header guard.
#endif // Header guard.
