module 0x7f4a45635a7c0d67df3ceabda9b4e3b8d59e8e28175d0dcb8fd80c29a6b1312::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

