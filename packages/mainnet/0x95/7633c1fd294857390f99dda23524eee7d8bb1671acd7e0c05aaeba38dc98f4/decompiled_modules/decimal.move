module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal {
    struct Decimal has copy, drop, store {
        value: u128,
        neg: bool,
    }

    public fun add(arg0: &Decimal, arg1: &Decimal) : Decimal {
        if (arg0.neg && arg1.neg) {
            let v1 = add_internal(arg0, arg1);
            v1.neg = true;
            v1
        } else if (arg0.neg) {
            sub_internal(arg1, arg0)
        } else if (arg1.neg) {
            sub_internal(arg0, arg1)
        } else {
            add_internal(arg0, arg1)
        }
    }

    fun add_internal(arg0: &Decimal, arg1: &Decimal) : Decimal {
        new(arg0.value + arg1.value, false)
    }

    public fun add_mut(arg0: &mut Decimal, arg1: &Decimal) {
        *arg0 = add(arg0, arg1);
    }

    public fun dec(arg0: &Decimal) : u8 {
        18
    }

    public fun equals(arg0: &Decimal, arg1: &Decimal) : bool {
        arg0.value == arg1.value && arg0.neg == arg1.neg
    }

    public fun gt(arg0: &Decimal, arg1: &Decimal) : bool {
        if (arg0.neg && arg1.neg) {
            return arg0.value < arg1.value
        };
        if (arg0.neg) {
            return false
        };
        if (arg1.neg) {
            return true
        };
        arg0.value > arg1.value
    }

    public fun lt(arg0: &Decimal, arg1: &Decimal) : bool {
        if (arg0.neg && arg1.neg) {
            return arg0.value > arg1.value
        };
        if (arg0.neg) {
            return true
        };
        if (arg1.neg) {
            return false
        };
        arg0.value < arg1.value
    }

    public fun max(arg0: &Decimal, arg1: &Decimal) : Decimal {
        if (gt(arg0, arg1)) {
            *arg0
        } else {
            *arg1
        }
    }

    public fun max_value() : Decimal {
        Decimal{
            value : 340282366920938463463374607431768211455,
            neg   : false,
        }
    }

    public fun min(arg0: &Decimal, arg1: &Decimal) : Decimal {
        if (lt(arg0, arg1)) {
            *arg0
        } else {
            *arg1
        }
    }

    public fun neg(arg0: &Decimal) : bool {
        arg0.neg
    }

    public fun new(arg0: u128, arg1: bool) : Decimal {
        Decimal{
            value : arg0,
            neg   : arg1,
        }
    }

    public fun pow_10(arg0: u8) : u128 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    public fun scale_to_decimals(arg0: &Decimal, arg1: u8) : u128 {
        if (arg1 < 18) {
            return arg0.value * pow_10(18 - arg1)
        };
        arg0.value / pow_10(arg1 - 18)
    }

    public fun sub(arg0: &Decimal, arg1: &Decimal) : Decimal {
        if (arg0.neg && arg1.neg) {
            sub_internal(arg1, arg0)
        } else if (arg0.neg) {
            let v1 = add_internal(arg0, arg1);
            v1.neg = true;
            v1
        } else if (arg1.neg) {
            add_internal(arg0, arg1)
        } else {
            sub_internal(arg0, arg1)
        }
    }

    fun sub_internal(arg0: &Decimal, arg1: &Decimal) : Decimal {
        if (arg1.value > arg0.value) {
            new(arg1.value - arg0.value, true)
        } else {
            new(arg0.value - arg1.value, false)
        }
    }

    public fun sub_mut(arg0: &mut Decimal, arg1: &Decimal) {
        *arg0 = sub(arg0, arg1);
    }

    public fun unpack(arg0: Decimal) : (u128, bool) {
        let Decimal {
            value : v0,
            neg   : v1,
        } = arg0;
        (v0, v1)
    }

    public fun value(arg0: &Decimal) : u128 {
        arg0.value
    }

    public fun zero() : Decimal {
        Decimal{
            value : 0,
            neg   : false,
        }
    }

    // decompiled from Move bytecode v6
}

