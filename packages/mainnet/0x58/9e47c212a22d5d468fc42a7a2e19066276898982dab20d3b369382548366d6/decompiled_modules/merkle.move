module 0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::merkle {
    public fun leaf(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, b"NOTRE_LEGACY_MIGRATION_V1");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x1::hash::sha3_256(v0)
    }

    fun less_than(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return *0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun parent(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32 && 0x1::vector::length<u8>(&arg1) == 32, 1);
        let v0 = x"01";
        if (less_than(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x1::hash::sha3_256(v0)
    }

    public fun verify(arg0: &vector<u8>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: vector<vector<u8>>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
        assert!(0x1::vector::length<vector<u8>>(&arg4) <= 32, 2);
        let v0 = leaf(arg1, arg2, arg3);
        0x1::vector::reverse<vector<u8>>(&mut arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg4)) {
            v0 = parent(v0, 0x1::vector::pop_back<vector<u8>>(&mut arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg4);
        assert!(v0 == *arg0, 3);
    }

    // decompiled from Move bytecode v7
}

