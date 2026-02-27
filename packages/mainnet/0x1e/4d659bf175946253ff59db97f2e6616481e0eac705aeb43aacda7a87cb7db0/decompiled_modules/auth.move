module 0x1e4d659bf175946253ff59db97f2e6616481e0eac705aeb43aacda7a87cb7db0::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

