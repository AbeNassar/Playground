clear all; close all; 

HW = [150, 100, 80, 80, 80, 80, 92, 100];


RQ = [4     ,...  %quiz I
      3.8   ,...  %quiz II
      4     ,...  %quiz III
      3.2   ,...  %quiz IV
      3     ,...  %quiz V
      3.2   ,...  %quiz VI
      4     ,...  %quiz VII
      3.6   ,...  %quiz VIII
      3.2   ,...  %quiz IX
      3.8   ,...  %quiz X
      4     ,...  %quiz XI
      3.2   ,...  %quiz XII
      5     ,...  %quiz XIII
      5     ,...  %quiz XIV
      5     ,...  %quiz XV
      5     ,...  %quiz XVI
      4.5   ,...  %quiz XVII
      5     ,...  %quiz XVIII
    ];
grade = 2/3*mean(HW)/100 + 1/3*mean(RQ)/5;


if (min(RQ(1:12))>=4 && min(RQ(13:18))==5)
    disp('You are done with the Quizzes!')
    disp(sprintf('Your grade is %0.1f.',grade*100))
else
    [i,j] = min(RQ);
    disp(sprintf('Take quiz %d',j));
    disp(sprintf('Your grade is %0.1f.',grade*100))
end

