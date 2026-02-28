module 0xdb10893262aaa2989a9e0e7ef7688925651ebaa9165842f7095044dc622e3dda::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

