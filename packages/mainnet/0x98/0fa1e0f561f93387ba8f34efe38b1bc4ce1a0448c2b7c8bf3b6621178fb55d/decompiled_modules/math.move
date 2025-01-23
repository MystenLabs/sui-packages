module 0x980fa1e0f561f93387ba8f34efe38b1bc4ce1a0448c2b7c8bf3b6621178fb55d::math {
    public(friend) fun sqrt(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000000000, 0);
        let v0 = ((1000000000 / arg1) as u128);
        ((0x1::u128::sqrt((arg0 as u128) * v0 * 1000000000) / v0) as u64)
    }

    public fun GET_FLOAT_SCALING() : u64 {
        1000000000
    }

    public(friend) fun div(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = div_internal(arg0, arg1);
        v1
    }

    fun div_internal(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = if (v0 * 1000000000 % v1 == 0) {
            0
        } else {
            1
        };
        (v2, ((v0 * 1000000000 / v1) as u64))
    }

    fun div_internal_u128(arg0: u128, arg1: u128) : (u128, u128) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = if (v0 * 1000000000 % v1 == 0) {
            0
        } else {
            1
        };
        (v2, ((v0 * 1000000000 / v1) as u128))
    }

    public(friend) fun div_round_up(arg0: u64, arg1: u64) : u64 {
        let (v0, v1) = div_internal(arg0, arg1);
        v1 + v0
    }

    public(friend) fun div_u128(arg0: u128, arg1: u128) : u128 {
        let (_, v1) = div_internal_u128(arg0, arg1);
        v1
    }

    public(friend) fun is_power_of_ten(arg0: u64) : bool {
        let v0 = arg0;
        if (arg0 < 1) {
            false
        } else {
            while (v0 % 10 == 0) {
                v0 = v0 / 10;
            };
            v0 == 1
        }
    }

    public(friend) fun median(arg0: vector<u128>) : u128 {
        let v0 = 0x1::vector::length<u128>(&arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = quick_sort(arg0);
        if (v0 % 2 == 0) {
            mul_u128(*0x1::vector::borrow<u128>(&v1, v0 / 2 - 1) + *0x1::vector::borrow<u128>(&v1, v0 / 2), 1000000000 / 2)
        } else {
            *0x1::vector::borrow<u128>(&v1, v0 / 2)
        }
    }

    public(friend) fun mul(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = mul_internal(arg0, arg1);
        v1
    }

    fun mul_internal(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = if (v0 * v1 % 1000000000 == 0) {
            0
        } else {
            1
        };
        (v2, ((v0 * v1 / 1000000000) as u64))
    }

    fun mul_internal_u128(arg0: u128, arg1: u128) : (u128, u128) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = if (v0 * v1 % 1000000000 == 0) {
            0
        } else {
            1
        };
        (v2, ((v0 * v1 / 1000000000) as u128))
    }

    public(friend) fun mul_round_up(arg0: u64, arg1: u64) : u64 {
        let (v0, v1) = mul_internal(arg0, arg1);
        v1 + v0
    }

    public(friend) fun mul_u128(arg0: u128, arg1: u128) : u128 {
        let (_, v1) = mul_internal_u128(arg0, arg1);
        v1
    }

    fun quick_sort(arg0: vector<u128>) : vector<u128> {
        if (0x1::vector::length<u128>(&arg0) <= 1) {
            return arg0
        };
        let v0 = *0x1::vector::borrow<u128>(&arg0, 0);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        0x1::vector::reverse<u128>(&mut arg0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg0)) {
            let v5 = 0x1::vector::pop_back<u128>(&mut arg0);
            if (v5 < v0) {
                0x1::vector::push_back<u128>(&mut v1, v5);
            } else if (v5 == v0) {
                0x1::vector::push_back<u128>(&mut v2, v5);
            } else {
                0x1::vector::push_back<u128>(&mut v3, v5);
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u128>(arg0);
        let v6 = vector[];
        0x1::vector::append<u128>(&mut v6, quick_sort(v1));
        0x1::vector::append<u128>(&mut v6, v2);
        0x1::vector::append<u128>(&mut v6, quick_sort(v3));
        v6
    }

    public(friend) fun scale_from_float(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (0x2::math::pow(10, (arg1 as u8)) as u128) / 1000000000) as u64)
    }

    public(friend) fun scale_to_float(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (0x2::math::pow(10, (arg1 as u8)) as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

