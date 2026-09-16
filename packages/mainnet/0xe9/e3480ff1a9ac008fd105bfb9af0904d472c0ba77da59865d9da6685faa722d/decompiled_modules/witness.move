module 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

