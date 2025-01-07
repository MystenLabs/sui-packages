module 0xce266330f0513845cfe947a5c333c4fafb66d8e68c537c637413a41545594790::whitelist {
    public fun verify(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: vector<vector<u8>>, arg4: address) {
        let v0 = 0x2::bcs::to_bytes<address>(&arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::merkle_proof::verify(&arg3, arg0, 0x1::hash::sha3_256(v0)), 0);
    }

    // decompiled from Move bytecode v6
}

