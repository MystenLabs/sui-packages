module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128 {
    struct S128 has copy, drop, store {
        value: u128,
        sign: bool,
    }

    public(friend) fun add(arg0: S128, arg1: S128) : S128 {
        let (v0, v1) = if (arg0.sign == arg1.sign) {
            (arg0.sign, arg0.value + arg1.value)
        } else if (arg0.value >= arg1.value) {
            (arg0.sign, arg0.value - arg1.value)
        } else {
            (arg1.sign, arg1.value - arg0.value)
        };
        S128{
            value : v1,
            sign  : v0,
        }
    }

    public(friend) fun add_u128(arg0: S128, arg1: u128) : S128 {
        let v0 = arg0.value;
        let v1 = arg0.sign;
        let v2 = v1;
        let v3 = if (v1 == true) {
            v0 + arg1
        } else if (v0 > arg1) {
            v0 - arg1
        } else {
            v2 = true;
            arg1 - v0
        };
        S128{
            value : v3,
            sign  : v2,
        }
    }

    public(friend) fun div_u128(arg0: S128, arg1: u128) : S128 {
        S128{
            value : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(arg0.value, arg1),
            sign  : arg0.sign,
        }
    }

    public(friend) fun from(arg0: u128, arg1: bool) : S128 {
        S128{
            value : arg0,
            sign  : arg1,
        }
    }

    public(friend) fun from_subtraction(arg0: u128, arg1: u128) : S128 {
        if (arg0 > arg1) {
            S128{value: arg0 - arg1, sign: true}
        } else {
            S128{value: arg1 - arg0, sign: false}
        }
    }

    public(friend) fun gt(arg0: S128, arg1: S128) : bool {
        if (arg0.sign && arg1.sign) {
            return arg0.value > arg1.value
        };
        if (!arg0.sign && !arg1.sign) {
            return arg0.value < arg1.value
        };
        arg0.sign
    }

    public(friend) fun gt_u128(arg0: S128, arg1: u128) : bool {
        !arg0.sign && false || arg0.value > arg1
    }

    public(friend) fun gte(arg0: S128, arg1: S128) : bool {
        if (arg0.sign && arg1.sign) {
            return arg0.value >= arg1.value
        };
        if (!arg0.sign && !arg1.sign) {
            return arg0.value <= arg1.value
        };
        arg0.sign
    }

    public(friend) fun gte_u128(arg0: S128, arg1: u128) : bool {
        !arg0.sign && false || arg0.value >= arg1
    }

    public(friend) fun lt_u128(arg0: S128, arg1: u128) : bool {
        !arg0.sign || arg0.value < arg1
    }

    public(friend) fun lte_u128(arg0: S128, arg1: u128) : bool {
        !arg0.sign || arg0.value <= arg1
    }

    public(friend) fun mul_u128(arg0: S128, arg1: u128) : S128 {
        S128{
            value : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg0.value, arg1),
            sign  : arg0.sign,
        }
    }

    public(friend) fun negate(arg0: S128) : S128 {
        S128{
            value : arg0.value,
            sign  : !arg0.sign,
        }
    }

    public(friend) fun negative_number(arg0: S128) : S128 {
        if (!arg0.sign) {
            arg0
        } else {
            S128{value: 0, sign: true}
        }
    }

    public(friend) fun one() : S128 {
        S128{
            value : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(),
            sign  : true,
        }
    }

    public(friend) fun positive_number(arg0: S128) : S128 {
        if (!arg0.sign) {
            S128{value: 0, sign: true}
        } else {
            arg0
        }
    }

    public(friend) fun positive_value(arg0: S128) : u128 {
        if (!arg0.sign) {
            0
        } else {
            arg0.value
        }
    }

    public(friend) fun sign(arg0: S128) : bool {
        arg0.sign
    }

    public(friend) fun sub(arg0: S128, arg1: S128) : S128 {
        arg1.sign = !arg1.sign;
        let (v0, v1) = if (arg0.sign == arg1.sign) {
            (arg0.sign, arg0.value + arg1.value)
        } else if (arg0.value >= arg1.value) {
            (arg0.sign, arg0.value - arg1.value)
        } else {
            (arg1.sign, arg1.value - arg0.value)
        };
        S128{
            value : v1,
            sign  : v0,
        }
    }

    public(friend) fun sub_u128(arg0: S128, arg1: u128) : S128 {
        let v0 = arg0.value;
        let v1 = arg0.sign;
        let v2 = v1;
        let v3 = if (v1 == false) {
            v0 + arg1
        } else if (v0 > arg1) {
            v0 - arg1
        } else {
            v2 = false;
            arg1 - v0
        };
        S128{
            value : v3,
            sign  : v2,
        }
    }

    public(friend) fun value(arg0: S128) : u128 {
        arg0.value
    }

    public(friend) fun zero() : S128 {
        S128{
            value : 0,
            sign  : true,
        }
    }

    // decompiled from Move bytecode v6
}

