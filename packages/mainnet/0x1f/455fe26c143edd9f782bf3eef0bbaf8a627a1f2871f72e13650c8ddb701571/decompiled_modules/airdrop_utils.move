module 0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::airdrop_utils {
    public fun verify(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : u256 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        let (v1, v2) = 0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::merkle_proof::verify_with_index(&arg1, arg0, 0x1::hash::sha3_256(v0));
        assert!(v1, 0);
        v2
    }

    // decompiled from Move bytecode v6
}

