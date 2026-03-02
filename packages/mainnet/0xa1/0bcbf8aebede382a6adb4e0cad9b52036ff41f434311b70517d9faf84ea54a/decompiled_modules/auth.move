module 0xa10bcbf8aebede382a6adb4e0cad9b52036ff41f434311b70517d9faf84ea54a::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

