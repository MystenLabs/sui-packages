module 0x5da09d43eedecd80e83dff441ba80a3651de5beb99128b680e8c2638ea483551::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            abort 0
        };
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        if (v0 > (18446744073709551615 as u128)) {
            abort 1
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

