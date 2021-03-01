% clear all
close all
clear
clearvars -GLOBAL
clc
format shorte

set(0, 'DefaultFigureWindowStyle', 'docked')

global L W V0

L = 3;
W = 2;
V0 = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Variables to be changed below %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nx = 150;                    % Number of X elements                          
ny = 100;                    % Number of Y elements
Iteration = 100;

%===================================%
%========= Part 1A  Ramp ===========%
%===================================%
Part1a_Ramp(nx,ny);

%===================================%
%========= Part 1B  Saddle =========%
%===================================%
Part1b_Saddle(nx,ny,Iteration);


%===================================%
%============= Part 2A =============%
%===================================%

Part2a(nx,ny);

Part2c_Narrowing(nx,ny);

Part2d_DiffSigma(nx,ny);


