module 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::math {
    public fun is_zero_for_one(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : bool {
        if (arg2 <= arg3) {
            return false
        };
        if (arg2 >= arg4) {
            return true
        };
        0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::safe_math::mul_div_Q64(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::safe_math::mul_div_Q64(arg0, arg2), arg2 - arg3) > arg1 * (arg4 - arg2) / arg4
    }

    // decompiled from Move bytecode v6
}

