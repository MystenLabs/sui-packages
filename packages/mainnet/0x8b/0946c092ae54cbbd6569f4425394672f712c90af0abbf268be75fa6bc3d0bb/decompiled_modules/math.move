module 0x8b0946c092ae54cbbd6569f4425394672f712c90af0abbf268be75fa6bc3d0bb::math {
    public fun is_zero_for_one(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : bool {
        if (arg2 <= arg3) {
            return false
        };
        if (arg2 >= arg4) {
            return true
        };
        0x8b0946c092ae54cbbd6569f4425394672f712c90af0abbf268be75fa6bc3d0bb::safe_math::mul_div_Q64(0x8b0946c092ae54cbbd6569f4425394672f712c90af0abbf268be75fa6bc3d0bb::safe_math::mul_div_Q64(arg0, arg2), arg2 - arg3) > arg1 * (arg4 - arg2) / arg4
    }

    // decompiled from Move bytecode v6
}

