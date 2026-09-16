module 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

