module 0x18292bb2d61fbd9777b82b5c7f5d430e5a0b7ca946971ce5e94c178a6212b5e0::kdf {
    public(friend) fun kdf(arg0: &0x2::group_ops::Element<0x2::bls12381::GT>, arg1: &0x2::group_ops::Element<0x2::bls12381::G2>, arg2: &0x2::group_ops::Element<0x2::bls12381::G1>, arg3: address, arg4: u8) : vector<u8> {
        let v0 = b"SUI-SEAL-IBE-BLS12381-H2-00";
        let v1 = &mut v0;
        append_ref(v1, 0x2::group_ops::bytes<0x2::bls12381::GT>(arg0));
        let v2 = &mut v0;
        append_ref(v2, 0x2::group_ops::bytes<0x2::bls12381::G2>(arg1));
        let v3 = &mut v0;
        append_ref(v3, 0x2::group_ops::bytes<0x2::bls12381::G1>(arg2));
        let v4 = &mut v0;
        let v5 = 0x2::address::to_bytes(arg3);
        append_ref(v4, &v5);
        0x1::vector::push_back<u8>(&mut v0, arg4);
        0x1::hash::sha3_256(v0)
    }

    public(friend) fun append_ref(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun hash_to_g1_with_dst(arg0: &vector<u8>) : 0x2::group_ops::Element<0x2::bls12381::G1> {
        let v0 = b"SUI-SEAL-IBE-BLS12381-00";
        let v1 = &mut v0;
        append_ref(v1, arg0);
        0x2::bls12381::hash_to_g1(&v0)
    }

    // decompiled from Move bytecode v7
}

