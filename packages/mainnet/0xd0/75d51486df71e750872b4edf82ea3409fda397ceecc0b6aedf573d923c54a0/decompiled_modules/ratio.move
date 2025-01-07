module 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::ratio {
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

