module 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::cryptography {
    public(friend) fun ed25519_public_key_to_address(arg0: vector<u8>) : address {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"00");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    // decompiled from Move bytecode v6
}

