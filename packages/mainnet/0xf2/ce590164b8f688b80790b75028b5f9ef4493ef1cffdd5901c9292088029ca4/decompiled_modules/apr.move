module 0xf2ce590164b8f688b80790b75028b5f9ef4493ef1cffdd5901c9292088029ca4::apr {
    public fun accrue_reward(arg0: u256, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u256, u64, u64) {
        if (arg3 == 0) {
            return (arg0, 0, arg4)
        };
        if (arg1 == 0 || arg2 == 0) {
            return (arg0, arg1, arg3)
        };
        let v0 = realized(0, arg2, arg2 + arg1, arg3, arg4);
        if (v0 == 0) {
            return (arg0, arg1, arg3)
        };
        let v1 = if (v0 > 5000000000000000000) {
            5000000000000000000
        } else {
            v0
        };
        (v1, 0, arg4)
    }

    public fun ratio_from_amounts(arg0: u64, arg1: u64) : u256 {
        if (arg1 == 0) {
            0
        } else {
            (arg0 as u256) * 1000000000000000000 / (arg1 as u256)
        }
    }

    public fun realized(arg0: u256, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u256 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 <= arg1) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 <= arg3
        };
        if (v0) {
            return arg0
        };
        let v1 = arg4 - arg3;
        if (v1 < 3600000) {
            return arg0
        };
        ((arg2 - arg1) as u256) * 31536000000 * 1000000000000000000 / (arg1 as u256) * (v1 as u256)
    }

    public fun update_apr_from_ratio(arg0: u256, arg1: u256, arg2: u64, arg3: u256, arg4: u64) : (u256, u256, u64) {
        if (arg2 == 0) {
            return (arg0, arg3, arg4)
        };
        if (arg4 <= arg2 || arg4 - arg2 < 180000) {
            return (arg0, arg1, arg2)
        };
        let v0 = if (arg1 > 0 && arg3 > arg1) {
            let v1 = (arg3 - arg1) * 31536000000 * 1000000000000000000 / arg1 * ((arg4 - arg2) as u256);
            if (v1 > 10000000000000000000) {
                10000000000000000000
            } else {
                v1
            }
        } else {
            arg0
        };
        (v0, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

