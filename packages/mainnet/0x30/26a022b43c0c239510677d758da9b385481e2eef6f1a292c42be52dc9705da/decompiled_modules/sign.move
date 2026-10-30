module 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign {
    struct EMBER has drop {
        dummy_field: bool,
    }

    public(friend) fun sign() : EMBER {
        EMBER{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

