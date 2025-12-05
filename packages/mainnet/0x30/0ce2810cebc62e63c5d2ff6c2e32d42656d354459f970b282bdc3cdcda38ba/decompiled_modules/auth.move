module 0x300ce2810cebc62e63c5d2ff6c2e32d42656d354459f970b282bdc3cdcda38ba::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

