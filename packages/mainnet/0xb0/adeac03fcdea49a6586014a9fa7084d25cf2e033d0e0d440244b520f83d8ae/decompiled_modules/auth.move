module 0xb0adeac03fcdea49a6586014a9fa7084d25cf2e033d0e0d440244b520f83d8ae::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

