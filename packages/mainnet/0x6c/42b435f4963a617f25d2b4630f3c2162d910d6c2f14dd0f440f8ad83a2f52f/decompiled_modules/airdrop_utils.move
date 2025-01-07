module 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::airdrop_utils {
    public fun verify(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : u256 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        let (v1, v2) = 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::merkle_proof::verify_with_index(&arg1, arg0, 0x1::hash::sha3_256(v0));
        assert!(v1, 0);
        v2
    }

    // decompiled from Move bytecode v6
}

