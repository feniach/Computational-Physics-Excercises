# Computational Physics Exercises

## Exercise 1: Nanoparticle Simulation in a Box
### Objective:
Simulate the movement of nanoparticles in a box with a wall and a hole, and compare the results to a theoretical equation. The simulation models the random movement of nanoparticles between two sections of the box until equilibrium is reached.
The theoretical equation for the number of nanoparticles in one part of the box as a function of time is given by:

$N(t) = \frac{N}{2} * (1 + e^{(-2t/τ)} )$
Where:

N is the total number of nanoparticles,
t is the time,
τ is a constant related to the time for equilibrium.

Key Tasks:
- Simulate the nanoparticle movement with different total nanoparticle counts (1,050, 10,500, 150,500).
- Plot the number of nanoparticles in one section over time and compare the results to the theoretical curve.
- Modify the initial conditions by distributing the nanoparticles randomly based on an ASCII sum of the student's name and surname.
- Analyze and discuss the results for different initial conditions and nanoparticle counts.

Files:
- MATLAB code for the simulation (nanoparticles.m)
- Generated plots in PNG format

## Exercise 2: Wind Rose Diagram
### Objective:
Generate a wind rose diagram from meteorological data to estimate the prevailing wind direction in different months of the year.

Key Tasks:
- Download and read wind data from a meteorological station.
- Convert wind speed from knots to m/s.
- Select a random year and data from a 10-year period.
- Create the wind rose diagram and label it with relevant information such as your name, computer name, and execution date.
- Calculate and display the prevailing wind direction for the spring or winter months based on the student ID number.

Files:
- MATLAB code for generating the wind rose (windrose_chronopoulou.m)
- Generated wind rose diagram in PNG format

## Exercise 3: Estimation of Wind Energy Potential using the Weibull Distribution
### Objective:
Estimate the wind energy potential of a region using the Weibull distribution to model the wind speed frequency.
The Weibull distribution function is given by:

$f(V) = \frac{k}{C} * \frac{V}{C}^{(k-1)} * e^{(-(V / C)^k)}$
Where:

V is the wind speed,
C is the scale parameter (related to the average wind speed),
k is the shape parameter (describes the distribution shape).

Key Tasks:
- Choose the correct meteorological station data based on the student ID number (even or odd).
- Convert wind speed from knots to m/s.
- Use the Weibull distribution to model wind speed data and estimate the parameters (C and k).
- Plot the wind speed distribution and the fitted Weibull curve.
- Display the parameters C and k on the graph along with the period of the data.

Files:
- MATLAB code for the Weibull distribution fitting (weibull_chronopoulou.m)
- Generated plot of the Weibull distribution in PNG format
