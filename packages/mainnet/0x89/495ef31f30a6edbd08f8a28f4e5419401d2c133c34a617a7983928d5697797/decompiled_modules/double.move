module 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double {
    struct Double has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Double, arg1: Double) : Double {
        if (115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1.value < arg0.value) {
            err_number_too_large();
        };
        Double{value: arg0.value + arg1.value}
    }

    public fun add_u64(arg0: Double, arg1: u64) : Double {
        add(arg0, from(arg1))
    }

    public fun ceil(arg0: Double) : u64 {
        (((arg0.value + 1000000000000000000 - 1) / 1000000000000000000) as u64)
    }

    public fun diff(arg0: Double, arg1: Double) : Double {
        if (lte(arg0, arg1)) {
            sub(arg1, arg0)
        } else {
            sub(arg0, arg1)
        }
    }

    public fun div(arg0: Double, arg1: Double) : Double {
        if (arg1.value == 0) {
            err_divided_by_zero();
        };
        Double{value: arg0.value * 1000000000000000000 / arg1.value}
    }

    public fun div_u64(arg0: Double, arg1: u64) : Double {
        if (arg1 == 0) {
            err_divided_by_zero();
        };
        Double{value: arg0.value / (arg1 as u256)}
    }

    public fun eq(arg0: Double, arg1: Double) : bool {
        arg0.value == arg1.value
    }

    fun err_divided_by_zero() {
        abort 301
    }

    fun err_number_too_large() {
        abort 303
    }

    fun err_subtrahend_too_large() {
        abort 302
    }

    public fun floor(arg0: Double) : u64 {
        ((arg0.value / 1000000000000000000) as u64)
    }

    public fun from(arg0: u64) : Double {
        Double{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_bps(arg0: u64) : Double {
        Double{value: (arg0 as u256) * 1000000000000000000 / 10000}
    }

    public fun from_float(arg0: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float) : Double {
        Double{value: (0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::to_scaled_val(arg0) as u256) * 1000000000000000000 / (0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::wad() as u256)}
    }

    public fun from_fraction(arg0: u64, arg1: u64) : Double {
        if (arg1 == 0) {
            err_divided_by_zero();
        };
        Double{value: (arg0 as u256) * 1000000000000000000 / (arg1 as u256)}
    }

    public fun from_percent(arg0: u8) : Double {
        Double{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_percent_u64(arg0: u64) : Double {
        Double{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_scaled_val(arg0: u256) : Double {
        Double{value: arg0}
    }

    public fun gt(arg0: Double, arg1: Double) : bool {
        arg0.value > arg1.value
    }

    public fun gte(arg0: Double, arg1: Double) : bool {
        arg0.value >= arg1.value
    }

    public fun lt(arg0: Double, arg1: Double) : bool {
        arg0.value < arg1.value
    }

    public fun lte(arg0: Double, arg1: Double) : bool {
        arg0.value <= arg1.value
    }

    public fun max(arg0: Double, arg1: Double) : Double {
        if (arg0.value > arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: Double, arg1: Double) : Double {
        if (arg0.value < arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: Double, arg1: Double) : Double {
        if (arg1.value > 0 && 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1.value < arg0.value) {
            err_number_too_large();
        };
        Double{value: arg0.value * arg1.value / 1000000000000000000}
    }

    public fun mul_u64(arg0: Double, arg1: u64) : Double {
        if (arg1 > 0 && 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (arg1 as u256) < arg0.value) {
            err_number_too_large();
        };
        Double{value: arg0.value * (arg1 as u256)}
    }

    public fun one() : Double {
        Double{value: 1000000000000000000}
    }

    public fun pow(arg0: Double, arg1: u64) : Double {
        let v0 = from(1);
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = mul(v0, arg0);
            };
            arg0 = mul(arg0, arg0);
            arg1 = arg1 / 2;
        };
        v0
    }

    public fun round(arg0: Double) : u64 {
        (((arg0.value + 1000000000000000000 / 2) / 1000000000000000000) as u64)
    }

    public fun saturating_sub(arg0: Double, arg1: Double) : Double {
        if (arg0.value < arg1.value) {
            Double{value: 0}
        } else {
            Double{value: arg0.value - arg1.value}
        }
    }

    public fun saturating_sub_u64(arg0: Double, arg1: u64) : Double {
        saturating_sub(arg0, from(arg1))
    }

    public fun sub(arg0: Double, arg1: Double) : Double {
        if (arg1.value > arg0.value) {
            err_subtrahend_too_large();
        };
        Double{value: arg0.value - arg1.value}
    }

    public fun sub_u64(arg0: Double, arg1: u64) : Double {
        sub(arg0, from(arg1))
    }

    public fun ten() : Double {
        from(10)
    }

    public fun to_scaled_val(arg0: Double) : u256 {
        arg0.value
    }

    public fun try_into_float(arg0: Double) : 0x1::option::Option<0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float> {
        let v0 = arg0.value / 1000000000000000000 / (0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::wad() as u256);
        if (v0 <= 340282366920938463463374607431768211455) {
            0x1::option::some<0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_scaled_val((v0 as u128)))
        } else {
            0x1::option::none<0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>()
        }
    }

    public fun wad() : u256 {
        1000000000000000000
    }

    public fun zero() : Double {
        Double{value: 0}
    }

    // decompiled from Move bytecode v6
}

