module 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::math {
    public fun is_zero_for_one(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : bool {
        if (arg2 <= arg3) {
            return false
        };
        if (arg2 >= arg4) {
            return true
        };
        0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::mul_div_Q64(0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::mul_div_Q64(arg0, arg2), arg2 - arg3) > arg1 * (arg4 - arg2) / arg4
    }

    // decompiled from Move bytecode v6
}

