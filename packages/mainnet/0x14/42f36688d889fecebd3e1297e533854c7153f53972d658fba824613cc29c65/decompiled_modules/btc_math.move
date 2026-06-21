module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math {
    public fun append_u32_le(arg0: &mut vector<u8>, arg1: u32) {
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
    }

    public fun bits_to_target(arg0: u32) : u256 {
        let v0 = ((arg0 >> 24) as u8);
        if (v0 <= 3) {
            ((arg0 & 8388607) as u256) >> ((8 * (3 - v0)) as u8)
        } else {
            ((arg0 & 8388607) as u256) << ((8 * (v0 - 3)) as u8)
        }
    }

    fun bytes_of_target(arg0: u256) : u8 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = 255;
        while (arg0 & 1 << v0 == 0 && v0 > 0) {
            v0 = v0 - 1;
        };
        (((v0 as u32) / 8 + 1) as u8)
    }

    public fun bytes_to_u256_le(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906834341847105537);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v1) as u256) << ((v1 * 8) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun calc_work_from_bits(arg0: u32) : u256 {
        let v0 = bits_to_target(arg0);
        if (v0 == 0) {
            return 0
        };
        0x1::u256::bitwise_not(v0) / (v0 + 1) + 1
    }

    public fun extract_u32_le(arg0: &vector<u8>, arg1: u64) : u32 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u32) | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u32) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u32) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u32) << 24
    }

    public fun read_byte_varint(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = *0x1::vector::borrow<u8>(arg0, arg1);
        assert!(v0 < 253, 13906835153596317703);
        (v0 as u64)
    }

    public fun reverse_bytes_32(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906834466401157121);
        let v0 = b"";
        let v1 = 32;
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v2));
        };
        v0
    }

    public fun sha256d(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(0x1::hash::sha2_256(arg0))
    }

    public fun target_to_bits(arg0: u256) : u32 {
        let v0 = bytes_of_target(arg0);
        let v1 = v0;
        let v2 = if (v0 <= 3) {
            ((arg0 << 8 * (3 - v0) & 4294967295) as u32)
        } else {
            ((arg0 >> 8 * (v0 - 3) & 4294967295) as u32)
        };
        if (v2 & 8388608 > 0) {
            v2 = v2 >> 8;
            v1 = v0 + 1;
        };
        v2 | (v1 as u32) << 24
    }

    public fun verify_derived_coinbase(arg0: &vector<u8>, arg1: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        assert!(v0 >= 5, 13906835303920041989);
        assert!(v1 >= 5, 13906835308215009285);
        assert!(read_byte_varint(arg1, 0) > read_byte_varint(arg0, 0), 13906835329690107913);
        let v2 = v0 - 5;
        assert!(v1 >= 1 + v2 + 4, 13906835355459649541);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(arg0, 1 + v3) == *0x1::vector::borrow<u8>(arg1, 1 + v3), 13906835381229846539);
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < 4) {
            assert!(*0x1::vector::borrow<u8>(arg0, v0 - 4 + v4) == *0x1::vector::borrow<u8>(arg1, v1 - 4 + v4), 13906835428474617869);
            v4 = v4 + 1;
        };
    }

    public fun verify_merkle_proof(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: u64) : bool {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834844358410243);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906834848653377539);
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg1, v1);
            assert!(0x1::vector::length<u8>(v2) == 32, 13906834887308083203);
            let v3 = b"";
            if (arg3 % 2 == 1) {
                0x1::vector::append<u8>(&mut v3, 0x1::hash::sha2_256(*v2));
                0x1::vector::append<u8>(&mut v3, v0);
            } else {
                0x1::vector::append<u8>(&mut v3, v0);
                0x1::vector::append<u8>(&mut v3, 0x1::hash::sha2_256(*v2));
            };
            v0 = sha256d(v3);
            arg3 = arg3 >> 1;
            v1 = v1 + 1;
        };
        v0 == arg0
    }

    // decompiled from Move bytecode v7
}

