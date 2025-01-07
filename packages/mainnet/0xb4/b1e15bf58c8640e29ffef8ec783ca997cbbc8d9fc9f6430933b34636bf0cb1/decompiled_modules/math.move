module 0xb4b1e15bf58c8640e29ffef8ec783ca997cbbc8d9fc9f6430933b34636bf0cb1::math {
    public fun div_round(arg0: u64, arg1: u64) : (bool, u64) {
        let (v0, v1) = unsafe_div_round(arg0, arg1);
        assert!(v1 > 0, 1);
        (v0, v1)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_mul_round(arg0, arg1);
        assert!(v1 > 0, 1);
        v1
    }

    public fun mul_round(arg0: u64, arg1: u64) : (bool, u64) {
        let (v0, v1) = unsafe_mul_round(arg0, arg1);
        assert!(v1 > 0, 1);
        (v0, v1)
    }

    public(friend) fun unsafe_div(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_div_round(arg0, arg1);
        v1
    }

    public fun unsafe_div_round(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = true;
        if (v0 * (1000000000 as u128) % v1 == 0) {
            v2 = false;
        };
        (v2, ((v0 * (1000000000 as u128) / v1) as u64))
    }

    public(friend) fun unsafe_mul(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_mul_round(arg0, arg1);
        v1
    }

    public(friend) fun unsafe_mul_round(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = true;
        if (v0 * v1 % 1000000000 == 0) {
            v2 = false;
        };
        (v2, ((v0 * v1 / 1000000000) as u64))
    }

    // decompiled from Move bytecode v6
}

