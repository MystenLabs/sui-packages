module 0x9a6ef9b4de499fe0bd482e8d1f77f300977ad1327ed8e225ae7adbb9978aaac6::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

