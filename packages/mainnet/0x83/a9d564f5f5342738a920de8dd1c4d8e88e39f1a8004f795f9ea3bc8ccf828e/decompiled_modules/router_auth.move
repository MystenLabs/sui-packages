module 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth {
    struct RouterAuth has copy, drop {
        dummy_field: bool,
    }

    public(friend) fun new() : RouterAuth {
        RouterAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

