#!/usr/bin/env python
# -*- coding: utf-8 -*-

# update path to file here
file_path = '../testbenchLCD.txt'

# you should not need to touch the rest ...

f_ppm = open('out.ppm', 'wb')

# ppm header - 
#    P6 is filetype,
#    next line is view resolution,
#    255 is max pixel chanel resolution (e.g. pixel is 24bits / 3 bytes)
f_ppm.write(b"P6\n1024 525\n255\n") 

with open(file_path, 'r') as f:
    # finite (three) state machine 
    #    state a) line starts with # and thus is a comment or is used for navigation (so ignore this line)
    #          b) line starts with *n , where n is an integer -> multiply last result n times 
    #             (note - should always come after state c, not checked...) )
    #          c) line is a 24bit number
    
    current_rgb = 0x000000 # "24bit" integer
    
    for line in f:
        if line[0] == '#' or line[0] == '\n':
            continue
        elif line[0] == '*':
            times = int(line[1:])
            
            for i in range(times):
                f_ppm.write(current_rgb.to_bytes(3,'big'))
            
        else:
            current_rgb = int(line) & 0xffffff
            f_ppm.write(current_rgb.to_bytes(3,'big'))
    
f_ppm.close()

