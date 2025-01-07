module 0x27dd21a3e9fa6483b2da62194f8ebf6e5f062ff0d0a68139257384b97977d239::pseuso_random {
    fun from_seed(arg0: vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) >= 8, 9223372161408827391);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u64(&mut v0)
    }

    fun raw_seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::tx_context::epoch(arg0);
        let v2 = 0x2::object::new(arg0);
        let v3 = b"";
        0x1::vector::append<u8>(&mut v3, 0x2::object::uid_to_bytes(&v2));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        0x2::object::delete(v2);
        v3
    }

    public(friend) fun rng(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1 >= arg0, 9223372122754121727);
        from_seed(seed(arg2)) % (arg1 - arg0) + arg0
    }

    fun seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x1::hash::sha3_256(raw_seed(arg0))
    }

    // decompiled from Move bytecode v6
}

