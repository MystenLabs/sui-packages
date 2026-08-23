module 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar {
    struct CalendarPeriod has copy, drop, store {
        count: u64,
        unit: u8,
    }

    struct PeriodWindow has copy, drop, store {
        index: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct CivilDateTime has copy, drop, store {
        year: u64,
        month: u8,
        day: u8,
        ms_of_day: u64,
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 4);
        arg0 + arg1
    }

    fun checked_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 4);
        arg0 * arg1
    }

    public fun civil_day(arg0: &CivilDateTime) : u8 {
        arg0.day
    }

    public fun civil_month(arg0: &CivilDateTime) : u8 {
        arg0.month
    }

    public fun civil_ms_of_day(arg0: &CivilDateTime) : u64 {
        arg0.ms_of_day
    }

    public fun civil_to_timestamp(arg0: u64, arg1: u8, arg2: u8, arg3: u64) : u64 {
        assert!(arg0 >= 1970, 3);
        assert!(arg1 >= 1 && arg1 <= 12, 3);
        assert!(arg2 >= 1 && (arg2 as u64) <= days_in_month(arg0, arg1), 3);
        assert!(arg3 < 86400000, 3);
        let v0 = days_before_year(arg0);
        let v1 = 1;
        while (v1 < arg1) {
            v0 = checked_add(v0, days_in_month(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = checked_add(v0, (arg2 as u64) - 1);
        assert!(v2 <= (18446744073709551615 - arg3) / 86400000, 4);
        v2 * 86400000 + arg3
    }

    public fun civil_year(arg0: &CivilDateTime) : u64 {
        arg0.year
    }

    public fun day(arg0: u64) : CalendarPeriod {
        new_period(arg0, 0)
    }

    public fun day_unit() : u8 {
        0
    }

    fun days_before_year(arg0: u64) : u64 {
        assert!(arg0 >= 1970, 3);
        checked_add(checked_mul(arg0 - 1970, 365), leap_years_before(arg0) - leap_years_before(1970))
    }

    fun days_in_month(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 2) {
            if (is_leap_year(arg0)) {
                29
            } else {
                28
            }
        } else {
            let v1 = if (arg1 == 4) {
                true
            } else if (arg1 == 6) {
                true
            } else if (arg1 == 9) {
                true
            } else {
                arg1 == 11
            };
            if (v1) {
                30
            } else {
                31
            }
        }
    }

    fun derive_day_window(arg0: u64, arg1: u64, arg2: u64) : PeriodWindow {
        let v0 = checked_mul(arg2, 86400000);
        let v1 = (arg1 - arg0) / v0;
        let v2 = checked_add(arg0, checked_mul(v1, v0));
        PeriodWindow{
            index    : v1,
            start_ms : v2,
            end_ms   : checked_add(v2, v0),
        }
    }

    fun derive_month_window(arg0: u64, arg1: u64, arg2: u64) : PeriodWindow {
        let v0 = timestamp_to_civil(arg0);
        let v1 = timestamp_to_civil(arg1);
        let v2 = if (v1.month >= v0.month) {
            checked_add(checked_mul(v1.year - v0.year, 12), ((v1.month - v0.month) as u64))
        } else {
            checked_mul(v1.year - v0.year, 12) - ((v0.month - v1.month) as u64)
        };
        let v3 = v2 / arg2;
        let v4 = v3;
        let v5 = month_boundary(&v0, checked_mul(v3, arg2));
        let v6 = v5;
        if (v5 > arg1) {
            assert!(v3 > 0, 2);
            let v7 = v3 - 1;
            v4 = v7;
            v6 = month_boundary(&v0, checked_mul(v7, arg2));
        };
        PeriodWindow{
            index    : v4,
            start_ms : v6,
            end_ms   : month_boundary(&v0, checked_mul(checked_add(v4, 1), arg2)),
        }
    }

    public fun derive_window(arg0: u64, arg1: u64, arg2: &CalendarPeriod) : PeriodWindow {
        assert!(arg1 >= arg0, 2);
        if (arg2.unit == 0) {
            derive_day_window(arg0, arg1, arg2.count)
        } else if (arg2.unit == 1) {
            derive_month_window(arg0, arg1, arg2.count)
        } else {
            derive_year_window(arg0, arg1, arg2.count)
        }
    }

    fun derive_year_window(arg0: u64, arg1: u64, arg2: u64) : PeriodWindow {
        let v0 = timestamp_to_civil(arg0);
        let v1 = timestamp_to_civil(arg1);
        let v2 = (v1.year - v0.year) / arg2;
        let v3 = v2;
        let v4 = year_boundary(&v0, checked_mul(v2, arg2));
        let v5 = v4;
        if (v4 > arg1) {
            assert!(v2 > 0, 2);
            let v6 = v2 - 1;
            v3 = v6;
            v5 = year_boundary(&v0, checked_mul(v6, arg2));
        };
        PeriodWindow{
            index    : v3,
            start_ms : v5,
            end_ms   : year_boundary(&v0, checked_mul(checked_add(v3, 1), arg2)),
        }
    }

    public fun is_leap_year(arg0: u64) : bool {
        arg0 % 4 == 0 && (arg0 % 100 != 0 || arg0 % 400 == 0)
    }

    fun leap_years_before(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = arg0 - 1;
        v0 / 4 - v0 / 100 + v0 / 400
    }

    public fun month(arg0: u64) : CalendarPeriod {
        new_period(arg0, 1)
    }

    fun month_boundary(arg0: &CivilDateTime, arg1: u64) : u64 {
        assert!(arg0.year <= (18446744073709551615 - (arg0.month as u64) - 1) / 12, 4);
        let v0 = checked_add(arg0.year * 12 + (arg0.month as u64) - 1, arg1);
        let v1 = v0 / 12;
        let v2 = ((v0 % 12 + 1) as u8);
        civil_to_timestamp(v1, v2, (0x1::u64::min((arg0.day as u64), days_in_month(v1, v2)) as u8), arg0.ms_of_day)
    }

    public fun month_unit() : u8 {
        1
    }

    public fun new_period(arg0: u64, arg1: u8) : CalendarPeriod {
        assert!(arg0 > 0, 1);
        assert!(arg1 <= 2, 1);
        CalendarPeriod{
            count : arg0,
            unit  : arg1,
        }
    }

    public fun period_count(arg0: &CalendarPeriod) : u64 {
        arg0.count
    }

    public fun period_unit(arg0: &CalendarPeriod) : u8 {
        arg0.unit
    }

    public fun timestamp_to_civil(arg0: u64) : CivilDateTime {
        let v0 = arg0 / 86400000;
        let v1 = 1970;
        let v2 = v0 / 365;
        assert!(v2 <= 18446744073709551615 - 1970 - 1, 4);
        let v3 = 1970 + v2 + 1;
        while (v1 < v3) {
            let v4 = v1 + (v3 - v1 + 1) / 2;
            if (days_before_year(v4) <= v0) {
                v1 = v4;
                continue
            };
            v3 = v4 - 1;
        };
        let v5 = v0 - days_before_year(v1);
        let v6 = 1;
        while (v6 <= 12) {
            let v7 = days_in_month(v1, v6);
            if (v5 < v7) {
                break
            };
            v5 = v5 - v7;
            v6 = v6 + 1;
        };
        assert!(v6 <= 12, 3);
        CivilDateTime{
            year      : v1,
            month     : v6,
            day       : ((v5 + 1) as u8),
            ms_of_day : arg0 % 86400000,
        }
    }

    public fun window_end_ms(arg0: &PeriodWindow) : u64 {
        arg0.end_ms
    }

    public fun window_index(arg0: &PeriodWindow) : u64 {
        arg0.index
    }

    public fun window_start_ms(arg0: &PeriodWindow) : u64 {
        arg0.start_ms
    }

    public fun year(arg0: u64) : CalendarPeriod {
        new_period(arg0, 2)
    }

    fun year_boundary(arg0: &CivilDateTime, arg1: u64) : u64 {
        let v0 = checked_add(arg0.year, arg1);
        civil_to_timestamp(v0, arg0.month, (0x1::u64::min((arg0.day as u64), days_in_month(v0, arg0.month)) as u8), arg0.ms_of_day)
    }

    public fun year_unit() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

