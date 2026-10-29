module 0xa7397ceb1e6ba129bad0ddc1217bbc12b3556029e91489624e09e1bc43e862e2::funding_math {
    public fun accrue_global_index(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : (u128, bool, u64) {
        let v0 = if (arg5 > arg4) {
            ((arg5 - arg4) as u128)
        } else {
            0
        };
        if (v0 == 0) {
            return (arg2, arg3, arg4)
        };
        let v1 = if (v0 < (arg7 as u128)) {
            1
        } else {
            v0 / (arg7 as u128)
        };
        let (v2, v3) = signed_add(arg2, arg3, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg0 * v1, arg6), arg1);
        (v2, v3, arg5)
    }

    fun signed_add(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        let (v0, v1) = if (arg1 == arg3) {
            (arg0 + arg2, arg1)
        } else if (arg0 >= arg2) {
            (arg0 - arg2, arg1)
        } else {
            (arg2 - arg0, arg3)
        };
        if (v0 == 0) {
            (0, true)
        } else {
            (v0, v1)
        }
    }

    // decompiled from Move bytecode v7
}

