module 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::payment {
    struct PaymentConfig has copy, drop, store {
        ticket_cost: u64,
        pot_ratio: 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::Float,
        jackpot_ratio: 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::Float,
    }

    public fun default() : PaymentConfig {
        new(2000000000, 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::from_percent(20), 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::from_percent(30))
    }

    fun err_invalid_ratio_settings() {
        abort 500
    }

    public fun new(arg0: u64, arg1: 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::Float, arg2: 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::Float) : PaymentConfig {
        if (0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::gt(0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::add(arg2, arg1), 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::one())) {
            err_invalid_ratio_settings();
        };
        PaymentConfig{
            ticket_cost   : arg0,
            pot_ratio     : arg1,
            jackpot_ratio : arg2,
        }
    }

    public fun new_u8(arg0: u64, arg1: u8, arg2: u8) : PaymentConfig {
        new(arg0, 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::from_percent(arg1), 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::from_percent(arg2))
    }

    public fun split(arg0: &PaymentConfig) : (u64, u64) {
        let v0 = 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::from(ticket_cost(arg0));
        (0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::floor(0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::mul(v0, arg0.pot_ratio)), 0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::floor(0x42fa5d48f7e4850753aeb99c15eb760b1816badf94e68e81249616255ca95be6::float::mul(v0, arg0.jackpot_ratio)))
    }

    public fun ticket_cost(arg0: &PaymentConfig) : u64 {
        arg0.ticket_cost
    }

    // decompiled from Move bytecode v6
}

