module 0x351242415afc1daab9d93b83bbc85fa9b72c5152049ac54c990ffbf7f719dca8::utils {
    public entry fun verify(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : u256 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        let (v1, v2) = 0x351242415afc1daab9d93b83bbc85fa9b72c5152049ac54c990ffbf7f719dca8::merkle_proof::verify_with_index(&arg1, arg0, 0x1::hash::sha3_256(v0));
        assert!(v1, 0);
        v2
    }

    // decompiled from Move bytecode v6
}

