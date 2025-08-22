module 0x5b77b4f5278cdd3fc7ed1ad798252914e7b40aa4b067e07a888adadd1b979af::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

