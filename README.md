# Median Student Finder (Bubble Sort in C)

This C program demonstrates how to find the student with the median average grade using a bubble sort algorithm. The program works with a list of student records, calculates their average grades, sorts the students based on these averages, and identifies the student at the median position.

## Key Features
- Calculates the average grade of each student.
- Sorts students based on their average grades using the bubble sort algorithm.
- Identifies the student at the median position and outputs their student ID.

## How It Works
1. **Student Structure**: The `Student` structure holds the student ID, grades, and computed average.
2. **Calculate Averages**: Each student's average grade is computed by summing their grades and dividing by the total number of grades.
3. **Bubble Sort**: The program uses bubble sort to order students by their average grades.
4. **Find Median**: After sorting, the program selects the student at the median index, which corresponds to the middle position of the sorted array.
5. **Output**: The program outputs the student ID of the median student.

## Example
### Input
A sample list of 5 students, each with 4 grades.

### Output
The student ID of the student with the median average grade.

### Sample Output:
