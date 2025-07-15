module 0x54c27c524b5519562befb94864aed6d3ec18e9626abaee5a9039380115373a42::math {
    public fun is_zero_for_one(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : bool {
        if (arg2 <= arg3) {
            return false
        };
        if (arg2 >= arg4) {
            return true
        };
        0x54c27c524b5519562befb94864aed6d3ec18e9626abaee5a9039380115373a42::safe_math::mul_div_Q64(0x54c27c524b5519562befb94864aed6d3ec18e9626abaee5a9039380115373a42::safe_math::mul_div_Q64(arg0, arg2), arg2 - arg3) > arg1 * (arg4 - arg2) / arg4
    }

    // decompiled from Move bytecode v6
}

