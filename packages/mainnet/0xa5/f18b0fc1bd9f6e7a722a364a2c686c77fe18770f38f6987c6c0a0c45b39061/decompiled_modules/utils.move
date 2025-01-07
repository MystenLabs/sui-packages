module 0xa5f18b0fc1bd9f6e7a722a364a2c686c77fe18770f38f6987c6c0a0c45b39061::utils {
    public fun rand(arg0: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        0x2::object::delete(v0);
        let v2 = 0x2::tx_context::epoch(arg0);
        let v3 = 0x2::tx_context::sender(arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v3));
        let v4 = 0x1::hash::sha3_256(v1);
        u256_from_bytes(&v4)
    }

    public fun u256_from_bytes(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 <= 32, 1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0 << 8;
            v0 = v3 + (*0x1::vector::borrow<u8>(arg0, v2) as u256);
            v2 = v2 + 1;
        };
        v0
    }

    public fun u64_from_bytes(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 <= 8, 1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0 * 10 + (*0x1::vector::borrow<u8>(arg0, v2) as u64);
            v0 = v3 - 48;
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

