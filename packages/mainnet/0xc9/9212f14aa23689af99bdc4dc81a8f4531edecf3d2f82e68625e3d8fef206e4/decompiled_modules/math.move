module 0xc99212f14aa23689af99bdc4dc81a8f4531edecf3d2f82e68625e3d8fef206e4::math {
    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 1000000;
        if (v0 > 18446744073709551615) {
            abort 1
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

