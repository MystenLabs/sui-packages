module 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_math {
    public fun binary_dot_product(arg0: &vector<u256>, arg1: &vector<u256>, arg2: u64) : (u64, bool) {
        let v0 = xnor_chunks(arg0, arg1);
        let v1 = popcount_chunks(&v0);
        let v2 = if (v1 > arg2) {
            arg2
        } else {
            v1
        };
        let v3 = arg2 - v2;
        if (v2 >= v3) {
            (v2 - v3, false)
        } else {
            (v3 - v2, true)
        }
    }

    public fun binary_dot_product_raw(arg0: &vector<u256>, arg1: &vector<u256>) : u64 {
        let v0 = xnor_chunks(arg0, arg1);
        popcount_chunks(&v0)
    }

    public fun chunks_needed(arg0: u64) : u64 {
        (arg0 + 256 - 1) / 256
    }

    public fun clone_chunks(arg0: &vector<u256>) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(arg0)) {
            0x1::vector::push_back<u256>(&mut v0, *0x1::vector::borrow<u256>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_ones_chunks(arg0: u64) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < chunks_needed(arg0)) {
            0x1::vector::push_back<u256>(&mut v0, 115792089237316195423570985008687907853269984665640564039457584007913129639935);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_zero_chunks(arg0: u64) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < chunks_needed(arg0)) {
            0x1::vector::push_back<u256>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun flip_bit(arg0: &mut vector<u256>, arg1: u64) {
        let v0 = arg1 / 256;
        assert!(v0 < 0x1::vector::length<u256>(arg0), 3);
        let v1 = 0x1::vector::borrow_mut<u256>(arg0, v0);
        *v1 = *v1 ^ 1 << ((arg1 % 256) as u8);
    }

    public fun get_bit(arg0: &vector<u256>, arg1: u64) : bool {
        let v0 = arg1 / 256;
        assert!(v0 < 0x1::vector::length<u256>(arg0), 3);
        *0x1::vector::borrow<u256>(arg0, v0) & 1 << ((arg1 % 256) as u8) != 0
    }

    public fun popcount_chunks(arg0: &vector<u256>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(arg0)) {
            v0 = v0 + popcount_u256(*0x1::vector::borrow<u256>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun popcount_u128(arg0: u128) : u64 {
        popcount_u64(((arg0 & 18446744073709551615) as u64)) + popcount_u64(((arg0 >> 64 & 18446744073709551615) as u64))
    }

    public fun popcount_u256(arg0: u256) : u64 {
        popcount_u128(((arg0 & 340282366920938463463374607431768211455) as u128)) + popcount_u128(((arg0 >> 128 & 340282366920938463463374607431768211455) as u128))
    }

    public fun popcount_u64(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = x"00010102010202030102020302030304";
            v0 = v0 + (*0x1::vector::borrow<u8>(&v2, (((arg0 & 15) as u8) as u64)) as u64);
            arg0 = arg0 >> 4;
            v1 = v1 + 1;
        };
        v0
    }

    public fun set_bit(arg0: &mut vector<u256>, arg1: u64, arg2: bool) {
        let v0 = arg1 / 256;
        assert!(v0 < 0x1::vector::length<u256>(arg0), 3);
        let v1 = 0x1::vector::borrow_mut<u256>(arg0, v0);
        if (arg2) {
            *v1 = *v1 | 1 << ((arg1 % 256) as u8);
        } else {
            *v1 = *v1 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 1 << ((arg1 % 256) as u8));
        };
    }

    public fun sign_activation(arg0: u64, arg1: bool, arg2: u64) : bool {
        arg1 && false || arg0 >= arg2
    }

    public fun sign_activation_batch(arg0: &vector<u64>, arg1: &vector<bool>, arg2: u64) : vector<u256> {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<bool>(arg1), 1);
        let v1 = create_zero_chunks(v0);
        let v2 = 0;
        while (v2 < v0) {
            if (sign_activation(*0x1::vector::borrow<u64>(arg0, v2), *0x1::vector::borrow<bool>(arg1, v2), arg2)) {
                let v3 = &mut v1;
                set_bit(v3, v2, true);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun xnor_chunks(arg0: &vector<u256>, arg1: &vector<u256>) : vector<u256> {
        let v0 = 0x1::vector::length<u256>(arg0);
        assert!(v0 == 0x1::vector::length<u256>(arg1), 1);
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u256>(&mut v1, xnor_u256(*0x1::vector::borrow<u256>(arg0, v2), *0x1::vector::borrow<u256>(arg1, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun xnor_u256(arg0: u256, arg1: u256) : u256 {
        arg0 ^ arg1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935
    }

    public fun xor_chunks(arg0: &vector<u256>, arg1: &vector<u256>) : vector<u256> {
        let v0 = 0x1::vector::length<u256>(arg0);
        assert!(v0 == 0x1::vector::length<u256>(arg1), 1);
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u256>(&mut v1, *0x1::vector::borrow<u256>(arg0, v2) ^ *0x1::vector::borrow<u256>(arg1, v2));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

