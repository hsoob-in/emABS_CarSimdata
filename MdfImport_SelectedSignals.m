
clear all;
clc;

[file, path]=uigetfile('*.dat','load data file');

    DatFileName = {};
    DatFileName{1} = file;

mdfimport(DatFileName{1},{'workspace'},'DataList.txt',{'actual'},'ratestring')