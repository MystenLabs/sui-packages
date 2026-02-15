module 0x28f01e0e04cf9b211aeca301e808b0445e1a60b569ffcd7c46fd6d16022f52bc::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

