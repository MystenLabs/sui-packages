module 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::utils {
    public(friend) fun calculate_chunk_identifier_hash(arg0: u16, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u16>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, arg1);
        calculate_hash(&v1)
    }

    public(friend) fun calculate_hash(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public fun transfer_objs<T0: store + key>(arg0: vector<T0>, arg1: address) {
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

