module 0x98a328bd410b9aa2b45c7406149a4ccd73262559d551e4a080edf004c25a7883::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

