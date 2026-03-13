module 0x8a1b1f71e145b246a6af7729210794f0e08f7baebcc04c37596727200d5fb023::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

