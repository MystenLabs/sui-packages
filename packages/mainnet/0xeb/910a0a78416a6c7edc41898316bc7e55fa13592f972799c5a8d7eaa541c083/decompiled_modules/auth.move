module 0xeb910a0a78416a6c7edc41898316bc7e55fa13592f972799c5a8d7eaa541c083::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

