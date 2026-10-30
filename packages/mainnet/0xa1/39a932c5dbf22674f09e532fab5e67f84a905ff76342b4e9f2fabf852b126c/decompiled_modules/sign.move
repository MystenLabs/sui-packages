module 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::sign {
    struct HAEDAL has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : HAEDAL {
        HAEDAL{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

