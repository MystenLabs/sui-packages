module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library {
    struct VerificationResult has copy, drop {
        is_verified: bool,
        public_key: vector<u8>,
    }

    public(friend) fun base_div(arg0: u128, arg1: u128) : u128 {
        arg0 * 1000000000 / arg1
    }

    public(friend) fun base_div_up(arg0: u128, arg1: u128) : u128 {
        (arg0 * 1000000000 + arg1 - 1) / arg1
    }

    public(friend) fun base_mul(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1 / 1000000000
    }

    public(friend) fun base_mul_up(arg0: u128, arg1: u128) : u128 {
        (arg0 * arg1 + 1000000000 - 1) / 1000000000
    }

    public(friend) fun base_uint() : u128 {
        1000000000
    }

    public(friend) fun ceil(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1 * arg1
    }

    public(friend) fun compute_mro(arg0: u128) : u128 {
        base_div(base_uint(), arg0)
    }

    public(friend) fun convert_to_usdc_base(arg0: u128) : u64 {
        ((arg0 / 1000) as u64)
    }

    public(friend) fun convert_usdc_to_base_decimals(arg0: u128) : u128 {
        arg0 * 1000
    }

    public(friend) fun decimal_1e18_to_base(arg0: u128) : u128 {
        arg0 / 1000000000
    }

    public(friend) fun get_hash(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    public(friend) fun half_base_uint() : u128 {
        500000000
    }

    public(friend) fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public(friend) fun round(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 + arg1 * 5 / 10;
        v0 - v0 % arg1
    }

    public(friend) fun round_down(arg0: u128) : u128 {
        arg0 / base_uint() * base_uint()
    }

    public(friend) fun sub(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun to_1x9_vec(arg0: vector<u128>) : vector<u128> {
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

