module 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::era {
    struct V1 has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun v1() : V1 {
        V1{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

