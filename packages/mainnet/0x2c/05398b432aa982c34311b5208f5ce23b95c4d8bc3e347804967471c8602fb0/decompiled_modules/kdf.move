module 0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::kdf {
    public(friend) fun kdf(arg0: &0x2::group_ops::Element<0x2::bls12381::GT>, arg1: &0x2::group_ops::Element<0x2::bls12381::G2>, arg2: &0x2::group_ops::Element<0x2::bls12381::G1>, arg3: address, arg4: u8) : vector<u8> {
        let v0 = b"SUI-SEAL-IBE-BLS12381-H2-00";
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::GT>(arg0));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G2>(arg1));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::push_back<u8>(&mut v0, arg4);
        0x1::hash::sha3_256(v0)
    }

    public(friend) fun hash_to_g1_with_dst(arg0: &vector<u8>) : 0x2::group_ops::Element<0x2::bls12381::G1> {
        let v0 = b"SUI-SEAL-IBE-BLS12381-00";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::bls12381::hash_to_g1(&v0)
    }

    // decompiled from Move bytecode v6
}

