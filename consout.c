#include <stdio.h>

int main(void)
{
	char buffer[BUFSIZ];
	char filename[] = "c:\\temp\\test.txt";
	FILE *fp = NULL;

	fp = fopen(filename, "w"); /* open file for reading */

	if(fp == NULL) /* ALWAYS CHECK RETURN VALUE !!! */
	{
		printf("Failed to open file for writing\n");
		return -1;
	}
	fputs("Hello world\n", fp); /* write a string to file */
	fputc('A', fp); /* write a character to file */
	fclose(fp); /* close file */

	fp = fopen(filename, "a"); /* open file for appending !!! */
	if(fp == NULL)
	{
		printf("Failed to open file for appending\n");
		return -2;
	}
	fprintf(fp, "\nMy age is %d\n", 99); /* write a formatted string to file */
	fclose(fp);

	fp = fopen(filename, "r"); /* open file for reading */
	if(fp == NULL)
	{
		printf("Failed to open file for reading\n");
		return -3;
	}
	while(fgets(buffer, BUFSIZ, fp) != NULL)
		printf(buffer);
	fclose(fp);

	return 0;
}
