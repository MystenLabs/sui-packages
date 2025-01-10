module 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double {
    struct Float has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Float, arg1: Float) : Float {
        Float{value: arg0.value + arg1.value}
    }

    public fun add_u64(arg0: Float, arg1: u64) : Float {
        add(arg0, from(arg1))
    }

    public fun ceil(arg0: Float) : u64 {
        (((arg0.value + 1000000000000000000 - 1) / 1000000000000000000) as u64)
    }

    public fun div(arg0: Float, arg1: Float) : Float {
        if (to_scaled_val(arg1) == 0) {
            err_divided_by_zero();
        };
        Float{value: arg0.value * 1000000000000000000 / arg1.value}
    }

    public fun div_u64(arg0: Float, arg1: u64) : Float {
        div(arg0, from(arg1))
    }

    public fun eq(arg0: Float, arg1: Float) : bool {
        arg0.value == arg1.value
    }

    fun err_divided_by_zero() {
        abort 0
    }

    fun err_subtrahend_too_large() {
        abort 1
    }

    public fun floor(arg0: Float) : u64 {
        ((arg0.value / 1000000000000000000) as u64)
    }

    public fun from(arg0: u64) : Float {
        Float{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_bps(arg0: u64) : Float {
        Float{value: (arg0 as u256) * 1000000000000000000 / 10000}
    }

    public fun from_fraction(arg0: u64, arg1: u64) : Float {
        if (arg1 == 0) {
            err_divided_by_zero();
        };
        Float{value: (arg0 as u256) * 1000000000000000000 / (arg1 as u256)}
    }

    public fun from_percent(arg0: u8) : Float {
        Float{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_percent_u64(arg0: u64) : Float {
        Float{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_scaled_val(arg0: u256) : Float {
        Float{value: arg0}
    }

    public fun ge(arg0: Float, arg1: Float) : bool {
        arg0.value >= arg1.value
    }

    public fun gt(arg0: Float, arg1: Float) : bool {
        arg0.value > arg1.value
    }

    public fun le(arg0: Float, arg1: Float) : bool {
        arg0.value <= arg1.value
    }

    public fun lt(arg0: Float, arg1: Float) : bool {
        arg0.value < arg1.value
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
        Float{value: arg0.value * arg1.value / 1000000000000000000}
    }

    public fun mul_u64(arg0: Float, arg1: u64) : Float {
        mul(arg0, from(arg1))
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

    public fun to_scaled_val(arg0: Float) : u256 {
        arg0.value
    }

    public fun wad() : u256 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

