module 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::light_client {
    public fun serialize_header(arg0: vector<u8>, arg1: u32, arg2: u64, arg3: vector<u8>, arg4: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 20, 2);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 2);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        let v1 = &mut v0;
        write_u32_le(v1, arg1);
        let v2 = &mut v0;
        write_varint(v2, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        let v3 = &mut v0;
        write_varint(v3, arg4);
        v0
    }

    public fun verify_witness_signature(arg0: vector<u8>, arg1: u32, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(&arg5) == 65, 1);
        assert!(0x1::vector::length<u8>(&arg6) == 33, 2);
        let v0 = serialize_header(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 1;
        while (v2 < 65) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg5, v2));
            v2 = v2 + 1;
        };
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg5, 0) - 31);
        0x2::ecdsa_k1::secp256k1_ecrecover(&v1, &v0, 1) == arg6
    }

    fun write_u32_le(arg0: &mut vector<u8>, arg1: u32) {
        let v0 = 0;
        while (v0 < 4) {
            0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
            arg1 = arg1 >> 8;
            v0 = v0 + 1;
        };
    }

    fun write_varint(arg0: &mut vector<u8>, arg1: u64) {
        while (arg1 >= 128) {
            0x1::vector::push_back<u8>(arg0, ((arg1 & 127 | 128) as u8));
            arg1 = arg1 >> 7;
        };
        0x1::vector::push_back<u8>(arg0, (arg1 as u8));
    }

    // decompiled from Move bytecode v7
}

