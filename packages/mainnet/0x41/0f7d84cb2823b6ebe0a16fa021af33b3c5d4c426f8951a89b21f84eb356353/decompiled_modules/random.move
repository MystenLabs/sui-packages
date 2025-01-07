module 0x410f7d84cb2823b6ebe0a16fa021af33b3c5d4c426f8951a89b21f84eb356353::random {
    public fun get_random_number(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        let v1 = rand_no_counter(v0, arg1);
        select(arg0, &v1)
    }

    fun nonce_primitives(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        0x2::object::delete(v0);
        let v2 = 0x2::tx_context::epoch(arg0);
        let v3 = 0x2::tx_context::sender(arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v3));
        v1
    }

    fun rand_no_counter(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, nonce_primitives(arg1));
        rand_with_nonce(arg0)
    }

    fun rand_with_nonce(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) >= 32, 0);
        0x1::hash::sha3_256(arg0)
    }

    fun select(arg0: u64, arg1: &vector<u8>) : u64 {
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

