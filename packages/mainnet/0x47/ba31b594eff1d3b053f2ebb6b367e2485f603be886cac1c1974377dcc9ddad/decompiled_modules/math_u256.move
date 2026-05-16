module 0x47ba31b594eff1d3b053f2ebb6b367e2485f603be886cac1c1974377dcc9ddad::math_u256 {
    public fun checked_shlw(arg0: u256) : (u256, bool) {
        if (arg0 > 115792089237316195417293883273301227089434195242432897623355228563449095127040) {
            (0, true)
        } else {
            (arg0 << 64, false)
        }
    }

    public fun full_mul(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    // decompiled from Move bytecode v7
}

