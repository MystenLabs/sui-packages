module 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::verifier {
    public fun verify_groth16_proof(arg0: &0x2::groth16::PreparedVerifyingKey, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>) : bool {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg2) == 64, 3);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 7, 1);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 7) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg4, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(v0);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, arg1);
        0x1::vector::append<u8>(&mut v3, arg2);
        0x1::vector::append<u8>(&mut v3, arg3);
        let v4 = 0x2::groth16::proof_points_from_bytes(v3);
        let v5 = 0x2::groth16::bn254();
        0x2::groth16::verify_groth16_proof(&v5, arg0, &v2, &v4)
    }

    public fun validate_public_inputs(arg0: &vector<vector<u8>>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: address) {
        assert!(0x1::vector::length<vector<u8>>(arg0) == 7, 1);
        assert!(0x1::vector::borrow<vector<u8>>(arg0, 0) == arg1, 2);
        assert!(0x1::vector::borrow<vector<u8>>(arg0, 1) == arg2, 2);
        let v0 = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::helpers::address_to_field_bytes(arg3);
        assert!(0x1::vector::borrow<vector<u8>>(arg0, 2) == &v0, 2);
        let v1 = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::helpers::address_to_field_bytes(arg4);
        assert!(0x1::vector::borrow<vector<u8>>(arg0, 3) == &v1, 2);
        let v2 = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::helpers::u64_to_field_bytes(arg5);
        assert!(0x1::vector::borrow<vector<u8>>(arg0, 4) == &v2, 2);
        let v3 = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::helpers::u64_to_field_bytes(arg6);
        assert!(0x1::vector::borrow<vector<u8>>(arg0, 5) == &v3, 2);
        let v4 = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::helpers::address_to_field_bytes(arg7);
        assert!(0x1::vector::borrow<vector<u8>>(arg0, 6) == &v4, 2);
    }

    // decompiled from Move bytecode v7
}

