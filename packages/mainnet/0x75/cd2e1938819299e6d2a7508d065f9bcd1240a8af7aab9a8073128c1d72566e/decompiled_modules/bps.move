module 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps {
    struct Bps has copy, drop, store {
        value: u64,
    }

    public fun mul_up(arg0: &Bps, arg1: u64) : u64 {
        ((((arg1 as u128) * (arg0.value as u128) + 9999) / 10000) as u64)
    }

    public fun new(arg0: u64) : Bps {
        assert!(arg0 <= 10000, 1);
        Bps{value: arg0}
    }

    public fun value(arg0: &Bps) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

