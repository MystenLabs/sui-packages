module 0x7e583ddd38a1f3c2c92685346eb99250eef897babfa287b94ab93eaf76f6f212::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

