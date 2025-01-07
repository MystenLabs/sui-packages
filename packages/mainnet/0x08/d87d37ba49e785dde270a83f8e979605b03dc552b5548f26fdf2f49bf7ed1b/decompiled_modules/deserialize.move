module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::deserialize {
    public fun deserialize_address(arg0: &vector<u8>, arg1: u64, arg2: u64) : address {
        let v0 = 0x2::bcs::new(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(arg0, arg1, arg1 + arg2));
        0x2::bcs::peel_address(&mut v0)
    }

    public fun deserialize_u256_be(arg0: &vector<u8>, arg1: u64, arg2: u64) : u256 {
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(arg0, arg1, arg1 + arg2);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun deserialize_u32_be(arg0: &vector<u8>, arg1: u64, arg2: u64) : u32 {
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(arg0, arg1, arg1 + arg2);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_u32(&mut v1)
    }

    public fun deserialize_u64_be(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(arg0, arg1, arg1 + arg2);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_u64(&mut v1)
    }

    // decompiled from Move bytecode v6
}

