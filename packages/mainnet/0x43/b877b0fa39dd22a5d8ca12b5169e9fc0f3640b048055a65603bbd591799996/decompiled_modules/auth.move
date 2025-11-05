module 0x43b877b0fa39dd22a5d8ca12b5169e9fc0f3640b048055a65603bbd591799996::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

