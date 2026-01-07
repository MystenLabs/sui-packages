module 0x1c970a3954f4ee4dadb937196910bc401974640b0830cd70f9554b4783c55e6e::turbos_adapter {
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
        1
    }

    public fun venue_name() : vector<u8> {
        b"Turbos"
    }

    // decompiled from Move bytecode v6
}

