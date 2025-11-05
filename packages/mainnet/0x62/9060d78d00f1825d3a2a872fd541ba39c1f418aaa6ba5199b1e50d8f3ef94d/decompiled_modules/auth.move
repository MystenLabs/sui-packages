module 0x629060d78d00f1825d3a2a872fd541ba39c1f418aaa6ba5199b1e50d8f3ef94d::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

