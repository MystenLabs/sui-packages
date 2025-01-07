module 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create_counter(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg1),
            value : arg0,
        }
    }

    public fun increment(arg0: &mut Counter) : u64 {
        arg0.value = arg0.value + 1;
        arg0.value
    }

    public fun rand_u64_range(arg0: &mut Counter, arg1: &address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        rand_u64_range_with_seed(seed(arg0, arg1, arg4), arg2, arg3)
    }

    public fun rand_u64_range_with_seed(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == arg1) {
            arg1
        } else {
            assert!(arg2 > arg1, 1);
            rand_u64_with_seed(arg0) % (arg2 - arg1) + arg1
        }
    }

    public fun rand_u64_with_seed(arg0: vector<u8>) : u64 {
        0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::bcd::bytes_to_u64(arg0)
    }

    fun seed(arg0: &mut Counter, arg1: &address, arg2: &0x2::clock::Clock) : vector<u8> {
        increment(arg0);
        let v0 = arg0.value;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::address::to_bytes(*arg1));
        0x1::hash::sha3_256(v2)
    }

    // decompiled from Move bytecode v6
}

