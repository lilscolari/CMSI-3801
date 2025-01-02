from dataclasses import dataclass
from collections.abc import Callable, Generator


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(
        a: list[str],
        p: Callable[[str], bool]
) -> str | None:
    for string in a:
        if p(string):
            return string.lower()
    return None


# Write your powers generator here
def powers_generator(*, base: int, limit: int) -> Generator[int, None, None]:
    exponent = 0
    while base**exponent <= limit:
        yield base**exponent
        exponent += 1


# Write your say function here
def say(word: str | None = None, /) -> str:
    if word is None:
        return ''
    def next_word(next: str | None = None) -> 'next_word':
        if next is None:
            return next_word.word
        next_word.word += f' {next}'
        return next_word
    next_word.word = word
    return next_word


# Write your line count function here
def meaningful_line_count(file_name: str, /) -> int:
    try:
        with open(file_name, 'r', encoding='utf-8') as file:
            meaningful_line_counter = 0
            for line in file:
                line = line.strip()
                if not line or line.startswith('#'):
                    continue
                meaningful_line_counter += 1
            return meaningful_line_counter
    except FileNotFoundError:
        raise FileNotFoundError('No such file')


# Write your Quaternion class here
@dataclass(frozen=True)
class Quaternion():
    a: float
    b: float
    c: float
    d: float
    
    def __eq__(self, other: 'Quaternion', /) -> bool:
        if isinstance(other, Quaternion):
            if self.a != other.a:
                return False
            if self.b != other.b:
                return False
            if self.c != other.c:
                return False
            if self.d != other.d:
                return False
            return True
    
    def __str__(self):
        a_string = str(float(self.a))
        b_string = str(float(self.b)) + 'i'
        c_string = str(float(self.c)) + 'j'
        d_string = str(float(self.d)) + 'k'

        if a_string == '0.0':
            a_string = ''

        match b_string:
            case '0.0i':
                b_string = ''
            case '1.0i':
                b_string = 'i'
            case '-1.0i':
                b_string = '-i'

        match c_string:
            case '0.0j':
                c_string = ''
            case '1.0j':
                c_string = 'j'
            case '-1.0j':
                c_string = '-j'
        
        match d_string:
            case '0.0k':
                d_string = ''
            case '1.0k':
                d_string = 'k'
            case '-1.0k':
                d_string = '-k'
        
        return_str = a_string + '+' + b_string + '+' + c_string + '+' + d_string

        return_str = return_str.replace('++', '+')
        return_str = return_str.replace('+-', '-')

        if return_str == '':
            return '0'

        if return_str[len(return_str) - 1] == '+':
            return_str = return_str[0:len(return_str) - 1]
        
        if return_str[0] == '+':
            return_str = return_str[1:]        

        if return_str == '':
            return '0'
        
        return return_str

    def __add__(self, other: 'Quaternion', /) -> 'Quaternion':
        if isinstance(other, Quaternion):
            a_sum = self.a + other.a
            b_sum = self.b + other.b
            c_sum = self.c + other.c
            d_sum = self.d + other.d
            return Quaternion(a_sum, b_sum, c_sum, d_sum)

    def __mul__(self, other: 'Quaternion', /) -> 'Quaternion':
        if isinstance(other, Quaternion):
            a_prod = (self.a * other.a) - (self.b * other.b) \
                    - (self.c * other.c) - (self.d * other.d)
            b_prod = (self.a * other.b) + (self.b * other.a) \
                    + (self.c * other.d) - (self.d * other.c)
            c_prod = (self.a * other.c) - (self.b * other.d) \
                    + (self.c * other.a) + (self.d * other.b)
            d_prod = (self.a * other.d) + (self.b * other.c) \
                    - (self.c * other.b) + (self.d * other.a)
            return Quaternion(a_prod, b_prod, c_prod, d_prod)
    
    @property
    def coefficients(self) -> tuple[float]:
        return self.a, self.b, self.c, self.d
    
    @property
    def conjugate(self) -> 'Quaternion':
        return Quaternion(self.a, self.b * -1, self.c * -1, self.d * -1)
