module 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::signed_number {
    struct Number has copy, drop, store {
        value: u128,
        sign: bool,
    }

    public fun add(arg0: Number, arg1: Number) : Number {
        let (v0, v1) = if (arg0.sign == arg1.sign) {
            (arg0.sign, arg0.value + arg1.value)
        } else if (arg0.value >= arg1.value) {
            (arg0.sign, arg0.value - arg1.value)
        } else {
            (arg1.sign, arg1.value - arg0.value)
        };
        Number{
            value : v1,
            sign  : v0,
        }
    }

    public fun add_uint(arg0: Number, arg1: u128) : Number {
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
        Number{
            value : v3,
            sign  : v2,
        }
    }

    public fun div_uint(arg0: Number, arg1: u128) : Number {
        Number{
            value : 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_div(arg0.value, arg1),
            sign  : arg0.sign,
        }
    }

    public fun from(arg0: u128, arg1: bool) : Number {
        Number{
            value : arg0,
            sign  : arg1,
        }
    }

    public fun from_subtraction(arg0: u128, arg1: u128) : Number {
        if (arg0 > arg1) {
            Number{value: arg0 - arg1, sign: true}
        } else {
            Number{value: arg1 - arg0, sign: false}
        }
    }

    public fun gt(arg0: Number, arg1: Number) : bool {
        if (arg0.sign && arg1.sign) {
            return arg0.value > arg1.value
        };
        if (!arg0.sign && !arg1.sign) {
            return arg0.value < arg1.value
        };
        arg0.sign
    }

    public fun gt_uint(arg0: Number, arg1: u128) : bool {
        !arg0.sign && false || arg0.value > arg1
    }

    public fun gte(arg0: Number, arg1: Number) : bool {
        if (arg0.sign && arg1.sign) {
            return arg0.value >= arg1.value
        };
        if (!arg0.sign && !arg1.sign) {
            return arg0.value <= arg1.value
        };
        arg0.sign
    }

    public fun gte_uint(arg0: Number, arg1: u128) : bool {
        !arg0.sign && false || arg0.value >= arg1
    }

    public fun lt_uint(arg0: Number, arg1: u128) : bool {
        !arg0.sign || arg0.value < arg1
    }

    public fun lte_uint(arg0: Number, arg1: u128) : bool {
        !arg0.sign || arg0.value <= arg1
    }

    public fun mul_uint(arg0: Number, arg1: u128) : Number {
        Number{
            value : 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_mul(arg0.value, arg1),
            sign  : arg0.sign,
        }
    }

    public fun negate(arg0: Number) : Number {
        Number{
            value : arg0.value,
            sign  : !arg0.sign,
        }
    }

    public fun negative_number(arg0: Number) : Number {
        if (!arg0.sign) {
            arg0
        } else {
            Number{value: 0, sign: true}
        }
    }

    public fun new() : Number {
        Number{
            value : 0,
            sign  : true,
        }
    }

    public fun one() : Number {
        Number{
            value : 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_uint(),
            sign  : true,
        }
    }

    public fun positive_number(arg0: Number) : Number {
        if (!arg0.sign) {
            Number{value: 0, sign: true}
        } else {
            arg0
        }
    }

    public fun positive_value(arg0: Number) : u128 {
        if (!arg0.sign) {
            0
        } else {
            arg0.value
        }
    }

    public fun sign(arg0: Number) : bool {
        arg0.sign
    }

    public fun sub(arg0: Number, arg1: Number) : Number {
        arg1.sign = !arg1.sign;
        let (v0, v1) = if (arg0.sign == arg1.sign) {
            (arg0.sign, arg0.value + arg1.value)
        } else if (arg0.value >= arg1.value) {
            (arg0.sign, arg0.value - arg1.value)
        } else {
            (arg1.sign, arg1.value - arg0.value)
        };
        Number{
            value : v1,
            sign  : v0,
        }
    }

    public fun sub_uint(arg0: Number, arg1: u128) : Number {
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
        Number{
            value : v3,
            sign  : v2,
        }
    }

    public fun value(arg0: Number) : u128 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

