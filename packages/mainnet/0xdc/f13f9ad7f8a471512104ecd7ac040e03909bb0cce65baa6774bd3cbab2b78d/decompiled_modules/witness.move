module 0xdcf13f9ad7f8a471512104ecd7ac040e03909bb0cce65baa6774bd3cbab2b78d::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

