module 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi {
    struct ABIStream has drop {
        data: vector<u8>,
        cur: u64,
    }

    public fun decode_address(arg0: &mut ABIStream) : address {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 32 <= 0x1::vector::length<u8>(v0), 1);
        let v2 = 0;
        let v3 = b"";
        while (v2 < 12) {
            assert!(*0x1::vector::borrow<u8>(v0, v1 + v2) == 0, 2);
            0x1::vector::push_back<u8>(&mut v3, 0);
            v2 = v2 + 1;
        };
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(v0, v1 + v2));
            v2 = v2 + 1;
        };
        arg0.cur = v1 + 32;
        0x2::address::from_bytes(v3)
    }

    public fun decode_bool(arg0: &mut ABIStream) : bool {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 32 <= 0x1::vector::length<u8>(v0), 1);
        let v2 = slice<u8>(v0, v1, 32);
        arg0.cur = v1 + 32;
        if (v2 == x"0000000000000000000000000000000000000000000000000000000000000000") {
            false
        } else {
            assert!(v2 == x"0000000000000000000000000000000000000000000000000000000000000001", 3);
            true
        }
    }

    public fun decode_bytes(arg0: &mut ABIStream) : vector<u8> {
        let v0 = decode_u256(arg0);
        let v1 = (v0 as u64);
        let v2 = if (v1 % 32 == 0) {
            0
        } else {
            32 - v1 % 32
        };
        let v3 = &arg0.data;
        let v4 = arg0.cur;
        assert!(v4 + v1 + v2 <= 0x1::vector::length<u8>(v3), 1);
        arg0.cur = v4 + v1 + v2;
        slice<u8>(v3, v4, v1)
    }

    public fun decode_bytes32(arg0: &mut ABIStream) : vector<u8> {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 32 <= 0x1::vector::length<u8>(v0), 1);
        arg0.cur = v1 + 32;
        slice<u8>(v0, v1, 32)
    }

    public fun decode_u256(arg0: &mut ABIStream) : u256 {
        let v0 = &arg0.data;
        let v1 = arg0.cur;
        assert!(v1 + 32 <= 0x1::vector::length<u8>(v0), 1);
        let v2 = slice<u8>(v0, v1, 32);
        0x1::vector::reverse<u8>(&mut v2);
        arg0.cur = v1 + 32;
        let v3 = 0x2::bcs::new(v2);
        0x2::bcs::peel_u256(&mut v3)
    }

    public fun decode_u256_value(arg0: vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 5);
        0x1::vector::reverse<u8>(&mut arg0);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u256(&mut v0)
    }

    public fun decode_u32(arg0: &mut ABIStream) : u32 {
        let v0 = decode_u256(arg0);
        assert!(v0 <= 4294967295, 7);
        (v0 as u32)
    }

    public fun decode_u64(arg0: &mut ABIStream) : u64 {
        let v0 = decode_u256(arg0);
        assert!(v0 <= 18446744073709551615, 7);
        (v0 as u64)
    }

    public fun decode_u8(arg0: &mut ABIStream) : u8 {
        let v0 = decode_u256(arg0);
        assert!(v0 <= 255, 7);
        (v0 as u8)
    }

    public fun encode_address(arg0: &mut vector<u8>, arg1: address) {
        0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<address>(&arg1));
    }

    public fun encode_bool(arg0: &mut vector<u8>, arg1: bool) {
        let v0 = if (arg1) {
            x"0000000000000000000000000000000000000000000000000000000000000001"
        } else {
            x"0000000000000000000000000000000000000000000000000000000000000000"
        };
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun encode_bytes(arg0: &mut vector<u8>, arg1: vector<u8>) {
        encode_u256(arg0, (0x1::vector::length<u8>(&arg1) as u256));
        0x1::vector::append<u8>(arg0, arg1);
        if (0x1::vector::length<u8>(&arg1) % 32 != 0) {
            let v0 = 0;
            while (v0 < 32 - 0x1::vector::length<u8>(&arg1) % 32) {
                0x1::vector::push_back<u8>(arg0, 0);
                v0 = v0 + 1;
            };
        };
    }

    public fun encode_left_padded_bytes32(arg0: &mut vector<u8>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 32, 5);
        let v0 = 0;
        while (v0 < 32 - 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(arg0, 0);
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(arg0, arg1);
    }

    public fun encode_packed_address(arg0: &mut vector<u8>, arg1: address) {
        0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<address>(&arg1));
    }

    public fun encode_packed_bytes(arg0: &mut vector<u8>, arg1: vector<u8>) {
        0x1::vector::append<u8>(arg0, arg1);
    }

    public fun encode_packed_bytes32(arg0: &mut vector<u8>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 32, 6);
        0x1::vector::append<u8>(arg0, arg1);
        let v0 = 0;
        while (v0 < 32 - 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(arg0, 0);
            v0 = v0 + 1;
        };
    }

    public fun encode_packed_u256(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun encode_packed_u32(arg0: &mut vector<u8>, arg1: u32) {
        let v0 = 0x2::bcs::to_bytes<u32>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun encode_packed_u64(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun encode_packed_u8(arg0: &mut vector<u8>, arg1: u8) {
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    public fun encode_right_padded_bytes32(arg0: &mut vector<u8>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 32, 6);
        0x1::vector::append<u8>(arg0, arg1);
        let v0 = 0;
        while (v0 < 32 - 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(arg0, 0);
            v0 = v0 + 1;
        };
    }

    public fun encode_selector(arg0: &mut vector<u8>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 4, 4);
        0x1::vector::append<u8>(arg0, arg1);
    }

    public fun encode_u256(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun encode_u32(arg0: &mut vector<u8>, arg1: u32) {
        encode_u256(arg0, (arg1 as u256));
    }

    public fun encode_u64(arg0: &mut vector<u8>, arg1: u64) {
        encode_u256(arg0, (arg1 as u256));
    }

    public fun encode_u8(arg0: &mut vector<u8>, arg1: u8) {
        encode_u256(arg0, (arg1 as u256));
    }

    public fun new_stream(arg0: vector<u8>) : ABIStream {
        ABIStream{
            data : arg0,
            cur  : 0,
        }
    }

    public(friend) fun slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        assert!(arg1 + arg2 <= 0x1::vector::length<T0>(arg0), 1);
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg1 + arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

