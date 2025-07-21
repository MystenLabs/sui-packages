module 0xb2f2a777c55d13590b1ea380b7762ca8af723a92a7d241bd57924e7929ccafb4::float {
    struct Float has copy, drop, store {
        value: u128,
    }

    public fun add(arg0: Float, arg1: Float) : Float {
        Float{value: arg0.value + arg1.value}
    }

    public fun add_u64(arg0: Float, arg1: u64) : Float {
        add(arg0, from(arg1))
    }

    public fun ceil(arg0: Float) : u64 {
        (((arg0.value + 1000000000 - 1) / 1000000000) as u64)
    }

    public fun diff(arg0: Float, arg1: Float) : Float {
        if (gte(arg0, arg1)) {
            sub(arg0, arg1)
        } else {
            sub(arg1, arg0)
        }
    }

    public fun div(arg0: Float, arg1: Float) : Float {
        if (to_scaled_val(arg1) == 0) {
            err_divided_by_zero();
        };
        Float{value: arg0.value * 1000000000 / arg1.value}
    }

    public fun div_u64(arg0: Float, arg1: u64) : Float {
        div(arg0, from(arg1))
    }

    public fun eq(arg0: Float, arg1: Float) : bool {
        arg0.value == arg1.value
    }

    fun err_divided_by_zero() {
        abort 300
    }

    fun err_subtrahend_too_large() {
        abort 301
    }

    public fun floor(arg0: Float) : u64 {
        ((arg0.value / 1000000000) as u64)
    }

    public fun from(arg0: u64) : Float {
        Float{value: (arg0 as u128) * 1000000000}
    }

    public fun from_bps(arg0: u64) : Float {
        Float{value: (arg0 as u128) * 1000000000 / 10000}
    }

    public fun from_fraction(arg0: u64, arg1: u64) : Float {
        if (arg1 == 0) {
            err_divided_by_zero();
        };
        Float{value: (arg0 as u128) * 1000000000 / (arg1 as u128)}
    }

    public fun from_percent(arg0: u8) : Float {
        Float{value: (arg0 as u128) * 1000000000 / 100}
    }

    public fun from_percent_u64(arg0: u64) : Float {
        Float{value: (arg0 as u128) * 1000000000 / 100}
    }

    public fun from_scaled_val(arg0: u128) : Float {
        Float{value: arg0}
    }

    public fun gt(arg0: Float, arg1: Float) : bool {
        arg0.value > arg1.value
    }

    public fun gte(arg0: Float, arg1: Float) : bool {
        arg0.value >= arg1.value
    }

    public fun lt(arg0: Float, arg1: Float) : bool {
        arg0.value < arg1.value
    }

    public fun lte(arg0: Float, arg1: Float) : bool {
        arg0.value <= arg1.value
    }

    public fun max(arg0: Float, arg1: Float) : Float {
        if (arg0.value > arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: Float, arg1: Float) : Float {
        if (arg0.value < arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: Float, arg1: Float) : Float {
        Float{value: arg0.value * arg1.value / 1000000000}
    }

    public fun mul_u64(arg0: Float, arg1: u64) : Float {
        mul(arg0, from(arg1))
    }

    public fun one() : Float {
        Float{value: 1000000000}
    }

    public fun pow(arg0: Float, arg1: u64) : Float {
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

    public fun round(arg0: Float) : u64 {
        (((arg0.value + 1000000000 / 2) / 1000000000) as u64)
    }

    public fun saturating_sub(arg0: Float, arg1: Float) : Float {
        if (arg0.value < arg1.value) {
            Float{value: 0}
        } else {
            Float{value: arg0.value - arg1.value}
        }
    }

    public fun saturating_sub_u64(arg0: Float, arg1: u64) : Float {
        saturating_sub(arg0, from(arg1))
    }

    public fun sub(arg0: Float, arg1: Float) : Float {
        if (arg1.value > arg0.value) {
            err_subtrahend_too_large();
        };
        Float{value: arg0.value - arg1.value}
    }

    public fun sub_u64(arg0: Float, arg1: u64) : Float {
        sub(arg0, from(arg1))
    }

    public fun ten() : Float {
        from(10)
    }

    public fun to_scaled_val(arg0: Float) : u128 {
        arg0.value
    }

    public fun wad() : u128 {
        1000000000
    }

    public fun zero() : Float {
        Float{value: 0}
    }

    // decompiled from Move bytecode v6
}

