module 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::pseuso_random {
    fun from_seed(arg0: vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) >= 8, 13906834255947759615);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u64(&mut v0)
    }

    fun raw_seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::tx_context::epoch(arg0);
        let v2 = 0x2::object::new(arg0);
        0x2::object::delete(v2);
        let v3 = b"";
        0x1::vector::append<u8>(&mut v3, 0x2::object::uid_to_bytes(&v2));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        v3
    }

    public(friend) fun rng(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1 >= arg0, 13906834217293053951);
        from_seed(seed(arg2, arg3)) % (arg1 - arg0) + arg0
    }

    fun seed(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = raw_seed(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::hash::sha3_256(v0)
    }

    // decompiled from Move bytecode v6
}

