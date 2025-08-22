module 0xb57f617284aadff20da89e9d8eef2741aa2384267d1fbd3fd66dd666486719d2::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

