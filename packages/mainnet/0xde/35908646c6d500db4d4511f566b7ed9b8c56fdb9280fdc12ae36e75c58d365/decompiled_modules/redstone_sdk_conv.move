module 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_conv {
    public fun from_bytes_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun from_bytes_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

