module 0xcbfe8257548c89cf9da5fe3a373f1d8c10daac207e4b098e891fca248ac36912::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

