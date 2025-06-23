module 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::sdecimal {
    struct SDecimal has copy, drop, store {
        is_positive: bool,
        value: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::Decimal,
    }

    public fun add(arg0: SDecimal, arg1: SDecimal) : SDecimal {
        if (is_zero(&arg0)) {
            return arg1
        };
        if (is_zero(&arg1)) {
            return arg0
        };
        let (v0, v1) = if (arg0.is_positive == arg1.is_positive) {
            (arg0.is_positive, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::add(arg0.value, arg1.value))
        } else if (0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::gt(&arg0.value, &arg1.value)) {
            (arg0.is_positive, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::sub(arg0.value, arg1.value))
        } else {
            (arg1.is_positive, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::sub(arg1.value, arg0.value))
        };
        SDecimal{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun div(arg0: SDecimal, arg1: SDecimal) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive == arg1.is_positive,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::div(arg0.value, arg1.value),
        }
    }

    public fun div_by_rate(arg0: SDecimal, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::rate::Rate) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::div_by_rate(arg0.value, arg1),
        }
    }

    public fun div_by_u64(arg0: SDecimal, arg1: u64) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::div_by_u64(arg0.value, arg1),
        }
    }

    public fun eq(arg0: &SDecimal, arg1: &SDecimal) : bool {
        0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::eq(&arg0.value, &arg1.value) && (is_zero(arg0) || arg0.is_positive == arg1.is_positive)
    }

    public fun is_zero(arg0: &SDecimal) : bool {
        0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::is_zero(&arg0.value)
    }

    public fun mul(arg0: SDecimal, arg1: SDecimal) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive == arg1.is_positive,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::mul(arg0.value, arg1.value),
        }
    }

    public fun mul_with_rate(arg0: SDecimal, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::rate::Rate) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::mul_with_rate(arg0.value, arg1),
        }
    }

    public fun mul_with_u64(arg0: SDecimal, arg1: u64) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::mul_with_u64(arg0.value, arg1),
        }
    }

    public fun sub(arg0: SDecimal, arg1: SDecimal) : SDecimal {
        if (is_zero(&arg0)) {
            return from_decimal(!arg1.is_positive, arg1.value)
        };
        if (is_zero(&arg1)) {
            return arg0
        };
        let (v0, v1) = if (arg0.is_positive != arg1.is_positive) {
            (arg0.is_positive, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::add(arg0.value, arg1.value))
        } else if (0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::gt(&arg0.value, &arg1.value)) {
            (arg0.is_positive, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::sub(arg0.value, arg1.value))
        } else {
            (!arg0.is_positive, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::sub(arg1.value, arg0.value))
        };
        SDecimal{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun zero() : SDecimal {
        SDecimal{
            is_positive : true,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::zero(),
        }
    }

    public fun add_with_decimal(arg0: SDecimal, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::Decimal) : SDecimal {
        if (is_zero(&arg0)) {
            return from_decimal(true, arg1)
        };
        let (v0, v1) = if (arg0.is_positive) {
            (true, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::add(arg0.value, arg1))
        } else if (0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::gt(&arg0.value, &arg1)) {
            (false, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::sub(arg0.value, arg1))
        } else {
            (true, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::sub(arg1, arg0.value))
        };
        SDecimal{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun div_by_decimal(arg0: SDecimal, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::Decimal) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::div(arg0.value, arg1),
        }
    }

    public fun div_by_srate(arg0: SDecimal, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::SRate) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive == 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::is_positive(&arg1),
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::div_by_rate(arg0.value, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::value(&arg1)),
        }
    }

    public fun from_decimal(arg0: bool, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::Decimal) : SDecimal {
        SDecimal{
            is_positive : arg0,
            value       : arg1,
        }
    }

    public fun from_srate(arg0: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::SRate) : SDecimal {
        SDecimal{
            is_positive : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::is_positive(&arg0),
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::from_rate(0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::value(&arg0)),
        }
    }

    public fun is_positive(arg0: &SDecimal) : bool {
        arg0.is_positive
    }

    public fun mul_with_decimal(arg0: SDecimal, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::Decimal) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::mul(arg0.value, arg1),
        }
    }

    public fun mul_with_srate(arg0: SDecimal, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::SRate) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive == 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::is_positive(&arg1),
            value       : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::mul_with_rate(arg0.value, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::value(&arg1)),
        }
    }

    public fun sub_with_decimal(arg0: SDecimal, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::Decimal) : SDecimal {
        if (is_zero(&arg0)) {
            return from_decimal(false, arg1)
        };
        let (v0, v1) = if (arg0.is_positive) {
            if (0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::gt(&arg0.value, &arg1)) {
                (true, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::sub(arg0.value, arg1))
            } else {
                (false, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::sub(arg1, arg0.value))
            }
        } else {
            (false, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::add(arg0.value, arg1))
        };
        SDecimal{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun to_srate(arg0: SDecimal) : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::SRate {
        0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::srate::from_rate(arg0.is_positive, 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::to_rate(arg0.value))
    }

    public fun value(arg0: &SDecimal) : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::decimal::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

