module 0x465e58cbce9a363c4a63fef0d089d79634f7e6c8a0ddaf486ff4440d9d4009ba::sign {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : SCALLOP {
        SCALLOP{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

