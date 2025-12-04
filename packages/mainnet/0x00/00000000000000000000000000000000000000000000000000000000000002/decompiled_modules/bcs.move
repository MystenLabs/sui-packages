module 0x2::bcs {
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

    public fun peel_address(arg0: &mut BCS) : address {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 0x2::address::length(), 0);
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x2::address::length()) {
            0x1::vector::push_back<u8>(&mut v0, 0x1::vector::pop_back<u8>(&mut arg0.bytes));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(v0)
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

    public fun peel_enum_tag(arg0: &mut BCS) : u32 {
        let v0 = peel_vec_length(arg0);
        assert!(v0 <= 4294967295, 0);
        (v0 as u32)
    }

    public fun peel_option_address(arg0: &mut BCS) : 0x1::option::Option<address> {
        if (peel_bool(arg0)) {
            0x1::option::some<address>(peel_address(arg0))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun peel_option_bool(arg0: &mut BCS) : 0x1::option::Option<bool> {
        if (peel_bool(arg0)) {
            0x1::option::some<bool>(peel_bool(arg0))
        } else {
            0x1::option::none<bool>()
        }
    }

    public fun peel_option_u128(arg0: &mut BCS) : 0x1::option::Option<u128> {
        if (peel_bool(arg0)) {
            0x1::option::some<u128>(peel_u128(arg0))
        } else {
            0x1::option::none<u128>()
        }
    }

    public fun peel_option_u16(arg0: &mut BCS) : 0x1::option::Option<u16> {
        if (peel_bool(arg0)) {
            0x1::option::some<u16>(peel_u16(arg0))
        } else {
            0x1::option::none<u16>()
        }
    }

    public fun peel_option_u256(arg0: &mut BCS) : 0x1::option::Option<u256> {
        if (peel_bool(arg0)) {
            0x1::option::some<u256>(peel_u256(arg0))
        } else {
            0x1::option::none<u256>()
        }
    }

    public fun peel_option_u32(arg0: &mut BCS) : 0x1::option::Option<u32> {
        if (peel_bool(arg0)) {
            0x1::option::some<u32>(peel_u32(arg0))
        } else {
            0x1::option::none<u32>()
        }
    }

    public fun peel_option_u64(arg0: &mut BCS) : 0x1::option::Option<u64> {
        if (peel_bool(arg0)) {
            0x1::option::some<u64>(peel_u64(arg0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun peel_option_u8(arg0: &mut BCS) : 0x1::option::Option<u8> {
        if (peel_bool(arg0)) {
            0x1::option::some<u8>(peel_u8(arg0))
        } else {
            0x1::option::none<u8>()
        }
    }

    public fun peel_u128(arg0: &mut BCS) : u128 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 16, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 128) {
            v0 = v0 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u128) << (v1 as u8));
            v1 = v1 + 8;
        };
        v0
    }

    public fun peel_u16(arg0: &mut BCS) : u16 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 2, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            v0 = v0 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u16) << (v1 as u8));
            v1 = v1 + 8;
        };
        v0
    }

    public fun peel_u256(arg0: &mut BCS) : u256 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 32, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 256) {
            v0 = v0 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u256) << (v1 as u8));
            v1 = v1 + 8;
        };
        v0
    }

    public fun peel_u32(arg0: &mut BCS) : u32 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 4, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            v0 = v0 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u32) << (v1 as u8));
            v1 = v1 + 8;
        };
        v0
    }

    public fun peel_u64(arg0: &mut BCS) : u64 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 8, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 64) {
            v0 = v0 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u64) << (v1 as u8));
            v1 = v1 + 8;
        };
        v0
    }

    public fun peel_u8(arg0: &mut BCS) : u8 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 1, 0);
        0x1::vector::pop_back<u8>(&mut arg0.bytes)
    }

    public fun peel_vec_address(arg0: &mut BCS) : vector<address> {
        let v0 = vector[];
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<address>(&mut v0, peel_address(arg0));
            v2 = v2 + 1;
        };
        v0
    }

    public fun peel_vec_bool(arg0: &mut BCS) : vector<bool> {
        let v0 = vector[];
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<bool>(&mut v0, peel_bool(arg0));
            v2 = v2 + 1;
        };
        v0
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
        let v0 = vector[];
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<u128>(&mut v0, peel_u128(arg0));
            v2 = v2 + 1;
        };
        v0
    }

    public fun peel_vec_u16(arg0: &mut BCS) : vector<u16> {
        let v0 = vector[];
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<u16>(&mut v0, peel_u16(arg0));
            v2 = v2 + 1;
        };
        v0
    }

    public fun peel_vec_u256(arg0: &mut BCS) : vector<u256> {
        let v0 = vector[];
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<u256>(&mut v0, peel_u256(arg0));
            v2 = v2 + 1;
        };
        v0
    }

    public fun peel_vec_u32(arg0: &mut BCS) : vector<u32> {
        let v0 = vector[];
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<u32>(&mut v0, peel_u32(arg0));
            v2 = v2 + 1;
        };
        v0
    }

    public fun peel_vec_u64(arg0: &mut BCS) : vector<u64> {
        let v0 = vector[];
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<u64>(&mut v0, peel_u64(arg0));
            v2 = v2 + 1;
        };
        v0
    }

    public fun peel_vec_u8(arg0: &mut BCS) : vector<u8> {
        let v0 = b"";
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<u8>(&mut v0, peel_u8(arg0));
            v2 = v2 + 1;
        };
        v0
    }

    public fun peel_vec_vec_u8(arg0: &mut BCS) : vector<vector<u8>> {
        let v0 = vector[];
        let v1 = peel_vec_length(arg0);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<vector<u8>>(&mut v0, peel_vec_u8(arg0));
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

