module 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

