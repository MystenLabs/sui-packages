module 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::sdecimal {
    struct SDecimal has copy, drop, store {
        is_positive: bool,
        value: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal,
    }

    public fun add(arg0: SDecimal, arg1: SDecimal) : SDecimal {
        if (is_zero(&arg0)) {
            return arg1
        };
        if (is_zero(&arg1)) {
            return arg0
        };
        let (v0, v1) = if (arg0.is_positive == arg1.is_positive) {
            (arg0.is_positive, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::add(arg0.value, arg1.value))
        } else if (0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::gt(&arg0.value, &arg1.value)) {
            (arg0.is_positive, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::sub(arg0.value, arg1.value))
        } else {
            (arg1.is_positive, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::sub(arg1.value, arg0.value))
        };
        SDecimal{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun div(arg0: SDecimal, arg1: SDecimal) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive == arg1.is_positive,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::div(arg0.value, arg1.value),
        }
    }

    public fun div_by_rate(arg0: SDecimal, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::div_by_rate(arg0.value, arg1),
        }
    }

    public fun div_by_u64(arg0: SDecimal, arg1: u64) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::div_by_u64(arg0.value, arg1),
        }
    }

    public fun is_zero(arg0: &SDecimal) : bool {
        0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::is_zero(&arg0.value)
    }

    public fun mul(arg0: SDecimal, arg1: SDecimal) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive == arg1.is_positive,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::mul(arg0.value, arg1.value),
        }
    }

    public fun mul_with_rate(arg0: SDecimal, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::mul_with_rate(arg0.value, arg1),
        }
    }

    public fun mul_with_u64(arg0: SDecimal, arg1: u64) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::mul_with_u64(arg0.value, arg1),
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
            (arg0.is_positive, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::add(arg0.value, arg1.value))
        } else if (0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::gt(&arg0.value, &arg1.value)) {
            (arg0.is_positive, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::sub(arg0.value, arg1.value))
        } else {
            (!arg0.is_positive, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::sub(arg1.value, arg0.value))
        };
        SDecimal{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun zero() : SDecimal {
        SDecimal{
            is_positive : true,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::zero(),
        }
    }

    public fun add_with_decimal(arg0: SDecimal, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal) : SDecimal {
        if (is_zero(&arg0)) {
            return from_decimal(true, arg1)
        };
        let (v0, v1) = if (arg0.is_positive) {
            (true, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::add(arg0.value, arg1))
        } else if (0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::gt(&arg0.value, &arg1)) {
            (false, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::sub(arg0.value, arg1))
        } else {
            (true, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::sub(arg1, arg0.value))
        };
        SDecimal{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun div_by_decimal(arg0: SDecimal, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::div(arg0.value, arg1),
        }
    }

    public fun div_by_srate(arg0: SDecimal, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::SRate) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive == 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::is_positive(&arg1),
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::div_by_rate(arg0.value, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::value(&arg1)),
        }
    }

    public fun from_decimal(arg0: bool, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal) : SDecimal {
        SDecimal{
            is_positive : arg0,
            value       : arg1,
        }
    }

    public fun from_srate(arg0: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::SRate) : SDecimal {
        SDecimal{
            is_positive : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::is_positive(&arg0),
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::from_rate(0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::value(&arg0)),
        }
    }

    public fun is_positive(arg0: &SDecimal) : bool {
        arg0.is_positive
    }

    public fun mul_with_decimal(arg0: SDecimal, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive,
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::mul(arg0.value, arg1),
        }
    }

    public fun mul_with_srate(arg0: SDecimal, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::SRate) : SDecimal {
        SDecimal{
            is_positive : arg0.is_positive == 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::is_positive(&arg1),
            value       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::mul_with_rate(arg0.value, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::value(&arg1)),
        }
    }

    public fun sub_with_decimal(arg0: SDecimal, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal) : SDecimal {
        if (is_zero(&arg0)) {
            return from_decimal(false, arg1)
        };
        let (v0, v1) = if (arg0.is_positive) {
            if (0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::gt(&arg0.value, &arg1)) {
                (true, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::sub(arg0.value, arg1))
            } else {
                (false, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::sub(arg1, arg0.value))
            }
        } else {
            (false, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::add(arg0.value, arg1))
        };
        SDecimal{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun to_srate(arg0: SDecimal) : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::SRate {
        0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::from_rate(arg0.is_positive, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::to_rate(arg0.value))
    }

    public fun value(arg0: &SDecimal) : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

