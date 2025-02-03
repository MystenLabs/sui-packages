module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde {
    public fun ascii_to_hex_str(arg0: u8) : u8 {
        if (arg0 >= 48 && arg0 <= 57) {
            arg0 - 48
        } else {
            assert!(arg0 >= 97 && arg0 <= 102, 1);
            arg0 - 87
        }
    }

    public fun deserialize_address(arg0: &vector<u8>) : address {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
        0x2::address::from_bytes(*arg0)
    }

    public fun deserialize_u128(arg0: &vector<u8>) : u128 {
        assert!(0x1::vector::length<u8>(arg0) == 16, 0);
        ((*0x1::vector::borrow<u8>(arg0, 0) as u128) << 120) + ((*0x1::vector::borrow<u8>(arg0, 1) as u128) << 112) + ((*0x1::vector::borrow<u8>(arg0, 2) as u128) << 104) + ((*0x1::vector::borrow<u8>(arg0, 3) as u128) << 96) + ((*0x1::vector::borrow<u8>(arg0, 4) as u128) << 88) + ((*0x1::vector::borrow<u8>(arg0, 5) as u128) << 80) + ((*0x1::vector::borrow<u8>(arg0, 6) as u128) << 72) + ((*0x1::vector::borrow<u8>(arg0, 7) as u128) << 64) + ((*0x1::vector::borrow<u8>(arg0, 8) as u128) << 56) + ((*0x1::vector::borrow<u8>(arg0, 9) as u128) << 48) + ((*0x1::vector::borrow<u8>(arg0, 10) as u128) << 40) + ((*0x1::vector::borrow<u8>(arg0, 11) as u128) << 32) + ((*0x1::vector::borrow<u8>(arg0, 12) as u128) << 24) + ((*0x1::vector::borrow<u8>(arg0, 13) as u128) << 16) + ((*0x1::vector::borrow<u8>(arg0, 14) as u128) << 8) + (*0x1::vector::borrow<u8>(arg0, 15) as u128)
    }

    public fun deserialize_u128_with_hex_str(arg0: &vector<u8>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, v1) as u128);
            v1 = v1 + 1;
        };
        v0
    }

    public fun deserialize_u16(arg0: &vector<u8>) : u16 {
        assert!(0x1::vector::length<u8>(arg0) == 2, 0);
        ((*0x1::vector::borrow<u8>(arg0, 0) as u16) << 8) + (*0x1::vector::borrow<u8>(arg0, 1) as u16)
    }

    public fun deserialize_u256(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
        ((*0x1::vector::borrow<u8>(arg0, 0) as u256) << 248) + ((*0x1::vector::borrow<u8>(arg0, 1) as u256) << 240) + ((*0x1::vector::borrow<u8>(arg0, 2) as u256) << 232) + ((*0x1::vector::borrow<u8>(arg0, 3) as u256) << 224) + ((*0x1::vector::borrow<u8>(arg0, 4) as u256) << 216) + ((*0x1::vector::borrow<u8>(arg0, 5) as u256) << 208) + ((*0x1::vector::borrow<u8>(arg0, 6) as u256) << 200) + ((*0x1::vector::borrow<u8>(arg0, 7) as u256) << 192) + ((*0x1::vector::borrow<u8>(arg0, 8) as u256) << 184) + ((*0x1::vector::borrow<u8>(arg0, 9) as u256) << 176) + ((*0x1::vector::borrow<u8>(arg0, 10) as u256) << 168) + ((*0x1::vector::borrow<u8>(arg0, 11) as u256) << 160) + ((*0x1::vector::borrow<u8>(arg0, 12) as u256) << 152) + ((*0x1::vector::borrow<u8>(arg0, 13) as u256) << 144) + ((*0x1::vector::borrow<u8>(arg0, 14) as u256) << 136) + ((*0x1::vector::borrow<u8>(arg0, 15) as u256) << 128) + ((*0x1::vector::borrow<u8>(arg0, 16) as u256) << 120) + ((*0x1::vector::borrow<u8>(arg0, 17) as u256) << 112) + ((*0x1::vector::borrow<u8>(arg0, 18) as u256) << 104) + ((*0x1::vector::borrow<u8>(arg0, 19) as u256) << 96) + ((*0x1::vector::borrow<u8>(arg0, 20) as u256) << 88) + ((*0x1::vector::borrow<u8>(arg0, 21) as u256) << 80) + ((*0x1::vector::borrow<u8>(arg0, 22) as u256) << 72) + ((*0x1::vector::borrow<u8>(arg0, 23) as u256) << 64) + ((*0x1::vector::borrow<u8>(arg0, 24) as u256) << 56) + ((*0x1::vector::borrow<u8>(arg0, 25) as u256) << 48) + ((*0x1::vector::borrow<u8>(arg0, 26) as u256) << 40) + ((*0x1::vector::borrow<u8>(arg0, 27) as u256) << 32) + ((*0x1::vector::borrow<u8>(arg0, 28) as u256) << 24) + ((*0x1::vector::borrow<u8>(arg0, 29) as u256) << 16) + ((*0x1::vector::borrow<u8>(arg0, 30) as u256) << 8) + (*0x1::vector::borrow<u8>(arg0, 31) as u256)
    }

    public fun deserialize_u256_with_hex_str(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun deserialize_u64(arg0: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) == 8, 0);
        ((*0x1::vector::borrow<u8>(arg0, 0) as u64) << 56) + ((*0x1::vector::borrow<u8>(arg0, 1) as u64) << 48) + ((*0x1::vector::borrow<u8>(arg0, 2) as u64) << 40) + ((*0x1::vector::borrow<u8>(arg0, 3) as u64) << 32) + ((*0x1::vector::borrow<u8>(arg0, 4) as u64) << 24) + ((*0x1::vector::borrow<u8>(arg0, 5) as u64) << 16) + ((*0x1::vector::borrow<u8>(arg0, 6) as u64) << 8) + (*0x1::vector::borrow<u8>(arg0, 7) as u64)
    }

    public fun deserialize_u8(arg0: &vector<u8>) : u8 {
        assert!(0x1::vector::length<u8>(arg0) == 1, 0);
        *0x1::vector::borrow<u8>(arg0, 0)
    }

    public fun deserialize_vector_with_length(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0) {
            return 0x1::vector::empty<u8>()
        };
        assert!(v0 > 8, 0);
        let v1 = vector_slice<u8>(arg0, 0, 8);
        let v2 = deserialize_u64(&v1);
        assert!(v0 == v2 + 8, 0);
        vector_slice<u8>(arg0, 8, v2 + 8)
    }

    public fun get_vector_length(arg0: &vector<u8>) : u64 {
        let v0 = vector_slice<u8>(arg0, 0, 8);
        deserialize_u64(&v0)
    }

    public fun hex_str_to_ascii(arg0: u8) : u8 {
        if (arg0 >= 0 && arg0 <= 9) {
            arg0 + 48
        } else {
            assert!(arg0 <= 15, 1);
            arg0 + 87
        }
    }

    public fun serialize_address(arg0: &mut vector<u8>, arg1: address) {
        let v0 = 0x1::bcs::to_bytes<address>(&arg1);
        assert!(0x1::vector::length<u8>(&v0) == 32, 0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun serialize_type<T0>(arg0: &mut vector<u8>) {
        serialize_vector(arg0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
    }

    public fun serialize_u128(arg0: &mut vector<u8>, arg1: u128) {
        serialize_u8(arg0, ((arg1 >> 120 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 112 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 104 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 96 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 88 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 80 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 72 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 64 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 56 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 48 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 40 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 32 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 24 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 16 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 8 & 255) as u8));
        serialize_u8(arg0, ((arg1 & 255) as u8));
    }

    public fun serialize_u128_with_hex_str(arg0: &mut vector<u8>, arg1: u128) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        serialize_u8(v1, ((arg1 & 255) as u8));
        let v2 = arg1 >> 8;
        while (v2 != 0) {
            let v3 = &mut v0;
            serialize_u8(v3, ((v2 & 255) as u8));
            v2 = v2 >> 8;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun serialize_u16(arg0: &mut vector<u8>, arg1: u16) {
        serialize_u8(arg0, ((arg1 >> 8 & 255) as u8));
        serialize_u8(arg0, ((arg1 & 255) as u8));
    }

    public fun serialize_u256(arg0: &mut vector<u8>, arg1: u256) {
        serialize_u8(arg0, ((arg1 >> 248 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 240 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 232 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 224 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 216 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 208 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 200 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 192 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 184 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 176 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 168 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 160 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 152 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 144 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 136 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 128 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 120 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 112 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 104 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 96 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 88 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 80 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 72 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 64 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 56 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 48 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 40 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 32 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 24 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 16 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 8 & 255) as u8));
        serialize_u8(arg0, ((arg1 & 255) as u8));
    }

    public fun serialize_u256_with_hex_str(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        serialize_u8(v1, ((arg1 & 255) as u8));
        let v2 = arg1 >> 8;
        while (v2 != 0) {
            let v3 = &mut v0;
            serialize_u8(v3, ((v2 & 255) as u8));
            v2 = v2 >> 8;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun serialize_u64(arg0: &mut vector<u8>, arg1: u64) {
        serialize_u8(arg0, ((arg1 >> 56 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 48 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 40 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 32 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 24 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 16 & 255) as u8));
        serialize_u8(arg0, ((arg1 >> 8 & 255) as u8));
        serialize_u8(arg0, ((arg1 & 255) as u8));
    }

    public fun serialize_u8(arg0: &mut vector<u8>, arg1: u8) {
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    public fun serialize_vector(arg0: &mut vector<u8>, arg1: vector<u8>) {
        0x1::vector::append<u8>(arg0, arg1);
    }

    public fun serialize_vector_with_length(arg0: &mut vector<u8>, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        if (v0 == 0) {
            return
        };
        serialize_u64(arg0, v0);
        serialize_vector(arg0, arg1);
    }

    public fun vector_slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        assert!(arg1 < arg2 && arg2 <= 0x1::vector::length<T0>(arg0), 0);
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun vector_split<T0: copy + drop>(arg0: &vector<T0>, arg1: T0) : vector<vector<T0>> {
        let v0 = 0x1::vector::empty<vector<T0>>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<T0>(arg0)) {
            if (*0x1::vector::borrow<T0>(arg0, v2) == arg1) {
                if (v1 < v2) {
                    0x1::vector::push_back<vector<T0>>(&mut v0, vector_slice<T0>(arg0, v1, v2));
                };
                v1 = v2 + 1;
            };
            v2 = v2 + 1;
        };
        if (v1 < v2) {
            0x1::vector::push_back<vector<T0>>(&mut v0, vector_slice<T0>(arg0, v1, v2));
        };
        v0
    }

    // decompiled from Move bytecode v6
}

