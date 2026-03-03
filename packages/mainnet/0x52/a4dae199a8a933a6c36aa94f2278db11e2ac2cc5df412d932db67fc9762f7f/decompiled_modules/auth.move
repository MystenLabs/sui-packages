module 0x52a4dae199a8a933a6c36aa94f2278db11e2ac2cc5df412d932db67fc9762f7f::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

