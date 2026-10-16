module 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign {
    struct HAEDAL has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : HAEDAL {
        HAEDAL{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

