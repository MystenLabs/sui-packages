module 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::date {
    public fun add_days(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 * 86400
    }

    public fun add_hours(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 * 3600
    }

    public fun add_minutes(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 * 60
    }

    public fun add_months(arg0: u64, arg1: u64) : u64 {
        let (v0, v1, v2) = days_to_date(arg0 / 86400);
        let v3 = v2;
        let v4 = v1 + arg1;
        let v5 = v0 + (v4 - 1) / 12;
        let v6 = (v4 - 1) % 12 + 1;
        let v7 = get_days_in_year_month(v5, v6);
        if (v2 > v7) {
            v3 = v7;
        };
        let v8 = days_from_date(v5, v6, v3) * 86400 + arg0 % 86400;
        assert!(v8 >= arg0, 720897);
        v8
    }

    public fun add_seconds(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun add_years(arg0: u64, arg1: u64) : u64 {
        let (v0, v1, v2) = days_to_date(arg0 / 86400);
        let v3 = v2;
        let v4 = v0 + arg1;
        let v5 = get_days_in_year_month(v4, v1);
        if (v2 > v5) {
            v3 = v5;
        };
        let v6 = days_from_date(v4, v1, v3) * 86400 + arg0 % 86400;
        assert!(v6 >= arg0, 720897);
        v6
    }

    public fun days_from_date(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 >= 1970, 65536);
        let v0 = if (arg1 < 3) {
            1
        } else {
            0
        };
        let v1 = v0 * 12 + arg1;
        let v2 = if (v1 >= 2) {
            arg2 + 1461 * (arg0 + 4800 - v0) / 4 + 367 * (v1 - 2) / 12
        } else {
            arg2 + 1461 * (arg0 + 4800 - v0) / 4 - 367 * (2 - v1) / 12
        };
        v2 - 3 * (arg0 + 4900 - v0) / 100 / 4 - 32075 - 2440588
    }

    public fun days_to_date(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 + 68569 + 2440588;
        let v1 = 4 * v0 / 146097;
        let v2 = v0 - (146097 * v1 + 3) / 4;
        let v3 = 4000 * (v2 + 1) / 1461001;
        let v4 = v2 - 1461 * v3 / 4 + 31;
        let v5 = 80 * v4 / 2447;
        let v6 = v5 / 11;
        (100 * (v1 - 49) + v3 + v6, v5 + 2 - 12 * v6, v4 - 2447 * v5 / 80)
    }

    public fun diff_days(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= arg1, 720899);
        (arg1 - arg0) / 86400
    }

    public fun diff_hours(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= arg1, 720899);
        (arg1 - arg0) / 3600
    }

    public fun diff_minutes(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= arg1, 720899);
        (arg1 - arg0) / 60
    }

    public fun diff_months(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= arg1, 720899);
        let (v0, v1, _) = days_to_date(arg0 / 86400);
        let (v3, v4, _) = days_to_date(arg1 / 86400);
        v3 * 12 + v4 - v0 * 12 - v1
    }

    public fun diff_seconds(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= arg1, 720899);
        arg1 - arg0
    }

    public fun diff_years(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= arg1, 720899);
        let (v0, _, _) = days_to_date(arg0 / 86400);
        let (v3, _, _) = days_to_date(arg1 / 86400);
        v3 - v0
    }

    public fun get_day(arg0: u64) : u64 {
        let (_, _, v2) = days_to_date(arg0 / 86400);
        v2
    }

    public fun get_day_of_week(arg0: u64) : u64 {
        (arg0 / 86400 + 3) % 7 + 1
    }

    public fun get_days_in_timestamp_month(arg0: u64) : u64 {
        let (v0, v1, _) = days_to_date(arg0 / 86400);
        get_days_in_year_month(v0, v1)
    }

    public fun get_days_in_year_month(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 1 || arg1 == 3 || arg1 == 5 || arg1 == 7 || arg1 == 8 || arg1 == 10 || arg1 == 12) {
            return 31
        };
        if (arg1 != 2) {
            return 30
        };
        if (is_year_leap_year(arg0)) {
            29
        } else {
            28
        }
    }

    public fun get_hour(arg0: u64) : u64 {
        arg0 % 86400 / 3600
    }

    public fun get_minute(arg0: u64) : u64 {
        arg0 % 3600 / 60
    }

    public fun get_month(arg0: u64) : u64 {
        let (_, v1, _) = days_to_date(arg0 / 86400);
        v1
    }

    public fun get_second(arg0: u64) : u64 {
        arg0 % 60
    }

    public fun get_year(arg0: u64) : u64 {
        let (v0, _, _) = days_to_date(arg0 / 86400);
        v0
    }

    public fun is_timestamp_leap_year(arg0: u64) : bool {
        let (v0, _, _) = days_to_date(arg0 / 86400);
        is_year_leap_year(v0)
    }

    public fun is_valid_date(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 >= 1970 && arg1 > 0 && arg1 <= 12) {
            if (arg2 > 0 && arg2 <= get_days_in_year_month(arg0, arg1)) {
                return true
            };
        };
        false
    }

    public fun is_valid_date_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : bool {
        is_valid_date(arg0, arg1, arg2) && arg3 < 24 && arg4 < 60 && arg5 < 60
    }

    public fun is_weekday(arg0: u64) : bool {
        get_day_of_week(arg0) <= 5
    }

    public fun is_weekend(arg0: u64) : bool {
        get_day_of_week(arg0) >= 6
    }

    public fun is_year_leap_year(arg0: u64) : bool {
        arg0 % 4 == 0 && arg0 % 100 != 0 || arg0 % 400 == 0
    }

    public fun sub_days(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1 * 86400
    }

    public fun sub_hours(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1 * 3600
    }

    public fun sub_minutes(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1 * 60
    }

    public fun sub_months(arg0: u64, arg1: u64) : u64 {
        let (v0, v1, v2) = days_to_date(arg0 / 86400);
        let v3 = v2;
        let v4 = v0 * 12 + v1 - 1 - arg1;
        let v5 = v4 / 12;
        let v6 = v4 % 12 + 1;
        let v7 = get_days_in_year_month(v5, v6);
        if (v2 > v7) {
            v3 = v7;
        };
        let v8 = days_from_date(v5, v6, v3) * 86400 + arg0 % 86400;
        assert!(v8 <= arg0, 720898);
        v8
    }

    public fun sub_seconds(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1
    }

    public fun sub_years(arg0: u64, arg1: u64) : u64 {
        let (v0, v1, v2) = days_to_date(arg0 / 86400);
        let v3 = v2;
        let v4 = v0 - arg1;
        let v5 = get_days_in_year_month(v4, v1);
        if (v2 > v5) {
            v3 = v5;
        };
        let v6 = days_from_date(v4, v1, v3) * 86400 + arg0 % 86400;
        assert!(v6 <= arg0, 720898);
        v6
    }

    public fun timestamp_from_date(arg0: u64, arg1: u64, arg2: u64) : u64 {
        days_from_date(arg0, arg1, arg2) * 86400
    }

    public fun timestamp_from_date_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        days_from_date(arg0, arg1, arg2) * 86400 + arg3 * 3600 + arg4 * 60 + arg5
    }

    public fun timestamp_to_date(arg0: u64) : (u64, u64, u64) {
        days_to_date(arg0 / 86400)
    }

    public fun timestamp_to_date_time(arg0: u64) : (u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = days_to_date(arg0 / 86400);
        let v3 = arg0 % 86400;
        let v4 = v3 % 3600;
        (v0, v1, v2, v3 / 3600, v4 / 60, v4 % 60)
    }

    // decompiled from Move bytecode v6
}

