module 0xc501a3f2d87c4734aa6773205ea6a06627189499cb31b34b377e416ab44d9daa::math {
    public fun sqrt(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000000000, 13);
        let v0 = ((1000000000 / arg1) as u128);
        ((0x1::u128::sqrt((arg0 as u128) * v0 * 1000000000) / v0) as u64)
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
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

    public fun div_round_up(arg0: u64, arg1: u64) : u64 {
        let (v0, v1) = div_internal(arg0, arg1);
        v1 + v0
    }

    public fun div_u128(arg0: u128, arg1: u128) : u128 {
        let (_, v1) = div_internal_u128(arg0, arg1);
        v1
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun median(arg0: vector<u128>) : u128 {
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

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
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

    public fun mul_round_up(arg0: u64, arg1: u64) : u64 {
        let (v0, v1) = mul_internal(arg0, arg1);
        v1 + v0
    }

    public fun mul_u128(arg0: u128, arg1: u128) : u128 {
        let (_, v1) = mul_internal_u128(arg0, arg1);
        v1
    }

    fun quick_sort(arg0: vector<u128>) : vector<u128> {
        let v0 = 0x1::vector::length<u128>(&arg0);
        let v1 = v0;
        if (v0 <= 1) {
            return arg0
        };
        let v2 = *0x1::vector::borrow<u128>(&arg0, 0);
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        while (v1 > 0) {
            v1 = v1 - 1;
            let v6 = *0x1::vector::borrow<u128>(&arg0, v1);
            if (v6 < v2) {
                0x1::vector::push_back<u128>(&mut v3, v6);
                continue
            };
            if (v6 == v2) {
                0x1::vector::push_back<u128>(&mut v4, v6);
                continue
            };
            0x1::vector::push_back<u128>(&mut v5, v6);
        };
        let v7 = vector[];
        0x1::vector::append<u128>(&mut v7, quick_sort(v3));
        0x1::vector::append<u128>(&mut v7, v4);
        0x1::vector::append<u128>(&mut v7, quick_sort(v5));
        v7
    }

    // decompiled from Move bytecode v6
}

