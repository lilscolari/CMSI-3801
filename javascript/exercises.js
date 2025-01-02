import { open } from "node:fs/promises"
import readline from "readline/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

export function firstThenLowerCase(a, p) {
  const solution = a.find(p)
  return solution?.toLowerCase()
}

export function* powersGenerator( {ofBase, upTo} ) {
  let exponent = 0
  while (ofBase ** exponent <= upTo) {
    yield ofBase ** exponent
    exponent++
  }
}

export function say(word) {
  let words = []
  function chain(nextWord) {
    if (nextWord === undefined) {
      return words.join(' ')
    }
    words.push(nextWord)
    return chain
  }
  return chain(word)
}

export async function meaningfulLineCount(filePath) {
  let fileHandle
  try {
    fileHandle = await open(filePath, 'r')
    const r1 = readline.createInterface({
      input: fileHandle.createReadStream(),
      crlfDelay: Infinity
    })
    let count = 0
    for await (const line of r1) {
      const trimmedLine = line.trim()
      if (trimmedLine !== '' && !trimmedLine.startsWith('#')) {
        count++
      }
    }
    return count
  } catch (error) {
    throw error
  } finally {
    if (fileHandle) await fileHandle.close();
  }
}

export class Quaternion {
  constructor(a, b, c, d) {
    this.a = a
    this.b = b
    this.c = c
    this.d = d
    Object.freeze(this)
  }

  get coefficients() {
    return [this.a, this.b, this.c, this.d]
  }

  get conjugate() {
    return new Quaternion(this.a, this.b * -1, this.c * -1, this.d * -1)
  }

  plus (q) {
    return new Quaternion(this.a + q.a, this.b + q.b, this.c + q.c, this.d + q.d)
  }

  times (q) {
    return new Quaternion(
      this.a * q.a - this.b * q.b - this.c * q.c - this.d * q.d,
      this.a * q.b + this.b * q.a + this.c * q.d - this.d * q.c,
      this.a * q.c - this.b * q.d + this.c * q.a + this.d * q.b,
      this.a * q.d + this.b * q.c - this.c * q.b + this.d * q.a
    )
  }
  
  toString() {
    const terms = []
    const components = [
      [this.a, ''],
      [this.b, 'i'],
      [this.c, 'j'],
      [this.d, 'k']
    ];

    for (let [value, unit] of components) {
      if (value !== 0) {
        if (value === 1 && unit !== '') {
          terms.push(unit)
        } else if (value === -1 && unit !== '') {
          terms.push(`-${unit}`)
        } else {
          terms.push(`${value}${unit}`)
        }
      }
    }

    if (terms.length === 0) return '0'
    return terms.join('+').replace(/\+-/g, '-')
  }
}

