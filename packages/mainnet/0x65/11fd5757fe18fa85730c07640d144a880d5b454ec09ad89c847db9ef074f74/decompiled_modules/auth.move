module 0x6511fd5757fe18fa85730c07640d144a880d5b454ec09ad89c847db9ef074f74::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

