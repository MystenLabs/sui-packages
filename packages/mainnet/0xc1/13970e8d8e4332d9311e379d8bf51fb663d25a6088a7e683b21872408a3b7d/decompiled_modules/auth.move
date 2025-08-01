module 0xc113970e8d8e4332d9311e379d8bf51fb663d25a6088a7e683b21872408a3b7d::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

