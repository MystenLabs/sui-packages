module 0x84bf90417c2dafa955e0448557d71320c734f217c71ae23a15bd3886465eedcf::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

