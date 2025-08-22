module 0x415aba3cf7a82579bb2b632cb8848807db613e43436711b9f0f03f812da81984::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

