module 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::constants {
    struct Constants has drop {
        dummy_field: bool,
    }

    public fun MAX_MESSAGE_LENGTH() : u64 {
        3031
    }

    public fun MAX_XPUBKEY_SIZE() : u64 {
        32
    }

    public fun MIN_MESSAGE_LENGTH() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

