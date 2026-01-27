module 0x274972066426f62c573c7f21a50ef18405d8fac1ac50b9f561c8fb9d7f03ab52::mmt_adapter {
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
        true
    }

    public fun sqrt_price_to_price(arg0: u128) : u64 {
        let v0 = (arg0 as u256);
        ((340282366920938463463374607431768211456000000000 / v0 / v0) as u64)
    }

    public fun supports_lp() : bool {
        false
    }

    public fun venue_id() : u8 {
        3
    }

    public fun venue_name() : vector<u8> {
        b"MMT"
    }

    // decompiled from Move bytecode v6
}

