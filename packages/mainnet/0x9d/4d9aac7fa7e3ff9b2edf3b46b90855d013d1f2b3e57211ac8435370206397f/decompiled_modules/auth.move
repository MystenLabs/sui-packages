module 0x9d4d9aac7fa7e3ff9b2edf3b46b90855d013d1f2b3e57211ac8435370206397f::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

