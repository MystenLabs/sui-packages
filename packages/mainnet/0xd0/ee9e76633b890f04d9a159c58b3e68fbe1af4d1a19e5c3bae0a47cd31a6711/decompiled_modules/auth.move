module 0xd0ee9e76633b890f04d9a159c58b3e68fbe1af4d1a19e5c3bae0a47cd31a6711::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

