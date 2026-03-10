module 0x15ea7a22c4023f414cd65378e962a2aa95df905f07247eb3ed628fae058c2798::utils {
    public fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        v0
    }

    // decompiled from Move bytecode v6
}

