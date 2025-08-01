module 0xc53b8300219a16d680c39f405bc7ae90f62ffd07dec3f68fbbc95ab866fee815::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

