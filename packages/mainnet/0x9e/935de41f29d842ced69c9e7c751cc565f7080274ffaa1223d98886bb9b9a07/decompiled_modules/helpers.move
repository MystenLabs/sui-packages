module 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::helpers {
    public fun address_to_field_bytes(arg0: address) : vector<u8> {
        u256_to_bytes_le(0x2::address::to_u256(arg0) % 21888242871839275222246405745257275088548364400416034343698204186575808495617)
    }

    public fun u256_to_bytes_be(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = 31;
        loop {
            *0x1::vector::borrow_mut<u8>(&mut v0, v2) = ((arg0 & 255) as u8);
            arg0 = arg0 >> 8;
            if (v2 == 0) {
                break
            };
            v2 = v2 - 1;
        };
        v0
    }

    public fun u256_to_bytes_le(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> (((7 - v1) * 8) as u8) & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_to_field_bytes(arg0: u64) : vector<u8> {
        let v0 = u64_to_le_bytes(arg0);
        let v1 = 0;
        while (v1 < 24) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_to_le_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

