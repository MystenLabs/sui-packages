module 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::collectible {
    struct Collectible has drop {
        dummy_field: bool,
    }

    public fun collectible() : Collectible {
        Collectible{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

