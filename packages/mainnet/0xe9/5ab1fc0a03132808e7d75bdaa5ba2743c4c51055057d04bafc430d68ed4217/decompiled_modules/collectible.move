module 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::collectible {
    struct Collectible has drop {
        dummy_field: bool,
    }

    public fun collectible() : Collectible {
        Collectible{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

