module 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::payment {
    struct PaymentConfig has copy, drop, store {
        ticket_cost: u64,
        pot_ratio: 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::Float,
        jackpot_ratio: 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::Float,
    }

    public fun default() : PaymentConfig {
        new(2000000000, 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::from_percent(20), 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::from_percent(30))
    }

    fun err_invalid_ratio_settings() {
        abort 500
    }

    public fun new(arg0: u64, arg1: 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::Float, arg2: 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::Float) : PaymentConfig {
        if (0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::gt(0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::add(arg2, arg1), 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::one())) {
            err_invalid_ratio_settings();
        };
        PaymentConfig{
            ticket_cost   : arg0,
            pot_ratio     : arg1,
            jackpot_ratio : arg2,
        }
    }

    public fun new_u8(arg0: u64, arg1: u8, arg2: u8) : PaymentConfig {
        new(arg0, 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::from_percent(arg1), 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::from_percent(arg2))
    }

    public fun split(arg0: &PaymentConfig) : (u64, u64) {
        let v0 = 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::from(ticket_cost(arg0));
        (0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::floor(0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::mul(v0, arg0.pot_ratio)), 0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::floor(0xa7e47f0887478462c03c01a416a7c0c685ddbabceafaba3c316f0ad94c071d3c::float::mul(v0, arg0.jackpot_ratio)))
    }

    public fun ticket_cost(arg0: &PaymentConfig) : u64 {
        arg0.ticket_cost
    }

    // decompiled from Move bytecode v6
}

