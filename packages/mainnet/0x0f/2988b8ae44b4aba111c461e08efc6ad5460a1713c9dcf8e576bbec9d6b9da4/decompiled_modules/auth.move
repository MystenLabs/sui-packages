module 0xf2988b8ae44b4aba111c461e08efc6ad5460a1713c9dcf8e576bbec9d6b9da4::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

