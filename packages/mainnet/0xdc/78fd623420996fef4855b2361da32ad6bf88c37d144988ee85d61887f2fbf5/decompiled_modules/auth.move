module 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

