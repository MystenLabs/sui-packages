module 0x6d0b4a37126f7d244adcd95af6d18b7731ea7b70787493e639e6f58664cd48d5::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

