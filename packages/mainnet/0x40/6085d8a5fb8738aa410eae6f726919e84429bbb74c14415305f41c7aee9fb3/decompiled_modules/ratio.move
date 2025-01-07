module 0x406085d8a5fb8738aa410eae6f726919e84429bbb74c14415305f41c7aee9fb3::ratio {
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

