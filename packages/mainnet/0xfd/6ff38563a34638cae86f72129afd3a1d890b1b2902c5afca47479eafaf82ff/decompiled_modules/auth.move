module 0xfd6ff38563a34638cae86f72129afd3a1d890b1b2902c5afca47479eafaf82ff::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

