module 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream {
    struct BCSStream has drop {
        data: vector<u8>,
        cur: u64,
    }

    public fun new(arg0: vector<u8>) : BCSStream {
        BCSStream{
            data : arg0,
            cur  : 0,
        }
    }

    public fun assert_is_consumed(arg0: &BCSStream) {
        assert!(arg0.cur == 0x1::vector::length<u8>(&arg0.data), 3);
    }

    public fun deserialize_address(arg0: &mut BCSStream) : address {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 32 <= 0x1::vector::length<u8>(v0), 2);
        let v2 = 0x2::bcs::new(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::params::slice<u8>(v0, v1, 32));
        arg0.cur = arg0.cur + 32;
        0x2::bcs::peel_address(&mut v2)
    }

    public fun deserialize_bool(arg0: &mut BCSStream) : bool {
        assert!(arg0.cur < 0x1::vector::length<u8>(&arg0.data), 2);
        let v0 = *0x1::vector::borrow<u8>(&arg0.data, arg0.cur);
        arg0.cur = arg0.cur + 1;
        if (v0 == 0) {
            return false
        };
        assert!(v0 == 1, 1);
        true
    }

    public fun deserialize_fixed_vector_u8(arg0: &mut BCSStream, arg1: u64) : vector<u8> {
        let v0 = &mut arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + arg1 <= 0x1::vector::length<u8>(v0), 2);
        let v2 = trim<u8>(v0, v1);
        let v3 = &mut v2;
        arg0.data = trim<u8>(v3, arg1);
        arg0.cur = 0;
        v2
    }

    public fun deserialize_string(arg0: &mut BCSStream) : 0x1::string::String {
        let v0 = deserialize_uleb128(arg0);
        let v1 = &mut arg0.data;
        let v2 = arg0.cur;
        assert!(v2 + v0 <= 0x1::vector::length<u8>(v1), 2);
        let v3 = trim<u8>(v1, v2);
        let v4 = &mut v3;
        arg0.data = trim<u8>(v4, v0);
        arg0.cur = 0;
        0x1::string::utf8(v3)
    }

    public fun deserialize_u128(arg0: &mut BCSStream) : u128 {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 16 <= 0x1::vector::length<u8>(v0), 2);
        arg0.cur = arg0.cur + 16;
        (*0x1::vector::borrow<u8>(v0, v1) as u128) | (*0x1::vector::borrow<u8>(v0, v1 + 1) as u128) << 8 | (*0x1::vector::borrow<u8>(v0, v1 + 2) as u128) << 16 | (*0x1::vector::borrow<u8>(v0, v1 + 3) as u128) << 24 | (*0x1::vector::borrow<u8>(v0, v1 + 4) as u128) << 32 | (*0x1::vector::borrow<u8>(v0, v1 + 5) as u128) << 40 | (*0x1::vector::borrow<u8>(v0, v1 + 6) as u128) << 48 | (*0x1::vector::borrow<u8>(v0, v1 + 7) as u128) << 56 | (*0x1::vector::borrow<u8>(v0, v1 + 8) as u128) << 64 | (*0x1::vector::borrow<u8>(v0, v1 + 9) as u128) << 72 | (*0x1::vector::borrow<u8>(v0, v1 + 10) as u128) << 80 | (*0x1::vector::borrow<u8>(v0, v1 + 11) as u128) << 88 | (*0x1::vector::borrow<u8>(v0, v1 + 12) as u128) << 96 | (*0x1::vector::borrow<u8>(v0, v1 + 13) as u128) << 104 | (*0x1::vector::borrow<u8>(v0, v1 + 14) as u128) << 112 | (*0x1::vector::borrow<u8>(v0, v1 + 15) as u128) << 120
    }

    public fun deserialize_u16(arg0: &mut BCSStream) : u16 {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 2 <= 0x1::vector::length<u8>(v0), 2);
        arg0.cur = arg0.cur + 2;
        (*0x1::vector::borrow<u8>(v0, v1) as u16) | (*0x1::vector::borrow<u8>(v0, v1 + 1) as u16) << 8
    }

    public fun deserialize_u256(arg0: &mut BCSStream) : u256 {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 32 <= 0x1::vector::length<u8>(v0), 2);
        arg0.cur = arg0.cur + 32;
        (*0x1::vector::borrow<u8>(v0, v1) as u256) | (*0x1::vector::borrow<u8>(v0, v1 + 1) as u256) << 8 | (*0x1::vector::borrow<u8>(v0, v1 + 2) as u256) << 16 | (*0x1::vector::borrow<u8>(v0, v1 + 3) as u256) << 24 | (*0x1::vector::borrow<u8>(v0, v1 + 4) as u256) << 32 | (*0x1::vector::borrow<u8>(v0, v1 + 5) as u256) << 40 | (*0x1::vector::borrow<u8>(v0, v1 + 6) as u256) << 48 | (*0x1::vector::borrow<u8>(v0, v1 + 7) as u256) << 56 | (*0x1::vector::borrow<u8>(v0, v1 + 8) as u256) << 64 | (*0x1::vector::borrow<u8>(v0, v1 + 9) as u256) << 72 | (*0x1::vector::borrow<u8>(v0, v1 + 10) as u256) << 80 | (*0x1::vector::borrow<u8>(v0, v1 + 11) as u256) << 88 | (*0x1::vector::borrow<u8>(v0, v1 + 12) as u256) << 96 | (*0x1::vector::borrow<u8>(v0, v1 + 13) as u256) << 104 | (*0x1::vector::borrow<u8>(v0, v1 + 14) as u256) << 112 | (*0x1::vector::borrow<u8>(v0, v1 + 15) as u256) << 120 | (*0x1::vector::borrow<u8>(v0, v1 + 16) as u256) << 128 | (*0x1::vector::borrow<u8>(v0, v1 + 17) as u256) << 136 | (*0x1::vector::borrow<u8>(v0, v1 + 18) as u256) << 144 | (*0x1::vector::borrow<u8>(v0, v1 + 19) as u256) << 152 | (*0x1::vector::borrow<u8>(v0, v1 + 20) as u256) << 160 | (*0x1::vector::borrow<u8>(v0, v1 + 21) as u256) << 168 | (*0x1::vector::borrow<u8>(v0, v1 + 22) as u256) << 176 | (*0x1::vector::borrow<u8>(v0, v1 + 23) as u256) << 184 | (*0x1::vector::borrow<u8>(v0, v1 + 24) as u256) << 192 | (*0x1::vector::borrow<u8>(v0, v1 + 25) as u256) << 200 | (*0x1::vector::borrow<u8>(v0, v1 + 26) as u256) << 208 | (*0x1::vector::borrow<u8>(v0, v1 + 27) as u256) << 216 | (*0x1::vector::borrow<u8>(v0, v1 + 28) as u256) << 224 | (*0x1::vector::borrow<u8>(v0, v1 + 29) as u256) << 232 | (*0x1::vector::borrow<u8>(v0, v1 + 30) as u256) << 240 | (*0x1::vector::borrow<u8>(v0, v1 + 31) as u256) << 248
    }

    public fun deserialize_u256_entry(arg0: vector<u8>, arg1: u64) {
        let v0 = BCSStream{
            data : arg0,
            cur  : arg1,
        };
        let v1 = &mut v0;
        deserialize_u256(v1);
    }

    public fun deserialize_u32(arg0: &mut BCSStream) : u32 {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 4 <= 0x1::vector::length<u8>(v0), 2);
        arg0.cur = arg0.cur + 4;
        (*0x1::vector::borrow<u8>(v0, v1) as u32) | (*0x1::vector::borrow<u8>(v0, v1 + 1) as u32) << 8 | (*0x1::vector::borrow<u8>(v0, v1 + 2) as u32) << 16 | (*0x1::vector::borrow<u8>(v0, v1 + 3) as u32) << 24
    }

    public fun deserialize_u64(arg0: &mut BCSStream) : u64 {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 8 <= 0x1::vector::length<u8>(v0), 2);
        arg0.cur = arg0.cur + 8;
        (*0x1::vector::borrow<u8>(v0, v1) as u64) | (*0x1::vector::borrow<u8>(v0, v1 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(v0, v1 + 2) as u64) << 16 | (*0x1::vector::borrow<u8>(v0, v1 + 3) as u64) << 24 | (*0x1::vector::borrow<u8>(v0, v1 + 4) as u64) << 32 | (*0x1::vector::borrow<u8>(v0, v1 + 5) as u64) << 40 | (*0x1::vector::borrow<u8>(v0, v1 + 6) as u64) << 48 | (*0x1::vector::borrow<u8>(v0, v1 + 7) as u64) << 56
    }

    public fun deserialize_u8(arg0: &mut BCSStream) : u8 {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 < 0x1::vector::length<u8>(v0), 2);
        arg0.cur = v1 + 1;
        *0x1::vector::borrow<u8>(v0, v1)
    }

    public fun deserialize_uleb128(arg0: &mut BCSStream) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (arg0.cur < 0x1::vector::length<u8>(&arg0.data)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0.data, arg0.cur);
            arg0.cur = arg0.cur + 1;
            let v3 = ((v2 & 127) as u64);
            if (v3 << v1 >> v1 != v3) {
                abort 1
            };
            let v4 = v0 | v3 << v1;
            v0 = v4;
            if (v2 & 128 == 0) {
                if (v1 > 0 && v3 == 0) {
                    abort 1
                };
                return v4
            };
            let v5 = v1 + 7;
            v1 = v5;
            if (v5 > 64) {
                abort 1
            };
        };
        abort 2
    }

    public fun deserialize_vector_u8(arg0: &mut BCSStream) : vector<u8> {
        let v0 = deserialize_uleb128(arg0);
        let v1 = &mut arg0.data;
        let v2 = arg0.cur;
        assert!(v2 + v0 <= 0x1::vector::length<u8>(v1), 2);
        let v3 = trim<u8>(v1, v2);
        let v4 = &mut v3;
        arg0.data = trim<u8>(v4, v0);
        arg0.cur = 0;
        v3
    }

    fun trim<T0: copy>(arg0: &mut vector<T0>, arg1: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        if (arg1 >= 0x1::vector::length<T0>(arg0)) {
            return v0
        };
        while (0x1::vector::length<T0>(arg0) > arg1) {
            0x1::vector::push_back<T0>(&mut v0, 0x1::vector::pop_back<T0>(arg0));
        };
        0x1::vector::reverse<T0>(&mut v0);
        v0
    }

    public fun validate_obj_addr(arg0: address, arg1: &mut BCSStream) {
        assert!(deserialize_address(arg1) == arg0, 4);
    }

    public fun validate_obj_addrs(arg0: vector<address>, arg1: &mut BCSStream) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            validate_obj_addr(*0x1::vector::borrow<address>(&arg0, v0), arg1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

