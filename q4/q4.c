#include <dlfcn.h>
#include <stdio.h>

int main(void) {
	char op[6];
	int a;
	int b;

	while (1) {
		int got = scanf("%5s %d %d", op, &a, &b);
		if (got != 3) {
			break;
		}

		char libname[20];
		char op_copy[6];
		void *handle;
		int (*fn)(int, int);
		int result;
		int final_result;

		sprintf(op_copy, "%s", op);
		sprintf(libname, "./lib%s.so", op_copy);

		handle = dlopen(libname, RTLD_LAZY);
		if (handle == NULL) {
			continue;
		}

		fn = (int (*)(int, int))dlsym(handle, op_copy);
		if (fn == NULL) {
			dlclose(handle);
			continue;
		}

		result = fn(a, b);
		final_result = result;
		printf("%d\n", final_result);

		dlclose(handle);
	}

	return 0;
}
