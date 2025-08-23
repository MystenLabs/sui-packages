module 0x8282128ad7479cf813d4ab6500111259a560d53aeab9e0b40323dfc065a7cdea::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

