module 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::payment {
    struct PaymentConfig has copy, drop, store {
        ticket_cost: u64,
        pot_ratio: 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::Float,
        jackpot_ratio: 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::Float,
    }

    public fun default() : PaymentConfig {
        new(2000000000, 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::from_percent(20), 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::from_percent(30))
    }

    fun err_invalid_ratio_settings() {
        abort 500
    }

    public fun new(arg0: u64, arg1: 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::Float, arg2: 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::Float) : PaymentConfig {
        if (0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::gt(0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::add(arg2, arg1), 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::one())) {
            err_invalid_ratio_settings();
        };
        PaymentConfig{
            ticket_cost   : arg0,
            pot_ratio     : arg1,
            jackpot_ratio : arg2,
        }
    }

    public fun new_u8(arg0: u64, arg1: u8, arg2: u8) : PaymentConfig {
        new(arg0, 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::from_percent(arg1), 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::from_percent(arg2))
    }

    public fun split(arg0: &PaymentConfig) : (u64, u64) {
        let v0 = 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::from(ticket_cost(arg0));
        (0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::floor(0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::mul(v0, arg0.pot_ratio)), 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::floor(0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::float::mul(v0, arg0.jackpot_ratio)))
    }

    public fun ticket_cost(arg0: &PaymentConfig) : u64 {
        arg0.ticket_cost
    }

    // decompiled from Move bytecode v6
}

