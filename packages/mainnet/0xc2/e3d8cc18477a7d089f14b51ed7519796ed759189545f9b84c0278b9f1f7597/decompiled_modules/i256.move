module 0xc2e3d8cc18477a7d089f14b51ed7519796ed759189545f9b84c0278b9f1f7597::i256 {
    struct I256 has copy, drop, store {
        value: u256,
        sign: bool,
    }

    public(friend) fun abs(arg0: I256) : I256 {
        I256{
            value : arg0.value,
            sign  : true,
        }
    }

    public(friend) fun abs_u256(arg0: I256) : u256 {
        arg0.value
    }

    public(friend) fun abs_u64(arg0: I256) : u64 {
        (arg0.value as u64)
    }

    public(friend) fun add(arg0: I256, arg1: I256) : I256 {
        if (arg0.sign == arg1.sign) {
            I256{value: arg0.value + arg1.value, sign: arg0.sign}
        } else if (arg0.value > arg1.value) {
            I256{value: arg0.value - arg1.value, sign: arg0.sign}
        } else {
            I256{value: arg1.value - arg0.value, sign: arg1.sign}
        }
    }

    public(friend) fun add_u64(arg0: I256, arg1: u64) : I256 {
        add(arg0, from_u64(arg1))
    }

    public(friend) fun div(arg0: I256, arg1: I256) : I256 {
        I256{
            value : arg0.value / arg1.value,
            sign  : arg0.sign == arg1.sign,
        }
    }

    public(friend) fun div_u64(arg0: I256, arg1: u64) : I256 {
        div(arg0, from_u64(arg1))
    }

    public(friend) fun from_u64(arg0: u64) : I256 {
        I256{
            value : (arg0 as u256),
            sign  : true,
        }
    }

    public(friend) fun is_neg(arg0: I256) : bool {
        !arg0.sign
    }

    public(friend) fun mul(arg0: I256, arg1: I256) : I256 {
        I256{
            value : arg0.value * arg1.value,
            sign  : arg0.sign == arg1.sign,
        }
    }

    public(friend) fun mul_u64(arg0: I256, arg1: u64) : I256 {
        mul(arg0, from_u64(arg1))
    }

    public(friend) fun neg(arg0: I256) : I256 {
        I256{
            value : arg0.value,
            sign  : !arg0.sign,
        }
    }

    public(friend) fun new(arg0: u256, arg1: bool) : I256 {
        I256{
            value : arg0,
            sign  : arg1,
        }
    }

    public(friend) fun sub(arg0: I256, arg1: I256) : I256 {
        let v0 = I256{
            value : arg1.value,
            sign  : !arg1.sign,
        };
        add(arg0, v0)
    }

    public(friend) fun sub_u64(arg0: I256, arg1: u64) : I256 {
        sub(arg0, from_u64(arg1))
    }

    public(friend) fun zero() : I256 {
        I256{
            value : 0,
            sign  : true,
        }
    }

    // decompiled from Move bytecode v6
}

