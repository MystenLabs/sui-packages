module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u256 {
    public fun checked_shlw(arg0: u256) : (u256, bool) {
        if (arg0 > 115792089237316195417293883273301227089434195242432897623355228563449095127040) {
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

