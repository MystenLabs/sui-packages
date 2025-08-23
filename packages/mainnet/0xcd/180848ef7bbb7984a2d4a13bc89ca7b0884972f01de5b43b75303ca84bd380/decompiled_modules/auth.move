module 0xcd180848ef7bbb7984a2d4a13bc89ca7b0884972f01de5b43b75303ca84bd380::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

