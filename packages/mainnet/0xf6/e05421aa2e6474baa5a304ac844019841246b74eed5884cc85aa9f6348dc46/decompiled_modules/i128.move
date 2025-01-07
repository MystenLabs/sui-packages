module 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128 {
    struct I128 has copy, drop, store {
        sign: u8,
        value: u128,
    }

    public fun add(arg0: I128, arg1: I128) : I128 {
        let v0 = zero();
        let v1 = arg0.sign;
        let v2 = arg1.sign;
        let v3 = arg0.value;
        let v4 = arg1.value;
        if (v1 != v2) {
            if (v3 != v4) {
                if (v3 > v4) {
                    v0.sign = v1;
                    v0.value = v3 - v4;
                } else {
                    v0.sign = v2;
                    v0.value = v4 - v3;
                };
            };
        } else {
            v0.sign = v1;
            assert!(v4 < 340282366920938463463374607431768211455 - v3, 0);
            v0.value = v3 + v4;
        };
        v0
    }

    public fun div(arg0: I128, arg1: I128) : I128 {
        let v0 = zero();
        let v1 = arg1.value;
        assert!(v1 > 0, 1);
        v0.value = arg0.value / v1;
        if (arg0.sign != arg1.sign && v0.value != 0) {
            v0.sign = 1;
        };
        v0
    }

    public fun is_negative(arg0: I128) : bool {
        arg0.sign == 1
    }

    public fun is_zero(arg0: I128) : bool {
        arg0.value == 0
    }

    public fun mul(arg0: I128, arg1: I128) : I128 {
        let v0 = zero();
        let v1 = arg0.value;
        let v2 = arg1.value;
        assert!(v2 < 340282366920938463463374607431768211455 / v1, 0);
        v0.value = v1 * v2;
        if (arg0.sign != arg1.sign && v0.value != 0) {
            v0.sign = 1;
        };
        v0
    }

    fun new(arg0: u8, arg1: u128) : I128 {
        I128{
            sign  : arg0,
            value : arg1,
        }
    }

    public fun new_negative(arg0: u128) : I128 {
        new(1, arg0)
    }

    public fun new_positve(arg0: u128) : I128 {
        new(0, arg0)
    }

    public fun opposite_sign(arg0: I128) : I128 {
        let v0 = new(arg0.sign, arg0.value);
        if (v0.sign == 0) {
            v0.sign = 1;
        } else {
            v0.sign = 0;
        };
        v0
    }

    public fun sign(arg0: I128) : u8 {
        arg0.sign
    }

    public fun sub(arg0: I128, arg1: I128) : I128 {
        add(arg0, opposite_sign(arg1))
    }

    public fun value(arg0: I128) : u128 {
        arg0.value
    }

    public fun zero() : I128 {
        new(0, 0)
    }

    // decompiled from Move bytecode v6
}

