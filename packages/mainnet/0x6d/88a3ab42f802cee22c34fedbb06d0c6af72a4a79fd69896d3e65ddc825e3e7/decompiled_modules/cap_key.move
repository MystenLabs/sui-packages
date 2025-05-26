module 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::cap_key {
    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun cap_key() : CapKey {
        CapKey{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

