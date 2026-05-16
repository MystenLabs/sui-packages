module 0x7fb4bb8fc904a235806734ae0eb3c205fa7ac283c60633ede8be75f2056c7645::math_u256 {
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

