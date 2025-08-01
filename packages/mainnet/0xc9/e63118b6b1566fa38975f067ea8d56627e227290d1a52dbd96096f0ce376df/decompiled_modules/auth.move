module 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

