module 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::payment {
    struct PaymentConfig has copy, drop, store {
        ticket_cost: u64,
        pot_ratio: 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::Float,
        jackpot_ratio: 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::Float,
    }

    public fun check_and_split<T0>(arg0: &PaymentConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) != arg0.ticket_cost) {
            err_not_enough_payment();
        };
        let v0 = 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::from(0x2::coin::value<T0>(&arg1));
        (0x2::coin::split<T0>(&mut arg1, 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::floor(0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::mul(v0, arg0.pot_ratio)), arg2), 0x2::coin::split<T0>(&mut arg1, 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::floor(0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::mul(v0, arg0.jackpot_ratio)), arg2), arg1)
    }

    public fun default() : PaymentConfig {
        new(2000000, 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::from_percent(20), 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::from_percent(30))
    }

    fun err_invalid_ratio_settings() {
        abort 0
    }

    fun err_not_enough_payment() {
        abort 1
    }

    public fun new(arg0: u64, arg1: 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::Float, arg2: 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::Float) : PaymentConfig {
        if (0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::gt(0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::add(arg2, arg1), 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::one())) {
            err_invalid_ratio_settings();
        };
        PaymentConfig{
            ticket_cost   : arg0,
            pot_ratio     : arg1,
            jackpot_ratio : arg2,
        }
    }

    public fun new_u64(arg0: u64, arg1: u8, arg2: u8) : PaymentConfig {
        new(arg0, 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::from_percent(arg1), 0xdcf96cb6435abead12decb0867a03feabfaf9264308a335feb94b83f5b573282::float::from_percent(arg2))
    }

    public fun ticket_cost(arg0: &PaymentConfig) : u64 {
        arg0.ticket_cost
    }

    // decompiled from Move bytecode v6
}

