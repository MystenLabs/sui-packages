module 0x97be9dc32986b0e46ca18c21bd1c3d063a27c7d615df21a3945df2881719e341::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

