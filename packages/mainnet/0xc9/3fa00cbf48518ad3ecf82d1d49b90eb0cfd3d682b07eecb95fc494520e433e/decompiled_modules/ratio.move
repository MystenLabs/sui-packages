module 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio {
    struct Ratio has copy, drop, store {
        num: u64,
        den: u64,
    }

    public fun ratio(arg0: u64, arg1: u64) : Ratio {
        assert!(arg1 != 0, 101001);
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

