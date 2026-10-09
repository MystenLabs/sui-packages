module 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::stream_math {
    public fun acc_after(arg0: u256, arg1: u64, arg2: u64) : u256 {
        arg0 + (arg1 as u256) * 1000000000000000000 / (arg2 as u256)
    }

    public fun acc_scale() : u256 {
        1000000000000000000
    }

    public fun accrued(arg0: u64, arg1: u256) : u256 {
        (arg0 as u256) * arg1
    }

    public fun due(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0 || arg3 <= arg1) {
            0
        } else if (arg3 >= arg2) {
            arg0
        } else {
            0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(arg0, arg3 - arg1, arg2 - arg1)
        }
    }

    public fun owed(arg0: u64, arg1: u256, arg2: u256) : u64 {
        (((accrued(arg0, arg1) - arg2) / 1000000000000000000) as u64)
    }

    public fun release(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let v0 = due(arg0, arg2, arg3, arg4);
        let v1 = arg0 - v0;
        let v2 = if (arg4 > arg2) {
            arg4
        } else {
            arg2
        };
        if (arg1 == 0) {
            return (v0, v1, v2, arg3)
        };
        let v3 = v1 + arg1;
        let v4 = if (v1 == 0 || arg3 <= arg4) {
            arg4 + arg5
        } else {
            let v5 = arg3 - arg4;
            if (arg5 >= v5) {
                arg3 + 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div_up(arg1, arg5 - v5, v3)
            } else {
                arg3 - 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(arg1, v5 - arg5, v3)
            }
        };
        (v0, v3, v2, v4)
    }

    // decompiled from Move bytecode v7
}

