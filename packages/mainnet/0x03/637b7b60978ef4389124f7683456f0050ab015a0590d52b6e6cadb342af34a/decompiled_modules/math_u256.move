module 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u256 {
    public fun add_check(arg0: u256, arg1: u256) : bool {
        115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0 >= arg1
    }

    public fun checked_shlw(arg0: u256) : (u256, bool) {
        if (arg0 >= 6277101735386680763835789423207666416102355444464034512896) {
            (0, true)
        } else {
            (arg0 << 64, false)
        }
    }

    public fun div_mod(arg0: u256, arg1: u256) : (u256, u256) {
        let v0 = arg0 / arg1;
        (v0, arg0 - v0 * arg1)
    }

    public fun div_round(arg0: u256, arg1: u256, arg2: bool) : u256 {
        let v0 = arg0 / arg1;
        if (arg2 && v0 * arg1 != arg0) {
            v0 + 1
        } else {
            v0
        }
    }

    public fun shlw(arg0: u256) : u256 {
        arg0 << 64
    }

    public fun shrw(arg0: u256) : u256 {
        arg0 >> 64
    }

    // decompiled from Move bytecode v6
}

