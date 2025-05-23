module 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::caller {
    struct PIM has drop {
        version: u32,
    }

    public(friend) fun get_caller() : PIM {
        PIM{version: 1}
    }

    // decompiled from Move bytecode v6
}

