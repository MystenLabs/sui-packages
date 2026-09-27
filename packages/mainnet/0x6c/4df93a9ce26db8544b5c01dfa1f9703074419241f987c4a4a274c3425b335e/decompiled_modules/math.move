module 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math {
    public fun base_div(arg0: u128, arg1: u128) : u128 {
        arg0 * 1000000000 / arg1
    }

    public fun base_div_up(arg0: u128, arg1: u128) : u128 {
        (arg0 * 1000000000 + arg1 - 1) / arg1
    }

    public fun base_mul(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1 / 1000000000
    }

    public fun base_mul_up(arg0: u128, arg1: u128) : u128 {
        (arg0 * arg1 + 1000000000 - 1) / 1000000000
    }

    public fun base_uint() : u128 {
        1000000000
    }

    public fun ceil(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1 * arg1
    }

    public fun compute_mro(arg0: u128) : u128 {
        base_div(base_uint(), arg0)
    }

    public fun convert_usdc_to_base_decimals(arg0: u128) : u128 {
        arg0 * 1000
    }

    public fun decimal_1e18_to_base(arg0: u128) : u128 {
        arg0 / 1000000000
    }

    public fun get_hash(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    public fun half_base_uint() : u128 {
        500000000
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun round(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 + arg1 * 5 / 10;
        v0 - v0 % arg1
    }

    public fun round_down(arg0: u128) : u128 {
        arg0 / base_uint() * base_uint()
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun to_1x9_vec(arg0: vector<u128>) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<u128>(&mut v0, *0x1::vector::borrow<u128>(&arg0, v1) / 1000000000);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

