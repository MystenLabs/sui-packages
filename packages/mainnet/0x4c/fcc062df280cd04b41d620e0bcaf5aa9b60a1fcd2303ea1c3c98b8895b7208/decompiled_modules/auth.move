module 0x4cfcc062df280cd04b41d620e0bcaf5aa9b60a1fcd2303ea1c3c98b8895b7208::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

