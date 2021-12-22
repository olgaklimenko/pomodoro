# Pomodoro

Usage:

`pomodoro --work 45 --short 5 --long 15 --task "make a weekly report"`

`--work`: set the work time in minutes (default 45)
`--short`: set the short break time in minutes (default 5)
`--long`: set the long break time in minutes (default 15)
`--task`: set a task name (default is empty string "")

Will call `beep` signal on the end of the work or break time

```
First Pomodoro is started. Work remains: 44 min
First Pomodoro is finished. 
Total work time is 44 min.
Type 1) to start a short break (default) 
     2) to start a long break
     3) to start a new work period right now
-- Short break --
Short break is started. Break remains: 3 min
Short break is finished.
Press `Enter` to return to work.
-- Long break --
Long break is started. Break remains: 13 min
Long break is finished.
Press `Enter` to return to work.
```

Show the total work time on `ctrl+c`.
