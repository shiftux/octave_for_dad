# pwd = present working direcotry
# cd = change direcotry
# ls = list files in dir
# type 'testfile' in the correct dir, the 'data.csv' file has to be in the same dir

1;	# Prevent Octave from thinking that this is a function file

########################################################
# init
########################################################

clear all;	# clear all variables
clf; 		# clear figures
close all; 	# figures
hold off; 	# force redraw of plots

########################################################
# helper function
########################################################

function transform(angle, alt)
	clf																		# clear figure

	# variables
	planefactor =	2;
	x_center =		0;
	y_center =		0;
	left_border =	-5;
	right_border =	5;
	x1 =			x_center - planefactor*cos(pi/180*angle);
	x2 =			x_center + planefactor*cos(pi/180*angle);
	y1 =			y_center + planefactor*sin(pi/180*angle) + alt;
	y2 =			y_center - planefactor*sin(pi/180*angle) + alt;
	
	# plotting																# draw COG
	line([left_border ; right_border],[0 ; 0],'Color','b','LineWidth',4) 	# ground plot															
	line([x1 ; x2],[y1 ; y2],'Color','r','LineWidth',2) 					# plane plot
	legend('ground', 'plane')												# plot legend
	axis ([left_border right_border -.5 5])									# define plot limits
endfunction

########################################################
# the sctipt
########################################################

M = 	csvread("data.csv"); 
time = 	M(2:end, 1);			# take second line -> end from 1st column (since first line is text!)
alt = 	M(2:end, 2);
angle = M(2:end, 3);

for i=1:length(time)
	transform(angle(i), alt(i));
	usleep(1/8);
endfor