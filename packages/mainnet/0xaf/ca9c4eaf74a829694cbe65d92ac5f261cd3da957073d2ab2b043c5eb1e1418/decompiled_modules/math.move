module 0xafca9c4eaf74a829694cbe65d92ac5f261cd3da957073d2ab2b043c5eb1e1418::math {
    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 1000000;
        if (v0 > 18446744073709551615) {
            abort 1
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

