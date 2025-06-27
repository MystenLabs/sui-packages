module 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::cap_key {
    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun cap_key() : CapKey {
        CapKey{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

