module 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::ratio {
    struct Ratio has copy, drop, store {
        num: u64,
        den: u64,
    }

    public fun ratio(arg0: u64, arg1: u64) : Ratio {
        assert!(arg1 != 0, 174001);
        Ratio{
            num : arg0,
            den : arg1,
        }
    }

    public fun den(arg0: &Ratio) : u64 {
        arg0.den
    }

    public fun num(arg0: &Ratio) : u64 {
        arg0.num
    }

    public fun partial(arg0: Ratio, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.num as u128) / (arg0.den as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

