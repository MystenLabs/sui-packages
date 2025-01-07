module 0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u256,
    }

    public fun bcs_u128_from_bytes(arg0: vector<u8>) : u128 {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u128(&mut v0)
    }

    public fun bcs_u64_from_bytes(arg0: vector<u8>) : u64 {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u64(&mut v0)
    }

    public fun bcs_u8_from_bytes(arg0: vector<u8>) : u8 {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u8(&mut v0)
    }

    fun increment(arg0: &mut Counter) : u256 {
        let v0 = &mut arg0.value;
        *v0 = *v0 + 1;
        *v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    fun nonce_counter(arg0: &mut Counter) : vector<u8> {
        let v0 = increment(arg0);
        0x2::bcs::to_bytes<u256>(&v0)
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

    public fun rand(arg0: vector<u8>, arg1: &mut Counter, arg2: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, nonce_counter(arg1));
        0x1::vector::append<u8>(&mut arg0, nonce_primitives(arg2));
        rand_with_nonce(arg0)
    }

    public fun rand_no_counter(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, nonce_primitives(arg1));
        rand_with_nonce(arg0)
    }

    public fun rand_no_ctx(arg0: vector<u8>, arg1: &mut Counter) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, nonce_counter(arg1));
        rand_with_nonce(arg0)
    }

    public fun rand_no_nonce(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, nonce_counter(arg0));
        0x1::vector::append<u8>(&mut v0, nonce_primitives(arg1));
        rand_with_nonce(v0)
    }

    public fun rand_with_counter(arg0: &mut Counter) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, nonce_counter(arg0));
        rand_with_nonce(v0)
    }

    public fun rand_with_ctx(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, nonce_primitives(arg0));
        rand_with_nonce(v0)
    }

    public fun rand_with_nonce(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) >= 32, 1);
        0x1::hash::sha3_256(arg0)
    }

    public fun select_u64(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 32, 1);
        ((u256_from_bytes(arg1) % (arg0 as u256)) as u64)
    }

    public fun u128_from_bytes(arg0: &vector<u8>) : u128 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 <= 16, 1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0 << 8;
            v0 = v3 + (*0x1::vector::borrow<u8>(arg0, v2) as u128);
            v2 = v2 + 1;
        };
        v0
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
            let v3 = v0 << 8;
            v0 = v3 + (*0x1::vector::borrow<u8>(arg0, v2) as u64);
            v2 = v2 + 1;
        };
        v0
    }

    public fun u8_from_bytes(arg0: &vector<u8>) : u8 {
        assert!(0x1::vector::length<u8>(arg0) <= 1, 1);
        if (0x1::vector::length<u8>(arg0) < 1) {
            0
        } else {
            *0x1::vector::borrow<u8>(arg0, 0)
        }
    }

    // decompiled from Move bytecode v6
}

