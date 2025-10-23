module 0x9bf7344cd56145c55af7f2e5dd0b92aa5b2f4eecd8d2ed3a4d239fa1c5e1425a::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

