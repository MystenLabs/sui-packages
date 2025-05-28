module 0x5790373dae32f531d99449de51829ec593efb69f9e08b79b8aefc7935f8bd97c::cap_key {
    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun cap_key() : CapKey {
        CapKey{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

