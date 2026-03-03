module 0x4e7e9b17cbf3b249b2b123ed79f276fd40fad626f236ec834758be3f2e91f4dc::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

