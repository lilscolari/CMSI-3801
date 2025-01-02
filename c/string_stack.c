#include "string_stack.h"

#include <stdlib.h>
#include <string.h>

static const int INITIAL_CAPACITY = 16;

struct _Stack {
    char** elements;
    int top;
    int capacity;
};

stack_response create() {
    stack s = malloc(sizeof(struct _Stack));
    if (s == NULL) {
        return (stack_response){out_of_memory, NULL};
    }
    s->top = 0;
    s->capacity = INITIAL_CAPACITY;
    s->elements = malloc(INITIAL_CAPACITY * sizeof(char*));
    if (s->elements == NULL) {
        free(s);
        return (stack_response){out_of_memory, NULL};
    }
    return (stack_response){success, s};
}

int size(const stack s) {
    return s->top;
}

bool is_empty(const stack s) {
    return size(s) == 0;
}

bool is_full(const stack s) {
    return size(s) == MAX_CAPACITY;
}

response_code push(stack s, char* item) {
    if (is_full(s)) {
        return stack_full;
    }
    if (strlen(item) > MAX_ELEMENT_BYTE_SIZE) {
        return stack_element_too_large;
    }
    if (s->top == s->capacity) {
        int new_capacity = s->capacity * 2;
        if (new_capacity > MAX_CAPACITY) {
            new_capacity = MAX_CAPACITY;
        }
        char** new_elements = realloc(
            s->elements, new_capacity * sizeof(char*)
        );
        if (new_elements == NULL) {
            return out_of_memory;
        }
        s->elements = new_elements;
        s->capacity = new_capacity;
    }
    s->elements[s->top++] = strdup(item);
    return success;
}

string_response pop(stack s) {
    if (is_empty(s)) {
        return (string_response){stack_empty, NULL};
    }
    char* popped = s->elements[--s->top];
    int new_capacity = s->capacity / 2;
    if (new_capacity < 1) {
        new_capacity = 1;
    }
    if (new_capacity < s->capacity) {
        char** new_elements = realloc(
            s->elements, new_capacity * sizeof(char*)
        );
        if (new_elements == NULL) {
            free(popped);
            return (string_response){out_of_memory, NULL};
        }
        s->elements = new_elements;
        s->capacity = new_capacity;
    }
    return (string_response){success, popped};
}

void destroy(stack* s) {
    if (!s || !*s) {
        return;
    }
    for (int i = 0; i < (*s)->top; i++) {
        free((*s)->elements[i]);
    }
    free((*s)->elements);
    free(*s);
    *s = NULL;
}
