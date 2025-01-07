module 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::rand {
    public fun from_seed(arg0: vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) >= 8, 1);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u64(&mut v0)
    }

    public fun raw_seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::tx_context::epoch(arg0);
        let v2 = 0x2::object::new(arg0);
        0x2::object::delete(v2);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, 0x2::object::uid_to_bytes(&v2));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        v3
    }

    public fun rng(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1 >= arg0, 0);
        from_seed(seed(arg2)) % (arg1 - arg0) + arg0
    }

    public fun rng_with_clock(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1 > arg0, 0);
        from_seed(seed_with_clock(arg2, arg3)) % (arg1 - arg0) + arg0
    }

    public fun rng_with_clock_and_counter<T0>(arg0: &T0, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::counter::Counter<T0>, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2 > arg1, 0);
        from_seed(seed_with_clock_and_counter<T0>(arg0, arg3, arg4, arg5)) % (arg2 - arg1) + arg1
    }

    public fun rng_with_counter<T0>(arg0: &T0, arg1: u64, arg2: u64, arg3: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::counter::Counter<T0>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2 > arg1, 0);
        from_seed(seed_with_counter<T0>(arg0, arg3, arg4)) % (arg2 - arg1) + arg1
    }

    public fun seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x1::hash::sha3_256(raw_seed(arg0))
    }

    public fun seed_with_clock(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = raw_seed(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::hash::sha3_256(v0)
    }

    public fun seed_with_clock_and_counter<T0>(arg0: &T0, arg1: &0x2::clock::Clock, arg2: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::counter::Counter<T0>, arg3: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = raw_seed(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::counter::increment<T0>(arg2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&v2));
        0x1::hash::sha3_256(v0)
    }

    public fun seed_with_counter<T0>(arg0: &T0, arg1: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::counter::Counter<T0>, arg2: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = raw_seed(arg2);
        let v1 = 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::counter::increment<T0>(arg1, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&v1));
        0x1::hash::sha3_256(v0)
    }

    // decompiled from Move bytecode v6
}

