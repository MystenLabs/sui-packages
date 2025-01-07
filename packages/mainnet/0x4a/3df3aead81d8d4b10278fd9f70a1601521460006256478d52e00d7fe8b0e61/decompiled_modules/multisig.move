module 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::multisig {
    public(friend) fun check_multisig_address_eq(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: u16, arg3: address) : bool {
        derive_multisig_address(arg0, arg1, arg2) == arg3
    }

    public(friend) fun derive_multisig_address(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: u16) : address {
        let v0 = b"";
        let v1 = 0x1::vector::length<vector<u8>>(&arg0);
        let v2 = 0x1::vector::length<u8>(&arg1);
        assert!(v1 == v2, 9223372221538369537);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v2) {
            v3 = v3 + (*0x1::vector::borrow<u8>(&arg1, v4) as u16);
            v4 = v4 + 1;
        };
        assert!(arg2 > 0 && arg2 <= v3, 9223372264488173571);
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg2));
        let v5 = 0;
        while (v5 < v1) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg0, v5));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v5));
            v5 = v5 + 1;
        };
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    // decompiled from Move bytecode v6
}

