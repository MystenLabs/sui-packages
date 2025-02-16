module 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::payload_decoder {
    fun decode_be_u32(arg0: &mut 0x2::bcs::BCS) : u32 {
        let v0 = 4;
        let v1 = 0x1::vector::empty<u8>();
        while (v0 != 0) {
            0x1::vector::push_back<u8>(&mut v1, 0x2::bcs::peel_u8(arg0));
            v0 = v0 - 1;
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v1)) {
            v2 = v2 | (*0x1::vector::borrow<u8>(&v1, v3) as u32) << ((3 - v3) as u8) * 8;
            v3 = v3 + 1;
        };
        v2
    }

    fun decode_bytes_array(arg0: &mut 0x2::bcs::BCS) : vector<vector<u8>> {
        decode_left_padded_u256(arg0);
        let v0 = decode_left_padded_u256(arg0);
        let v1 = decode_left_padded_u256(arg0);
        let v2 = v1 - 32;
        if (v2 > 0) {
            while (v2 != 0) {
                0x2::bcs::peel_u8(arg0);
                v2 = v2 - 1;
            };
        };
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = decode_left_padded_u256(arg0);
            let v6 = 0x1::vector::empty<u8>();
            let v7 = 0;
            while (v7 < v5) {
                0x1::vector::push_back<u8>(&mut v6, 0x2::bcs::peel_u8(arg0));
                v7 = v7 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v3, v6);
            v4 = v4 + 1;
        };
        v3
    }

    public fun decode_fee_payload(arg0: vector<u8>) : (u32, u256, u256) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        let v2 = &mut v0;
        let v3 = &mut v0;
        let v4 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v4) == 0, 1);
        (decode_be_u32(v1), decode_left_padded_u256(v2), decode_left_padded_u256(v3))
    }

    fun decode_left_padded_u256(arg0: &mut 0x2::bcs::BCS) : u256 {
        let v0 = 32;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = false;
        while (v0 != 0) {
            let v3 = 0x2::bcs::peel_u8(arg0);
            if (!v2) {
                if (v3 != 0) {
                    v2 = true;
                    0x1::vector::push_back<u8>(&mut v1, v3);
                };
            } else {
                0x1::vector::push_back<u8>(&mut v1, v3);
            };
            v0 = v0 - 1;
        };
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v1)) {
            v4 = v4 | (*0x1::vector::borrow<u8>(&v1, v5) as u256) << ((0x1::vector::length<u8>(&v1) - 1 - v5) as u8) * 8;
            v5 = v5 + 1;
        };
        v4
    }

    public fun decode_mint_payload(arg0: vector<u8>) : (u32, u256, address, u256, u256, u256) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        let v2 = &mut v0;
        let v3 = &mut v0;
        let v4 = &mut v0;
        let v5 = &mut v0;
        let v6 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v6) == 0, 1);
        (decode_be_u32(v1), decode_left_padded_u256(v2), 0x2::bcs::peel_address(&mut v0), decode_left_padded_u256(v3), decode_left_padded_u256(v4), decode_left_padded_u256(v5))
    }

    public fun decode_signatures(arg0: vector<u8>) : vector<vector<u8>> {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v2) == 0, 1);
        decode_bytes_array(v1)
    }

    fun decode_u256_array(arg0: &mut 0x2::bcs::BCS) : vector<u256> {
        let v0 = decode_left_padded_u256(arg0);
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u256>(&mut v1, decode_left_padded_u256(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun decode_valset(arg0: vector<u8>) : (u32, u256, vector<vector<u8>>, vector<u256>, u256) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        let v2 = &mut v0;
        0x2::bcs::peel_u256(&mut v0);
        0x2::bcs::peel_u256(&mut v0);
        let v3 = &mut v0;
        let v4 = &mut v0;
        decode_left_padded_u256(v4);
        let v5 = &mut v0;
        let v6 = &mut v0;
        let v7 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v7) == 0, 1);
        (decode_be_u32(v1), decode_left_padded_u256(v2), decode_valset_array(v5), decode_u256_array(v6), decode_left_padded_u256(v3))
    }

    fun decode_valset_array(arg0: &mut 0x2::bcs::BCS) : vector<vector<u8>> {
        let v0 = decode_left_padded_u256(arg0);
        let v1 = decode_left_padded_u256(arg0);
        let v2 = v1 - 32;
        while (v2 != 0) {
            0x2::bcs::peel_u8(arg0);
            v2 = v2 - 1;
        };
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = decode_left_padded_u256(arg0);
            let v6 = 0x1::vector::empty<u8>();
            let v7 = 0;
            while (v7 < v5) {
                0x1::vector::push_back<u8>(&mut v6, 0x2::bcs::peel_u8(arg0));
                v7 = v7 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v3, v6);
            while (v7 % 32 != 0) {
                0x2::bcs::peel_u8(arg0);
                v7 = v7 + 1;
            };
            v4 = v4 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v6
}

