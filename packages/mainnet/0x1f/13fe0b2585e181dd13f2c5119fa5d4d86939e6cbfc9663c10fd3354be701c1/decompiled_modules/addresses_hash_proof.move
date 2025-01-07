module 0x1f13fe0b2585e181dd13f2c5119fa5d4d86939e6cbfc9663c10fd3354be701c1::addresses_hash_proof {
    public fun hash_addresses(arg0: vector<address>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(0x1::vector::borrow<address>(&arg0, v1)));
            v1 = v1 + 1;
        };
        0x1::hash::sha3_256(v0)
    }

    // decompiled from Move bytecode v6
}

