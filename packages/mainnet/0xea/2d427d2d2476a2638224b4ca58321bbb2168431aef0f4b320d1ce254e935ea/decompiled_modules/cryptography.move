module 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::cryptography {
    public(friend) fun ed25519_public_key_to_address(arg0: vector<u8>) : address {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"00");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    // decompiled from Move bytecode v6
}

