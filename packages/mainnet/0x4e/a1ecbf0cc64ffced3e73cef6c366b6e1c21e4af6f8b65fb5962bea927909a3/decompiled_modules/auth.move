module 0x4ea1ecbf0cc64ffced3e73cef6c366b6e1c21e4af6f8b65fb5962bea927909a3::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

