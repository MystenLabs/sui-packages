module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::calendar {
    fun days_in_month(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 2) {
            if (is_leap(arg0)) {
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

    fun days_since_epoch(arg0: u64) : u64 {
        let v0 = arg0 / 100 % 100;
        let v1 = if (v0 <= 2) {
            arg0 / 10000 - 1
        } else {
            arg0 / 10000
        };
        let v2 = v1 / 400;
        let v3 = v1 - v2 * 400;
        v2 * 146097 + v3 * 365 + v3 / 4 - v3 / 100 + (153 * (v0 + 9) % 12 + 2) / 5 + arg0 % 100 - 1 - 719468
    }

    fun is_leap(arg0: u64) : bool {
        arg0 % 4 == 0 && arg0 % 100 != 0 || arg0 % 400 == 0
    }

    public(friend) fun is_valid_date(arg0: u64) : bool {
        let v0 = arg0 / 10000;
        let v1 = arg0 / 100 % 100;
        let v2 = arg0 % 100;
        if (v0 < 1 || v0 > 9999) {
            return false
        };
        if (v1 < 1 || v1 > 12) {
            return false
        };
        v2 >= 1 && v2 <= days_in_month(v0, v1)
    }

    public(friend) fun is_within_one_day_of(arg0: u64, arg1: u64) : bool {
        if (!is_valid_date(arg0)) {
            return false
        };
        if (arg0 / 10000 < 1970) {
            return false
        };
        let v0 = days_since_epoch(arg0);
        let v1 = arg1 / 86400000;
        v0 + 1 >= v1 && v0 <= v1 + 1
    }

    // decompiled from Move bytecode v7
}

