module 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::coder {
    public fun ascii_to_address(arg0: &0x1::ascii::String) : address {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::address::length() * 2) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 < 58) {
                v3 - 48
            } else {
                v3 - 87
            };
            let v5 = v1 << 4;
            v1 = v5 + (v4 as u256);
            v2 = v2 + 1;
        };
        0x2::address::from_u256(v1)
    }

    public fun decode_bool_with_offset(arg0: &vector<u8>, arg1: u64) : bool {
        decode_u8_with_offset(arg0, arg1) != 0
    }

    public fun decode_multi_u8_with_offset(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        while (arg2 >= 1) {
            arg2 = arg2 - 1;
            0x1::vector::push_back<u8>(v1, decode_u8_with_offset(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun decode_u128_with_offset(arg0: &vector<u8>, arg1: u64) : u128 {
        let v0 = 16;
        let v1 = 0;
        while (v0 > 0) {
            let v2 = v0 - 1;
            v0 = v2;
            let v3 = ((v1 << 8) as u128);
            v1 = v3 + (*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u128);
        };
        v1
    }

    public fun decode_u64(arg0: &vector<u8>) : u64 {
        decode_u64_with_offset(arg0, 0)
    }

    public fun decode_u64_with_offset(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 8;
        let v1 = 0;
        while (v0 > 0) {
            let v2 = v0 - 1;
            v0 = v2;
            let v3 = ((v1 << 8) as u64);
            v1 = v3 + (*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u64);
        };
        v1
    }

    public fun decode_u64x2(arg0: &vector<u8>) : (u64, u64) {
        (decode_u64_with_offset(arg0, 0), decode_u64_with_offset(arg0, 8))
    }

    public fun decode_u64x3(arg0: &vector<u8>) : (u64, u64, u64) {
        (decode_u64_with_offset(arg0, 0), decode_u64_with_offset(arg0, 8), decode_u64_with_offset(arg0, 16))
    }

    public fun decode_u64x4(arg0: &vector<u8>) : (u64, u64, u64, u64) {
        (decode_u64_with_offset(arg0, 0), decode_u64_with_offset(arg0, 8), decode_u64_with_offset(arg0, 16), decode_u64_with_offset(arg0, 24))
    }

    public fun decode_u64x5(arg0: &vector<u8>) : (u64, u64, u64, u64, u64) {
        (decode_u64_with_offset(arg0, 0), decode_u64_with_offset(arg0, 8), decode_u64_with_offset(arg0, 16), decode_u64_with_offset(arg0, 24), decode_u64_with_offset(arg0, 32))
    }

    public fun decode_u8_with_offset(arg0: &vector<u8>, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(arg0, arg1)
    }

    public fun encode_u64(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        encode_u64_back(v1, arg0);
        v0
    }

    public fun encode_u64_back(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        while (v0 < 8) {
            v0 = v0 + 1;
            0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
            arg1 = arg1 >> 8;
        };
    }

    public fun encode_u64x2(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        encode_u64_back(v1, arg0);
        encode_u64_back(v1, arg1);
        v0
    }

    public fun encode_u64x3(arg0: u64, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        encode_u64_back(v1, arg0);
        encode_u64_back(v1, arg1);
        encode_u64_back(v1, arg2);
        v0
    }

    public fun encode_u64x4(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        encode_u64_back(v1, arg0);
        encode_u64_back(v1, arg1);
        encode_u64_back(v1, arg2);
        encode_u64_back(v1, arg3);
        v0
    }

    public fun parse_bool(arg0: &vector<u8>, arg1: &mut u64) : bool {
        *arg1 = *arg1 + 1;
        decode_bool_with_offset(arg0, *arg1)
    }

    public fun parse_u128(arg0: &vector<u8>, arg1: &mut u64) : u128 {
        *arg1 = *arg1 + 16;
        decode_u128_with_offset(arg0, *arg1)
    }

    public fun parse_u64(arg0: &vector<u8>, arg1: &mut u64) : u64 {
        *arg1 = *arg1 + 8;
        decode_u64_with_offset(arg0, *arg1)
    }

    public fun string_to_address(arg0: &0x1::string::String) : address {
        let v0 = 0x1::string::bytes(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::address::length() * 2) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 < 58) {
                v3 - 48
            } else {
                v3 - 87
            };
            let v5 = v1 << 4;
            v1 = v5 + (v4 as u256);
            v2 = v2 + 1;
        };
        0x2::address::from_u256(v1)
    }

    public fun type_to_package_address<T0>() : address {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        ascii_to_address(&v1)
    }

    // decompiled from Move bytecode v6
}

