module 0xecccea1fe572ddfd23b01b1ff7dce49dac087a9f04ebb039f14fc9f22d58984::inv_sizing {
    public(friend) fun apply_multiplier(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64) / arg2 * arg2;
        if (v1 > 0 && v1 < arg3) {
            arg3
        } else {
            v1
        }
    }

    public(friend) fun compute_multipliers(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (u64, u64) {
        if (arg0 == 0 && arg1 == 0) {
            return (10000, 10000)
        };
        if (arg2 == 0 || arg3 == 0) {
            return (10000, 10000)
        };
        let v0 = (arg0 as u128) * (arg2 as u128);
        let v1 = v0 + (arg1 as u128) * (arg3 as u128);
        if (v1 == 0) {
            return (10000, 10000)
        };
        let v2 = ((v0 * 10000 / v1) as u64);
        let (v3, v4) = if (v2 >= arg4) {
            (v2 - arg4, true)
        } else {
            (arg4 - v2, false)
        };
        if (v3 < 100) {
            return (10000, 10000)
        };
        let v5 = arg8 * 10000 / 100;
        let v6 = arg7 * 10000 / 100;
        let v7 = arg5 * v3 / 100;
        let v8 = if (10000 + v7 > v5) {
            v5
        } else {
            10000 + v7
        };
        let v9 = arg6 * v3 / 100;
        let v10 = if (v9 >= 10000) {
            v6
        } else if (10000 - v9 < v6) {
            v6
        } else {
            10000 - v9
        };
        if (v4) {
            (v10, v8)
        } else {
            (v8, v10)
        }
    }

    public(friend) fun scale() : u64 {
        10000
    }

    // decompiled from Move bytecode v6
}

