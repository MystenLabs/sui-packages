module 0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::auth {
    struct GatewayAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : GatewayAuth {
        GatewayAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

