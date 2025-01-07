module 0x54cd930f19358a6051190df1a547c3a2d590261b345fef1a1aca4074bb1bcf31::pseudorandom {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u256,
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
        let v0 = 0x2::tx_context::fresh_object_address(arg0);
        let v1 = 0x1::bcs::to_bytes<address>(&v0);
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
        0x1::hash::sha3_256(arg0)
    }

    public fun rand_without_counter(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, nonce_primitives(arg1));
        rand_with_nonce(arg0)
    }

    public fun rand_without_ctx(arg0: vector<u8>, arg1: &mut Counter) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, nonce_counter(arg1));
        rand_with_nonce(arg0)
    }

    public fun rand_without_nonce(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, nonce_counter(arg0));
        0x1::vector::append<u8>(&mut v0, nonce_primitives(arg1));
        rand_with_nonce(v0)
    }

    // decompiled from Move bytecode v6
}

