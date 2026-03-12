module 0x3dcf9beed0b9d976a3efe05523e178809f0af1fc8b7fa86a003e71ad8171d567::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

