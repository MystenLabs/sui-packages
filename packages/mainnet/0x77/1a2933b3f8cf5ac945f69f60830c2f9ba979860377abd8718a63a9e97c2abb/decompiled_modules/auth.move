module 0x771a2933b3f8cf5ac945f69f60830c2f9ba979860377abd8718a63a9e97c2abb::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

