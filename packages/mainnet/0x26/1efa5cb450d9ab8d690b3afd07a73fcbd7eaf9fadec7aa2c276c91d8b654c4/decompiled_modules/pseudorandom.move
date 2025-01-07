module 0x261efa5cb450d9ab8d690b3afd07a73fcbd7eaf9fadec7aa2c276c91d8b654c4::pseudorandom {
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

    public fun nonce_clock(arg0: &0x2::clock::Clock) : vector<u8> {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        0x2::bcs::to_bytes<u64>(&v0)
    }

    public fun nonce_counter(arg0: &mut Counter) : vector<u8> {
        let v0 = increment(arg0);
        0x2::bcs::to_bytes<u256>(&v0)
    }

    public fun nonce_primitives(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::fresh_object_address(arg0);
        let v1 = 0x1::bcs::to_bytes<address>(&v0);
        let v2 = 0x2::tx_context::epoch(arg0);
        let v3 = 0x2::tx_context::sender(arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v3));
        v1
    }

    // decompiled from Move bytecode v6
}

