module 0xd7315641d566b4883ba5f44930df31a1d98f189c5adc1cbe81e96dff92ec938b::utils {
    public entry fun verify(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : u256 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        let (v1, v2) = 0xd7315641d566b4883ba5f44930df31a1d98f189c5adc1cbe81e96dff92ec938b::merkle_proof::verify_with_index(&arg1, arg0, 0x1::hash::sha3_256(v0));
        assert!(v1, 0);
        v2
    }

    // decompiled from Move bytecode v6
}

