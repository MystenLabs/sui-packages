module 0xe10c95298fecc3f1a87936afd10caa784a64fc296e274655e3d0f4e95d5ed3e2::swaplock_tx {
    public fun leaf(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    public fun parse_burn(arg0: vector<u8>) : (u64, u64, u64) {
        let (v0, v1) = read_varint(&arg0, 10);
        assert!(0 < v0, 1);
        let (v2, v3) = read_varint(&arg0, v1);
        assert!(v2 == 15, 1);
        let (_, v5) = read_varint(&arg0, v3 + 8);
        let (v6, v7) = read_varint(&arg0, v5);
        let (v8, _) = read_varint(&arg0, v7 + 8);
        (read_u64_le(&arg0, v7), v8, v6)
    }

    public fun parse_burn_v2(arg0: vector<u8>) : (u64, u64, u64, vector<u8>) {
        let (v0, v1) = read_varint(&arg0, 10);
        assert!(v0 >= 1, 1);
        let (v2, v3) = read_varint(&arg0, v1);
        assert!(v2 == 0, 1);
        let (_, v5) = read_varint(&arg0, v3 + 8);
        let (_, v7) = read_varint(&arg0, v5);
        let (v8, v9) = read_varint(&arg0, v7);
        let (v10, v11) = read_varint(&arg0, v9 + 8);
        assert!(*0x1::vector::borrow<u8>(&arg0, v11) == 1, 2);
        let (v12, v13) = read_varint(&arg0, v11 + 1 + 33 + 33 + 8);
        assert!(v12 == 20, 2);
        let v14 = 0x1::vector::empty<u8>();
        let v15 = 0;
        while (v15 < 20) {
            0x1::vector::push_back<u8>(&mut v14, *0x1::vector::borrow<u8>(&arg0, v13 + v15));
            v15 = v15 + 1;
        };
        (read_u64_le(&arg0, v9), v10, v8, v14)
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << 8 * (v1 as u8);
            v1 = v1 + 1;
        };
        v0
    }

    fun read_varint(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = arg1;
        loop {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            v2 = v2 + 1;
            v0 = v0 | ((v3 & 127) as u64) << v1;
            if (v3 < 128) {
                break
            };
            v1 = v1 + 7;
        };
        (v0, v2)
    }

    // decompiled from Move bytecode v7
}

