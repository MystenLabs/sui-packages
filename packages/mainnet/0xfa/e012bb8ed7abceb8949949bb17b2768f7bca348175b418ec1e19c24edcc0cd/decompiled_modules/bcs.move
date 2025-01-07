module 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs {
    struct BCS has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun to_bytes<T0>(arg0: &T0) : vector<u8> {
        0x1::bcs::to_bytes<T0>(arg0)
    }

    public fun into_remainder_bytes(arg0: BCS) : vector<u8> {
        let BCS { bytes: v0 } = arg0;
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun new(arg0: vector<u8>) : BCS {
        0x1::vector::reverse<u8>(&mut arg0);
        BCS{bytes: arg0}
    }

    public fun peel_bool(arg0: &mut BCS) : bool {
        let v0 = peel_u8(arg0);
        if (v0 == 0) {
            false
        } else {
            assert!(v0 == 1, 1);
            true
        }
    }

    public fun peel_u128(arg0: &mut BCS) : u128 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 16, 0);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 128) {
            v1 = v1 | (0x1::vector::pop_back<u8>(&mut arg0.bytes) as u128) << v0;
            v0 = v0 + 8;
        };
        v1
    }

    public fun peel_u16(arg0: &mut BCS) : u16 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 2, 0);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 16) {
            v1 = v1 | (0x1::vector::pop_back<u8>(&mut arg0.bytes) as u16) << v0;
            v0 = v0 + 8;
        };
        v1
    }

    public fun peel_u32(arg0: &mut BCS) : u32 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 4, 0);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 32) {
            v1 = v1 | (0x1::vector::pop_back<u8>(&mut arg0.bytes) as u32) << v0;
            v0 = v0 + 8;
        };
        v1
    }

    public fun peel_u64(arg0: &mut BCS) : u64 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 8, 0);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 64) {
            v1 = v1 | (0x1::vector::pop_back<u8>(&mut arg0.bytes) as u64) << v0;
            v0 = v0 + 8;
        };
        v1
    }

    public fun peel_u8(arg0: &mut BCS) : u8 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 1, 0);
        0x1::vector::pop_back<u8>(&mut arg0.bytes)
    }

    public fun peel_vec_bool(arg0: &mut BCS) : vector<bool> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v1, peel_bool(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun peel_vec_length(arg0: &mut BCS) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        loop {
            assert!(v0 <= 4, 2);
            let v3 = (0x1::vector::pop_back<u8>(&mut arg0.bytes) as u64);
            v0 = v0 + 1;
            v2 = v2 | (v3 & 127) << v1;
            if (v3 & 128 == 0) {
                break
            };
            v1 = v1 + 7;
        };
        v2
    }

    public fun peel_vec_u128(arg0: &mut BCS) : vector<u128> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u128>(&mut v1, peel_u128(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun peel_vec_u16(arg0: &mut BCS) : vector<u16> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u16>(&mut v1, peel_u16(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun peel_vec_u32(arg0: &mut BCS) : vector<u32> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u32>(&mut v1, peel_u32(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun peel_vec_u64(arg0: &mut BCS) : vector<u64> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u64>(&mut v1, peel_u64(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun peel_vec_u8(arg0: &mut BCS) : vector<u8> {
        let v0 = peel_vec_length(arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u8>(&mut v1, peel_u8(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun peel_vec_vec_u8(arg0: &mut BCS) : vector<vector<u8>> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<vector<u8>>(&mut v1, peel_vec_u8(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun peel_vec_vec_vec_u8(arg0: &mut BCS) : vector<vector<vector<u8>>> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<vector<vector<u8>>>(&mut v1, peel_vec_vec_u8(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

