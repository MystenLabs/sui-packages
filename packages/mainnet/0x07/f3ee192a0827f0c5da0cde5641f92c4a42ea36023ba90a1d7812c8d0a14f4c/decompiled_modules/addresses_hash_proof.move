module 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_hash_proof {
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

