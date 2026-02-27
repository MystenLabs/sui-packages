module 0x7858367462c6ca090f3357296643ae945c920b544e4b1339a7ada53a0d40b8a5::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

