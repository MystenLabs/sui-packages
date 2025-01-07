module 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs {
    public fun deserialize(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) >= 32, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, v1) as u256) << ((8 * (31 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun serialize<T0: drop>(arg0: T0, arg1: T0, arg2: T0) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<T0>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<T0>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<T0>(&arg2));
        v0
    }

    // decompiled from Move bytecode v6
}

