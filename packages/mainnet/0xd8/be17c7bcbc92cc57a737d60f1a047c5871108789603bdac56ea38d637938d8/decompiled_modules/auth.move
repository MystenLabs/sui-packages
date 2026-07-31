module 0xd8be17c7bcbc92cc57a737d60f1a047c5871108789603bdac56ea38d637938d8::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

