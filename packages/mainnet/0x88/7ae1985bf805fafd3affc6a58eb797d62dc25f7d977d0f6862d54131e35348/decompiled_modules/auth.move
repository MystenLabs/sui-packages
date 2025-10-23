module 0x887ae1985bf805fafd3affc6a58eb797d62dc25f7d977d0f6862d54131e35348::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

