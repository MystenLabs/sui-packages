module 0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::utils {
    public entry fun verify(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : u256 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        let (v1, v2) = 0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::merkle_proof::verify_with_index(&arg1, arg0, 0x1::hash::sha3_256(v0));
        assert!(v1, 0);
        v2
    }

    // decompiled from Move bytecode v6
}

