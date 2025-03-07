#include <stdio.h>

struct Student
{
    int sid;      // Student ID
    int grade[4]; // Array of grades
    int average;  // Computed average of grades
};

int n;             // Number of students
int m;             // The student ID of the median student
struct Student *s; // Dynamic array of students

// Function to calculate the average grade of each student
void calculateAverages()
{
    for (int i = 0; i < n; i++)
    {
        int sum = 0;
        for (int j = 0; j < 4; j++)
        {
            sum += s[i].grade[j];
        }
        s[i].average = sum / 4;
    }
}

// Function to sort students by average grade using bubble sort
void bubbleSort()
{
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = 0; j < n - i - 1; j++)
        {
            if (s[j].average > s[j + 1].average)
            {
                // Swap students
                struct Student temp = s[j];
                s[j] = s[j + 1];
                s[j + 1] = temp;
            }
        }
    }
}

// Function to find the median student
void findMedian()
{
    // The median student is the one at the middle index
    m = s[n / 2].sid; // Store the ID of the student at the median index
}

int main()
{
    // Sample input: 5 students, can be modified as needed
    n = 5; // Number of students
    struct Student students[5] = {
        {1234, {80, 60, 78, 90}, 0},
        {2345, {88, 92, 80, 70}, 0},
        {3456, {65, 75, 85, 95}, 0},
        {4567, {90, 70, 65, 85}, 0},
        {5678, {75, 85, 65, 80}, 0}};

    s = students; // Set the pointer to the array of students

    // Step 1: Calculate the average for each student
    calculateAverages();

    // Step 2: Sort students by their average grades
    bubbleSort();

    // Step 3: Find the median student
    findMedian();

    // Step 4: Print the median student's ID
    printf("Median student's ID: %d\n", m);

    return 0;
}
