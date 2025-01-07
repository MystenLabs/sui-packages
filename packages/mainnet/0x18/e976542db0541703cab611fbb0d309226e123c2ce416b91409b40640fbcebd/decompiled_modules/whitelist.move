module 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::whitelist {
    public fun verify(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: vector<vector<u8>>, arg4: address) {
        let v0 = 0x2::bcs::to_bytes<address>(&arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::merkle_proof::verify(&arg3, arg0, 0x1::hash::sha3_256(v0)), 0);
    }

    // decompiled from Move bytecode v6
}

