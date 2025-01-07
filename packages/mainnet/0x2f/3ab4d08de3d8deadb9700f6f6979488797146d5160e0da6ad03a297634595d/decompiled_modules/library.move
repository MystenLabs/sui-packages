module 0x2f3ab4d08de3d8deadb9700f6f6979488797146d5160e0da6ad03a297634595d::library {
    public fun add(arg0: u64, arg1: u64) : u64 {
        assert!(18446744073709551615 - arg0 >= arg1, 0);
        arg0 + arg1
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 2);
        arg0 / arg1
    }

    public fun mod(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 != 0, 2);
        arg0 % arg1
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 0);
        (v0 as u64)
    }

    public fun subtract(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 0);
        arg0 - arg1
    }

    public fun trim_dividend(arg0: u64, arg1: u64) : u64 {
        arg0 - mod(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

