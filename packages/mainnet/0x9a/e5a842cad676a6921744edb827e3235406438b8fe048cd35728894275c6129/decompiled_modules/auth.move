module 0x9ae5a842cad676a6921744edb827e3235406438b8fe048cd35728894275c6129::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

