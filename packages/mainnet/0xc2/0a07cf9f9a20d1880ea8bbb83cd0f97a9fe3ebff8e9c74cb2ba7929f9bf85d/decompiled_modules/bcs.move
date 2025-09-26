module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs {
    struct BCS has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun empty() : BCS {
        BCS{bytes: 0x1::vector::empty<u8>()}
    }

    public fun length(arg0: &BCS) : u64 {
        0x1::vector::length<u8>(&arg0.bytes)
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

    public fun new_non_reserve(arg0: &vector<u8>) : BCS {
        BCS{bytes: *arg0}
    }

    public fun peel_address(arg0: &mut BCS) : address {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 0x2::address::length(), ((100 as u64) as u64));
        let v0 = 0;
        let v1 = 0x1::vector::empty<u8>();
        while (v0 < 0x2::address::length()) {
            0x1::vector::push_back<u8>(&mut v1, 0x1::vector::pop_back<u8>(&mut arg0.bytes));
            v0 = v0 + 1;
        };
        0x2::address::from_bytes(v1)
    }

    public fun peel_bool(arg0: &mut BCS) : bool {
        let v0 = peel_u8(arg0);
        if (v0 == 0) {
            false
        } else {
            assert!(v0 == 1, (101 as u64));
            true
        }
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

    public fun peel_option_u256(arg0: &mut BCS) : 0x1::option::Option<u256> {
        if (peel_bool(arg0)) {
            0x1::option::some<u256>(peel_u256(arg0))
        } else {
            0x1::option::none<u256>()
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

    public fun peel_option_vec_u8(arg0: &mut BCS) : 0x1::option::Option<vector<u8>> {
        if (peel_bool(arg0)) {
            0x1::option::some<vector<u8>>(peel_vec_u8(arg0))
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun peel_u128(arg0: &mut BCS) : u128 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 16, (100 as u64));
        let v0 = 0;
        let v1 = 0;
        while (v0 < 128) {
            v1 = v1 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u128) << v0);
            v0 = v0 + 8;
        };
        v1
    }

    public fun peel_u16(arg0: &mut BCS) : u16 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 2, (100 as u64));
        let v0 = 0;
        let v1 = 0;
        while (v0 < 16) {
            v1 = v1 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u16) << v0);
            v0 = v0 + 8;
        };
        v1
    }

    public fun peel_u256(arg0: &mut BCS) : u256 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 32, (100 as u64));
        let v0 = 0;
        let v1 = 0;
        while (v0 < 256) {
            v1 = v1 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u256) << (v0 as u8));
            v0 = v0 + 8;
        };
        v1
    }

    public fun peel_u64(arg0: &mut BCS) : u64 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 8, (100 as u64));
        let v0 = 0;
        let v1 = 0;
        while (v0 < 64) {
            v1 = v1 + ((0x1::vector::pop_back<u8>(&mut arg0.bytes) as u64) << v0);
            v0 = v0 + 8;
        };
        v1
    }

    public fun peel_u8(arg0: &mut BCS) : u8 {
        assert!(0x1::vector::length<u8>(&arg0.bytes) >= 1, (100 as u64));
        0x1::vector::pop_back<u8>(&mut arg0.bytes)
    }

    public fun peel_vec_address(arg0: &mut BCS) : vector<address> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<address>(&mut v1, peel_address(arg0));
            v2 = v2 + 1;
        };
        v1
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
            assert!(v0 <= 4, (102 as u64));
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

    public fun peel_vec_u256(arg0: &mut BCS) : vector<u256> {
        let v0 = peel_vec_length(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u256>(&mut v1, peel_u256(arg0));
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

    // decompiled from Move bytecode v6
}

