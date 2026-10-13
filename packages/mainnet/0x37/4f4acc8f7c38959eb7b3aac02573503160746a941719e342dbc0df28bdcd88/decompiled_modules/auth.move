module 0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

