module 0xb7d811992cc0a2320832001474f4f6d36020748b49bf0399d11969c33a62c61::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

