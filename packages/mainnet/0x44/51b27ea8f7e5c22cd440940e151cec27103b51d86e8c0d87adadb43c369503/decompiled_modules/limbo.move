module 0x4451b27ea8f7e5c22cd440940e151cec27103b51d86e8c0d87adadb43c369503::limbo {
    struct Limbo has copy, drop, store {
        dummy_field: bool,
    }

    public fun make() : Limbo {
        Limbo{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

