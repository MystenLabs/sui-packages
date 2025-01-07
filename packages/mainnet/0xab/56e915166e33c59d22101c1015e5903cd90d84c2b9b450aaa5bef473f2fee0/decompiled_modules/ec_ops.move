module 0xab56e915166e33c59d22101c1015e5903cd90d84c2b9b450aaa5bef473f2fee0::ec_ops {
    struct ElGamalEncryption has drop, store {
        ephemeral: 0x2::group_ops::Element<0x2::bls12381::G1>,
        ciphertext: 0x2::group_ops::Element<0x2::bls12381::G1>,
    }

    struct EqualityProof has drop, store {
        a1: 0x2::group_ops::Element<0x2::bls12381::G1>,
        a2: 0x2::group_ops::Element<0x2::bls12381::G1>,
        a3: 0x2::group_ops::Element<0x2::bls12381::G1>,
        z1: 0x2::group_ops::Element<0x2::bls12381::Scalar>,
        z2: 0x2::group_ops::Element<0x2::bls12381::Scalar>,
    }

    struct IbeEncryption has copy, drop, store {
        u: 0x2::group_ops::Element<0x2::bls12381::G2>,
        v: vector<u8>,
        w: vector<u8>,
    }

    public fun bls_min_sig_verify(arg0: &vector<u8>, arg1: &0x2::group_ops::Element<0x2::bls12381::G2>, arg2: &0x2::group_ops::Element<0x2::bls12381::G1>) : bool {
        let v0 = 0x2::bls12381::hash_to_g1(arg0);
        let v1 = 0x2::bls12381::pairing(&v0, arg1);
        let v2 = 0x2::bls12381::g2_generator();
        let v3 = 0x2::bls12381::pairing(arg2, &v2);
        0x2::group_ops::equal<0x2::bls12381::GT>(&v1, &v3)
    }

    public fun elgamal_decrypt(arg0: &0x2::group_ops::Element<0x2::bls12381::Scalar>, arg1: &ElGamalEncryption) : 0x2::group_ops::Element<0x2::bls12381::G1> {
        let v0 = 0x2::bls12381::g1_mul(arg0, &arg1.ephemeral);
        0x2::bls12381::g1_sub(&arg1.ciphertext, &v0)
    }

    public fun equility_verify(arg0: &0x2::group_ops::Element<0x2::bls12381::G1>, arg1: &0x2::group_ops::Element<0x2::bls12381::G1>, arg2: &ElGamalEncryption, arg3: &ElGamalEncryption, arg4: &EqualityProof) : bool {
        let v0 = fiat_shamir_challenge(arg0, arg1, arg2, arg3, &arg4.a1, &arg4.a2, &arg4.a3);
        let v1 = 0x2::bls12381::g1_generator();
        let v2 = 0x2::bls12381::g1_mul(&arg4.z1, &v1);
        let v3 = 0x2::bls12381::g1_mul(&v0, arg0);
        let v4 = 0x2::bls12381::g1_add(&arg4.a1, &v3);
        if (!0x2::group_ops::equal<0x2::bls12381::G1>(&v2, &v4)) {
            return false
        };
        let v5 = 0x2::bls12381::g1_generator();
        let v6 = 0x2::bls12381::g1_mul(&arg4.z2, &v5);
        let v7 = 0x2::bls12381::g1_mul(&v0, &arg3.ephemeral);
        let v8 = 0x2::bls12381::g1_add(&arg4.a2, &v7);
        if (!0x2::group_ops::equal<0x2::bls12381::G1>(&v6, &v8)) {
            return false
        };
        let v9 = 0x1::vector::singleton<0x2::group_ops::Element<0x2::bls12381::Scalar>>(v0);
        0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::Scalar>>(&mut v9, 0x2::bls12381::scalar_neg(&v0));
        0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::Scalar>>(&mut v9, arg4.z1);
        0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::Scalar>>(&mut v9, 0x2::bls12381::scalar_neg(&arg4.z2));
        let v10 = 0x1::vector::singleton<0x2::group_ops::Element<0x2::bls12381::G1>>(arg3.ciphertext);
        0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::G1>>(&mut v10, arg2.ciphertext);
        0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::G1>>(&mut v10, arg2.ephemeral);
        0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::G1>>(&mut v10, *arg1);
        let v11 = 0x2::bls12381::g1_multi_scalar_multiplication(&v9, &v10);
        if (!0x2::group_ops::equal<0x2::bls12381::G1>(&v11, &arg4.a3)) {
            return false
        };
        true
    }

    public fun fiat_shamir_challenge(arg0: &0x2::group_ops::Element<0x2::bls12381::G1>, arg1: &0x2::group_ops::Element<0x2::bls12381::G1>, arg2: &ElGamalEncryption, arg3: &ElGamalEncryption, arg4: &0x2::group_ops::Element<0x2::bls12381::G1>, arg5: &0x2::group_ops::Element<0x2::bls12381::G1>, arg6: &0x2::group_ops::Element<0x2::bls12381::G1>) : 0x2::group_ops::Element<0x2::bls12381::Scalar> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(arg0));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(arg1));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(&arg2.ephemeral));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(&arg2.ciphertext));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(&arg3.ephemeral));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(&arg3.ciphertext));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(arg4));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(arg5));
        0x1::vector::append<u8>(&mut v0, *0x2::group_ops::bytes<0x2::bls12381::G1>(arg6));
        let v1 = 0x2::hash::blake2b256(&v0);
        *0x1::vector::borrow_mut<u8>(&mut v1, 0x1::vector::length<u8>(&v1) - 1) = 0;
        0x2::bls12381::scalar_from_bytes(&v1)
    }

    public fun ibe_decrypt(arg0: IbeEncryption, arg1: &0x2::group_ops::Element<0x2::bls12381::G1>) : 0x1::option::Option<vector<u8>> {
        let v0 = 0x2::bls12381::pairing(arg1, &arg0.u);
        let v1 = b"HASH2 - ";
        0x1::vector::append<u8>(&mut v1, *0x2::group_ops::bytes<0x2::bls12381::GT>(&v0));
        let v2 = 0x2::hash::blake2b256(&v1);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&arg0.v)) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4) ^ *0x1::vector::borrow<u8>(&arg0.v, v4));
            v4 = v4 + 1;
        };
        let v5 = b"HASH4 - ";
        0x1::vector::append<u8>(&mut v5, v3);
        let v6 = 0x2::hash::blake2b256(&v5);
        let v7 = 0x1::vector::empty<u8>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u8>(&arg0.w)) {
            0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v6, v8) ^ *0x1::vector::borrow<u8>(&arg0.w, v8));
            v8 = v8 + 1;
        };
        let v9 = b"HASH3 - ";
        0x1::vector::append<u8>(&mut v9, v3);
        0x1::vector::append<u8>(&mut v9, v7);
        let v10 = 0x2::hash::blake2b256(&v9);
        let v11 = modulo_order(&v10);
        let v12 = 0x2::bls12381::scalar_from_bytes(&v11);
        let v13 = 0x2::bls12381::g2_generator();
        let v14 = 0x2::bls12381::g2_mul(&v12, &v13);
        if (0x2::group_ops::equal<0x2::bls12381::G2>(&arg0.u, &v14)) {
            0x1::option::some<vector<u8>>(v7)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun ibe_encryption_from_bytes(arg0: &vector<u8>) : IbeEncryption {
        assert!(0x1::vector::length<u8>(arg0) == 160, 0);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 96) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u8>();
        while (v1 < 128) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v3 = 0x1::vector::empty<u8>();
        while (v1 < 160) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        IbeEncryption{
            u : 0x2::bls12381::g2_from_bytes(&v0),
            v : v2,
            w : v3,
        }
    }

    fun modulo_order(arg0: &vector<u8>) : vector<u8> {
        let v0 = *arg0;
        loop {
            let v1 = try_substract(&v0);
            if (0x1::option::is_none<vector<u8>>(&v1)) {
                break
            };
            v0 = *0x1::option::borrow<vector<u8>>(&v1);
        };
        v0
    }

    fun try_substract(arg0: &vector<u8>) : 0x1::option::Option<vector<u8>> {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
        let v0 = x"73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001";
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        let v3 = 0;
        while (v2 < 32) {
            let v4 = 31 - v2;
            let v5 = *0x1::vector::borrow<u8>(arg0, v4);
            let v6 = (*0x1::vector::borrow<u8>(&v0, v4) as u16) + (v3 as u16);
            if (v6 > (v5 as u16)) {
                v3 = 1;
                0x1::vector::push_back<u8>(&mut v1, ((256 + (v5 as u16) - v6) as u8));
            } else {
                v3 = 0;
                0x1::vector::push_back<u8>(&mut v1, (((v5 as u16) - v6) as u8));
            };
            v2 = v2 + 1;
        };
        if (v3 != 0) {
            0x1::option::none<vector<u8>>()
        } else {
            0x1::vector::reverse<u8>(&mut v1);
            0x1::option::some<vector<u8>>(v1)
        }
    }

    // decompiled from Move bytecode v6
}

