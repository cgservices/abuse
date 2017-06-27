# CG Abuse #
Abuse gem, tracks user abuse actions (e.g. failed logins)

### Database model ###
```
[---------------------]
|abuse_scores         |
[---------------------]
|id (int)             |
|ip (varchar)         |
|points (int)         |
|reason (varchar)     |
|created_at (datetime)|
|updated_at (datetime)|
[---------------------]
```
### Installation ###

In your Gemfile:
```
gem 'abuse', git: 'git@github.com:cgservices/abuse.git'
```

### Configuration ###
Set default timespan
```
Abuse::Score.default_timespan = 1.day
```

### Installation ###
Install migrations
```
> bundle exec rake abuse:install
```

### Class methods ###

Add a new score for an IP with a reason
```
Abuse::Score.add_score('1.1.1.1', 10, 'login failed')
Abuse::Score.add_score('1.1.1.1', 3, 'some reason')
```

Get score for IP and optional timespan (now - x seconds)
```
Abuse::Score.get_points('1.1.1.1')
> [10, 3, 5, 8]

Abuse::Score.get_points('1.1.1.1', 1.hour)
> [5, 8]
```

Get cumulative points for an IP and optional timespan
```
Abuse::Score.get_cumulative_points('1.1.1.1')
> 26

Abuse::Score.get_cumulative_points('1.1.1.1', 1.hour)
> 13
```

Clean all scores
```
Abuse::Score.clean_scores # remove all scores

Abuse::Score.clean_scores(1.hour) # remove all scores added in the last hour
```

Reset scores for an IP
```
Abuse::Score.reset('1.1.1.1')
```
