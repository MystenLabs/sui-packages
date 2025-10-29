module 0x97d2165197ce6616beb4ba43feaff0dcf7f61cdca35cea80ab9aa083f7fc5863::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

