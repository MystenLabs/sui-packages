module 0x1f1ea24fb8782f79d1bc67c07e228246fdee3a8cbc0ed1b6c9697d97cab2a9fb::bluefin_adapter {
    public fun apply_fee(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            arg0 - arg0 * arg1 / 1000000
        } else {
            arg0 + arg0 * arg1 / 1000000
        }
    }

    public fun get_disabled_price_data() : (u64, u64) {
        (0, 0)
    }

    public fun is_enabled() : bool {
        false
    }

    public fun is_inverse_price() : bool {
        false
    }

    public fun sqrt_price_to_price(arg0: u128) : u64 {
        let v0 = (arg0 as u256);
        ((v0 * v0 * 1000000000 / 340282366920938463463374607431768211456 / 1000) as u64)
    }

    public fun supports_lp() : bool {
        true
    }

    public fun venue_id() : u8 {
        2
    }

    public fun venue_name() : vector<u8> {
        b"Bluefin"
    }

    // decompiled from Move bytecode v6
}

