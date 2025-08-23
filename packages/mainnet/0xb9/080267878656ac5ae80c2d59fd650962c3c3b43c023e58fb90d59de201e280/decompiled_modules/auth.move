module 0xb9080267878656ac5ae80c2d59fd650962c3c3b43c023e58fb90d59de201e280::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

