module 0x9a9c73eb2f6f5fa48f63756ad1083a668188005e4f97fc6dc9fc3414726e4661::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

