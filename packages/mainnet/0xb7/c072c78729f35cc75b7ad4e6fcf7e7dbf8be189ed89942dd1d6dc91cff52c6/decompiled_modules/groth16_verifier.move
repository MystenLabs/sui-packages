module 0xb7c072c78729f35cc75b7ad4e6fcf7e7dbf8be189ed89942dd1d6dc91cff52c6::groth16_verifier {
    struct VerifyingKey has copy, drop, store {
        alpha_g1: vector<u8>,
        beta_g2: vector<u8>,
        gamma_g2: vector<u8>,
        delta_g2: vector<u8>,
        ic: vector<vector<u8>>,
    }

    fun add_g1(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::bls12381::g1_from_bytes(&arg0);
        let v1 = 0x2::bls12381::g1_from_bytes(&arg1);
        element_to_bytes_g1(0x2::bls12381::g1_add(&v0, &v1))
    }

    fun compute_public_input_commitment(arg0: &vector<vector<u8>>, arg1: &vector<vector<u8>>) : vector<u8> {
        let v0 = *0x1::vector::borrow<vector<u8>>(arg1, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            v0 = add_g1(v0, scalar_mul_g1(*0x1::vector::borrow<vector<u8>>(arg0, v1), *0x1::vector::borrow<vector<u8>>(arg1, v1 + 1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun element_to_bytes_g1(arg0: 0x2::group_ops::Element<0x2::bls12381::G1>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 64) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_default_verifying_key() : VerifyingKey {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, x"0000000000000000000000000000000000000000000000000000000000000000");
        VerifyingKey{
            alpha_g1 : x"0000000000000000000000000000000000000000000000000000000000000000",
            beta_g2  : x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
            gamma_g2 : x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
            delta_g2 : x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
            ic       : v0,
        }
    }

    fun multi_pairing_check(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>) : bool {
        let v0 = 0x2::bls12381::g1_from_bytes(0x1::vector::borrow<vector<u8>>(&arg0, 0));
        let v1 = 0x2::bls12381::g2_from_bytes(0x1::vector::borrow<vector<u8>>(&arg1, 0));
        let v2 = 0x2::bls12381::pairing(&v0, &v1);
        let v3 = 1;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v4 = 0x2::bls12381::g1_from_bytes(0x1::vector::borrow<vector<u8>>(&arg0, v3));
            let v5 = 0x2::bls12381::g2_from_bytes(0x1::vector::borrow<vector<u8>>(&arg1, v3));
            let v6 = 0x2::bls12381::pairing(&v4, &v5);
            let v7 = &v2;
            v2 = 0x2::bls12381::gt_add(v7, &v6);
            v3 = v3 + 1;
        };
        0x2::bls12381::gt_identity() == v2
    }

    fun negate_g1(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x2::bls12381::g1_from_bytes(&arg0);
        element_to_bytes_g1(0x2::bls12381::g1_neg(&v0))
    }

    public fun new_verifying_key(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>) : VerifyingKey {
        VerifyingKey{
            alpha_g1 : arg0,
            beta_g2  : arg1,
            gamma_g2 : arg2,
            delta_g2 : arg3,
            ic       : arg4,
        }
    }

    fun scalar_mul_g1(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::bls12381::g1_from_bytes(&arg1);
        let v1 = 0x2::bls12381::scalar_from_bytes(&arg0);
        element_to_bytes_g1(0x2::bls12381::g1_mul(&v1, &v0))
    }

    fun verify_pairing_equation(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, negate_g1(arg0));
        0x1::vector::push_back<vector<u8>>(v1, arg3);
        0x1::vector::push_back<vector<u8>>(v1, arg7);
        0x1::vector::push_back<vector<u8>>(v1, arg2);
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = &mut v2;
        0x1::vector::push_back<vector<u8>>(v3, arg1);
        0x1::vector::push_back<vector<u8>>(v3, arg4);
        0x1::vector::push_back<vector<u8>>(v3, arg5);
        0x1::vector::push_back<vector<u8>>(v3, arg6);
        multi_pairing_check(v0, v2)
    }

    public fun verify_proof(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: &VerifyingKey) : bool {
        assert!(0x1::vector::length<u8>(&arg0) == 64, 0);
        assert!(0x1::vector::length<u8>(&arg1) == 128, 0);
        assert!(0x1::vector::length<u8>(&arg2) == 64, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg3) + 1 == 0x1::vector::length<vector<u8>>(&arg4.ic), 1);
        verify_pairing_equation(arg0, arg1, arg2, arg4.alpha_g1, arg4.beta_g2, arg4.gamma_g2, arg4.delta_g2, compute_public_input_commitment(&arg3, &arg4.ic))
    }

    // decompiled from Move bytecode v6
}

