module 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::random {
    fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun rand_u64(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64_with_seed(seed(arg0))
    }

    public fun rand_u64_range(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64_range_with_seed(seed(arg2), arg0, arg1)
    }

    fun rand_u64_range_with_seed(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > arg1, 101);
        rand_u64_with_seed(arg0) % (arg2 - arg1) + arg1
    }

    fun rand_u64_with_seed(arg0: vector<u8>) : u64 {
        bytes_to_u64(arg0)
    }

    fun seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&v0));
        0x1::hash::sha3_256(v1)
    }

    fun seed_with_value<T0>(arg0: &mut 0x2::tx_context::TxContext, arg1: &T0) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<T0>(arg1));
        0x1::hash::sha3_256(v1)
    }

    // decompiled from Move bytecode v6
}

