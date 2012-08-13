get 'timesheet/index' => 'timesheet#index'
get 'timesheet/context_menu' => 'timesheet#context_menu'
match 'timesheet/report(.:format)' =>'timesheet#report'
delete 'timesheet/reset'=> 'timesheet#reset'