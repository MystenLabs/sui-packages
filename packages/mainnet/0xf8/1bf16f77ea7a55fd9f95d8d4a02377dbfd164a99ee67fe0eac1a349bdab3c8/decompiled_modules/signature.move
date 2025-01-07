module 0xf81bf16f77ea7a55fd9f95d8d4a02377dbfd164a99ee67fe0eac1a349bdab3c8::signature {
    public fun is_within_ttl(arg0: u64, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = (1595431050 + 30 * (arg0 - 1)) * 1000;
        v0 < v1 || v0 - v1 <= 600000
    }

    public fun verify_drand_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : bool {
        let v0 = x"0000000000000000";
        let v1 = 8;
        while (v1 > 0) {
            *0x1::vector::borrow_mut<u8>(&mut v0, v1 - 1) = ((arg2 % 256) as u8);
            arg2 = arg2 >> 8;
            v1 = v1 - 1;
        };
        0x1::vector::append<u8>(&mut arg1, v0);
        let v2 = 0x1::hash::sha2_256(arg1);
        let v3 = x"868f005eb8e6e4ca0a47c8a77ceaa5309a47978a7c71bc5cce96366b5d7a569937c529eeda66c7293784a9402801af31";
        0x2::bls12381::bls12381_min_pk_verify(&arg0, &v3, &v2)
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x2::ecdsa_k1::secp256k1_verify(&arg0, &arg1, &v0, 1)
    }

    // decompiled from Move bytecode v6
}

