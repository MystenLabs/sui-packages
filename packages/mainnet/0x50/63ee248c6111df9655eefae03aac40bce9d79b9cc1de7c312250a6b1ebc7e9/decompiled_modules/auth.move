module 0x5063ee248c6111df9655eefae03aac40bce9d79b9cc1de7c312250a6b1ebc7e9::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

