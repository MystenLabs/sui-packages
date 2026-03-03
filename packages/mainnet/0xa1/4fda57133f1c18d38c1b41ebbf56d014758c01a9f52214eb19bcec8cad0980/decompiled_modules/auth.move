module 0xa14fda57133f1c18d38c1b41ebbf56d014758c01a9f52214eb19bcec8cad0980::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

