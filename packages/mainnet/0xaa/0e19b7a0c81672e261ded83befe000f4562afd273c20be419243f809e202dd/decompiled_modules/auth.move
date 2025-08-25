module 0xaa0e19b7a0c81672e261ded83befe000f4562afd273c20be419243f809e202dd::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

