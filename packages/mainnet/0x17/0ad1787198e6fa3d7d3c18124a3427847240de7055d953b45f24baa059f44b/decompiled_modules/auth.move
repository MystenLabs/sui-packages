module 0x170ad1787198e6fa3d7d3c18124a3427847240de7055d953b45f24baa059f44b::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

