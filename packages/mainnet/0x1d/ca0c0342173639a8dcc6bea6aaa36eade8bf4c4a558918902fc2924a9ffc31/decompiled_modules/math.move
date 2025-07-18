module 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::math {
    public fun is_zero_for_one(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : bool {
        if (arg2 <= arg3) {
            return false
        };
        if (arg2 >= arg4) {
            return true
        };
        let v0 = (arg2 as u256);
        let v1 = (arg4 as u256);
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::safe_math::mul_div_Q64(0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::safe_math::mul_div_Q64((arg0 as u256), v0), v0 - (arg3 as u256)) > (arg1 as u256) * (v1 - v0) / v1
    }

    // decompiled from Move bytecode v6
}

