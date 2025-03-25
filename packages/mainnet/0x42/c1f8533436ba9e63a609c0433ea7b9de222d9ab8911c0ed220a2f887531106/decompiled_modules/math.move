module 0x42c1f8533436ba9e63a609c0433ea7b9de222d9ab8911c0ed220a2f887531106::math {
    public(friend) fun amount_to_usd(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (((arg0 as u128) * (arg2 as u128) / (multiplier(arg3) as u128) * (multiplier(9) as u128) / (multiplier(arg1) as u128)) as u64)
    }

    public(friend) fun get_funding_rate_decimal() : u64 {
        9
    }

    public fun get_u64_vector_value(arg0: &vector<u64>, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(arg0) > arg1) {
            return *0x1::vector::borrow<u64>(arg0, arg1)
        };
        0
    }

    public(friend) fun get_usd_decimal() : u64 {
        9
    }

    public(friend) fun multiplier(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    public fun set_u64_vector_value(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        while (0x1::vector::length<u64>(arg0) < arg1 + 1) {
            0x1::vector::push_back<u64>(arg0, 0);
        };
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = arg2;
    }

    public(friend) fun usd_to_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        (((arg0 as u128) * (multiplier(arg3) as u128) / (arg2 as u128) * (multiplier(arg1) as u128) / (multiplier(9) as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

