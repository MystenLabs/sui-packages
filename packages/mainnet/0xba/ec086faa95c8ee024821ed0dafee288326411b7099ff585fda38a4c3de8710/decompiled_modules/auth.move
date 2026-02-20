module 0xbaec086faa95c8ee024821ed0dafee288326411b7099ff585fda38a4c3de8710::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

