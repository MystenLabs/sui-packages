module 0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::collectible {
    struct Collectible has drop {
        dummy_field: bool,
    }

    public fun collectible() : Collectible {
        Collectible{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

