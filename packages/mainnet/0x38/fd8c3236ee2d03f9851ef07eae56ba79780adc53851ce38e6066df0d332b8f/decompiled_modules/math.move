module 0x38fd8c3236ee2d03f9851ef07eae56ba79780adc53851ce38e6066df0d332b8f::math {
    public fun is_zero_for_one(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : bool {
        if (arg2 <= arg3) {
            return false
        };
        if (arg2 >= arg4) {
            return true
        };
        0x38fd8c3236ee2d03f9851ef07eae56ba79780adc53851ce38e6066df0d332b8f::safe_math::mul_div_Q64(0x38fd8c3236ee2d03f9851ef07eae56ba79780adc53851ce38e6066df0d332b8f::safe_math::mul_div_Q64(arg0, arg2), arg2 - arg3) > arg1 * (arg4 - arg2) / arg4
    }

    // decompiled from Move bytecode v6
}

