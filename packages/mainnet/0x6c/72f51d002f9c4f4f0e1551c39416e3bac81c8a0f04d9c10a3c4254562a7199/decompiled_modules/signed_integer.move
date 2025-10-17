module 0x6c72f51d002f9c4f4f0e1551c39416e3bac81c8a0f04d9c10a3c4254562a7199::signed_integer {
    struct I64 has copy, drop, store {
        value: u64,
        is_negative: bool,
    }

    public fun add(arg0: I64, arg1: I64) : I64 {
        if (arg0.is_negative == arg1.is_negative) {
            I64{value: arg0.value + arg1.value, is_negative: arg0.is_negative}
        } else if (arg0.value >= arg1.value) {
            I64{value: arg0.value - arg1.value, is_negative: arg0.is_negative}
        } else {
            I64{value: arg1.value - arg0.value, is_negative: arg1.is_negative}
        }
    }

    public fun as_u64(arg0: &I64) : u64 {
        arg0.value
    }

    public fun compare(arg0: I64, arg1: I64) : u8 {
        if (arg0.is_negative && !arg1.is_negative) {
            return 2
        };
        if (!arg0.is_negative && arg1.is_negative) {
            return 1
        };
        if (!arg0.is_negative) {
            if (arg0.value > arg1.value) {
                return 1
            };
            if (arg0.value < arg1.value) {
                return 2
            };
            return 0
        };
        if (arg0.value < arg1.value) {
            return 1
        };
        if (arg0.value > arg1.value) {
            return 2
        };
        0
    }

    public fun eq(arg0: I64, arg1: I64) : bool {
        compare(arg0, arg1) == 0
    }

    public fun from_u64(arg0: u64) : I64 {
        I64{
            value       : arg0,
            is_negative : false,
        }
    }

    public fun from_u64_negative(arg0: u64) : I64 {
        I64{
            value       : arg0,
            is_negative : true,
        }
    }

    public fun gt(arg0: I64, arg1: I64) : bool {
        compare(arg0, arg1) == 1
    }

    public fun gte(arg0: I64, arg1: I64) : bool {
        let v0 = compare(arg0, arg1);
        v0 == 1 || v0 == 0
    }

    public fun into_parts(arg0: I64) : (u64, bool) {
        (arg0.value, arg0.is_negative)
    }

    public fun is_negative(arg0: I64) : bool {
        arg0.is_negative && arg0.value != 0
    }

    public fun is_positive(arg0: I64) : bool {
        !arg0.is_negative && arg0.value != 0
    }

    public fun is_zero(arg0: I64) : bool {
        arg0.value == 0
    }

    public fun lt(arg0: I64, arg1: I64) : bool {
        compare(arg0, arg1) == 2
    }

    public fun lte(arg0: I64, arg1: I64) : bool {
        let v0 = compare(arg0, arg1);
        v0 == 2 || v0 == 0
    }

    public fun multiply(arg0: I64, arg1: I64) : I64 {
        let v0 = arg0.is_negative != arg1.is_negative && arg0.value * arg1.value != 0;
        I64{
            value       : arg0.value * arg1.value,
            is_negative : v0,
        }
    }

    public fun negate(arg0: I64) : I64 {
        if (arg0.value == 0) {
            zero()
        } else {
            I64{value: arg0.value, is_negative: !arg0.is_negative}
        }
    }

    public fun subtract(arg0: I64, arg1: I64) : I64 {
        add(arg0, negate(arg1))
    }

    public fun value(arg0: &I64) : u64 {
        arg0.value
    }

    public fun zero() : I64 {
        I64{
            value       : 0,
            is_negative : false,
        }
    }

    // decompiled from Move bytecode v6
}

