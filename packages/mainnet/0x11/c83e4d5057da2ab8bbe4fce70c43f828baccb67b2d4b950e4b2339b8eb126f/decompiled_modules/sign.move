module 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign {
    struct EMBER has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : EMBER {
        EMBER{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

