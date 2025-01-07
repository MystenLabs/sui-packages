module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::serialize {
    public fun serialize_address(arg0: address) : vector<u8> {
        0x2::bcs::to_bytes<address>(&arg0)
    }

    public fun serialize_u256_be(arg0: u256) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun serialize_u32_be(arg0: u32) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u32>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun serialize_u64_be(arg0: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

