module 0xd913eb163f8cfb99717ba37069099c6915e6ddefcdebc5043d29d23f879bbb8::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

