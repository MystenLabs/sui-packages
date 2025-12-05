module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128 {
    struct Int128 has copy, drop, store {
        value: u128,
        negative: bool,
    }

    public fun abs_value(arg0: &Int128) : u128 {
        arg0.value
    }

    public fun add(arg0: Int128, arg1: Int128) : Int128 {
        if (arg0.negative == arg1.negative) {
            let v1 = arg0.value + arg1.value;
            assert!(v1 >= arg0.value, 1);
            Int128{value: v1, negative: arg0.negative}
        } else if (arg0.value >= arg1.value) {
            Int128{value: arg0.value - arg1.value, negative: arg0.negative}
        } else {
            Int128{value: arg1.value - arg0.value, negative: arg1.negative}
        }
    }

    public fun add_u64(arg0: Int128, arg1: u64) : Int128 {
        if (!arg0.negative) {
            let v1 = arg0.value + (arg1 as u128);
            assert!(v1 >= arg0.value, 1);
            Int128{value: v1, negative: false}
        } else if (arg0.value >= (arg1 as u128)) {
            Int128{value: arg0.value - (arg1 as u128), negative: true}
        } else {
            Int128{value: (arg1 as u128) - arg0.value, negative: false}
        }
    }

    public fun compare(arg0: &Int128, arg1: &Int128) : u8 {
        if (arg0.negative && !arg1.negative) {
            2
        } else if (!arg0.negative && arg1.negative) {
            1
        } else if (!arg0.negative && !arg1.negative) {
            if (arg0.value > arg1.value) {
                1
            } else if (arg0.value < arg1.value) {
                2
            } else {
                0
            }
        } else if (arg0.value < arg1.value) {
            1
        } else if (arg0.value > arg1.value) {
            2
        } else {
            0
        }
    }

    public fun compare_u64(arg0: &Int128, arg1: u64) : u8 {
        if (arg0.negative) {
            2
        } else if (arg0.value > (arg1 as u128)) {
            1
        } else if (arg0.value < (arg1 as u128)) {
            2
        } else {
            0
        }
    }

    public fun div_u64(arg0: Int128, arg1: u64) : Int128 {
        assert!(arg1 != 0, 3);
        if (arg0.value == 0) {
            zero()
        } else {
            Int128{value: arg0.value / (arg1 as u128), negative: arg0.negative}
        }
    }

    public fun eq(arg0: &Int128, arg1: &Int128) : bool {
        compare(arg0, arg1) == 0
    }

    public fun eq_u64(arg0: &Int128, arg1: u64) : bool {
        compare_u64(arg0, arg1) == 0
    }

    public fun from_u64(arg0: u64) : Int128 {
        Int128{
            value    : (arg0 as u128),
            negative : false,
        }
    }

    public fun gt(arg0: &Int128, arg1: &Int128) : bool {
        compare(arg0, arg1) == 1
    }

    public fun gt_u64(arg0: &Int128, arg1: u64) : bool {
        compare_u64(arg0, arg1) == 1
    }

    public fun gte(arg0: &Int128, arg1: &Int128) : bool {
        let v0 = compare(arg0, arg1);
        v0 == 0 || v0 == 1
    }

    public fun gte_u64(arg0: &Int128, arg1: u64) : bool {
        let v0 = compare_u64(arg0, arg1);
        v0 == 0 || v0 == 1
    }

    public fun is_negative(arg0: &Int128) : bool {
        arg0.negative && arg0.value != 0
    }

    public fun is_positive(arg0: &Int128) : bool {
        !arg0.negative && arg0.value != 0
    }

    public fun is_zero(arg0: &Int128) : bool {
        arg0.value == 0
    }

    public fun lt(arg0: &Int128, arg1: &Int128) : bool {
        compare(arg0, arg1) == 2
    }

    public fun lt_u64(arg0: &Int128, arg1: u64) : bool {
        compare_u64(arg0, arg1) == 2
    }

    public fun lte(arg0: &Int128, arg1: &Int128) : bool {
        let v0 = compare(arg0, arg1);
        v0 == 0 || v0 == 2
    }

    public fun lte_u64(arg0: &Int128, arg1: u64) : bool {
        let v0 = compare_u64(arg0, arg1);
        v0 == 0 || v0 == 2
    }

    public fun mul(arg0: Int128, arg1: Int128) : Int128 {
        if (arg0.value == 0 || arg1.value == 0) {
            zero()
        } else {
            let v1 = arg0.value * arg1.value;
            assert!(v1 / arg0.value == arg1.value, 1);
            Int128{value: v1, negative: arg0.negative != arg1.negative}
        }
    }

    public fun mul_div_u64(arg0: Int128, arg1: u64, arg2: u64) : Int128 {
        Int128{
            value    : (((arg0.value as u256) * (arg1 as u256) / (arg2 as u256)) as u128),
            negative : arg0.negative,
        }
    }

    public fun mul_u64(arg0: Int128, arg1: u64) : Int128 {
        if (arg0.value == 0 || arg1 == 0) {
            zero()
        } else {
            let v1 = arg0.value * (arg1 as u128);
            assert!(v1 / arg0.value == (arg1 as u128), 1);
            Int128{value: v1, negative: arg0.negative}
        }
    }

    public fun neg_from_u64(arg0: u64) : Int128 {
        if (arg0 == 0) {
            Int128{value: 0, negative: false}
        } else {
            Int128{value: (arg0 as u128), negative: true}
        }
    }

    public fun neg_one() : Int128 {
        Int128{
            value    : 1,
            negative : true,
        }
    }

    public fun negate(arg0: Int128) : Int128 {
        if (arg0.value == 0) {
            arg0
        } else {
            Int128{value: arg0.value, negative: !arg0.negative}
        }
    }

    public fun one() : Int128 {
        Int128{
            value    : 1,
            negative : false,
        }
    }

    public fun sub(arg0: Int128, arg1: Int128) : Int128 {
        add(arg0, negate(arg1))
    }

    public fun sub_u64(arg0: Int128, arg1: u64) : Int128 {
        if (!arg0.negative) {
            if (arg0.value >= (arg1 as u128)) {
                Int128{value: arg0.value - (arg1 as u128), negative: false}
            } else {
                Int128{value: (arg1 as u128) - arg0.value, negative: true}
            }
        } else {
            let v1 = arg0.value + (arg1 as u128);
            assert!(v1 >= arg0.value, 1);
            Int128{value: v1, negative: true}
        }
    }

    public fun to_u128(arg0: Int128) : u128 {
        assert!(!arg0.negative, 2);
        arg0.value
    }

    public fun to_u64(arg0: Int128) : u64 {
        assert!(!arg0.negative, 2);
        (arg0.value as u64)
    }

    public fun zero() : Int128 {
        Int128{
            value    : 0,
            negative : false,
        }
    }

    // decompiled from Move bytecode v6
}

