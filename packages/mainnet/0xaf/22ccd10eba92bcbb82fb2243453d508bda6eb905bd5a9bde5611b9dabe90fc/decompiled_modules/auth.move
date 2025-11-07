module 0xaf22ccd10eba92bcbb82fb2243453d508bda6eb905bd5a9bde5611b9dabe90fc::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

