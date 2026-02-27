module 0x7bddba214bcb301d48c4fc0635ebf00b7a2774fb84e1ff7550de4eeaf69e70f7::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

