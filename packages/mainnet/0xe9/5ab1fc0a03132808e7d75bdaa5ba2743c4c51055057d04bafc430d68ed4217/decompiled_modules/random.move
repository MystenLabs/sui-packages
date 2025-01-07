module 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::random {
    fun get_object_nonce(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg1);
        0x2::object::delete(v0);
        0x1::vector::append<u8>(&mut arg0, 0x2::object::uid_to_bytes(&v0));
        assert!(0x1::vector::length<u8>(&arg0) >= 32, 0);
        0x1::hash::sha3_256(arg0)
    }

    public fun get_random_number(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        let v1 = 0x2::tx_context::epoch(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        let v2 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v2));
        let v3 = get_object_nonce(v0, arg2);
        select_index(arg1 - arg0 + 1, &v3) + arg0
    }

    fun select_index(arg0: u64, arg1: &vector<u8>) : u64 {
        ((u256_from_bytes(arg1) % (arg0 as u256)) as u64)
    }

    fun u256_from_bytes(arg0: &vector<u8>) : u256 {
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

    // decompiled from Move bytecode v6
}

