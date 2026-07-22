module 0xef1b91c41b15a653b1253f66f909211f4f13754e2eb0aefc2426ed45aff0da26::light_client {
    public fun recover_witness_key(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg1) == 65, 1);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 1;
        while (v1 < 65) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v1));
            v1 = v1 + 1;
        };
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, 0) - 31);
        0x2::ecdsa_k1::secp256k1_ecrecover(&v0, arg0, 1)
    }

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
        assert!(0x1::vector::length<u8>(&arg6) == 33, 2);
        let v0 = serialize_header(arg0, arg1, arg2, arg3, arg4);
        recover_witness_key(&v0, &arg5) == arg6
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

