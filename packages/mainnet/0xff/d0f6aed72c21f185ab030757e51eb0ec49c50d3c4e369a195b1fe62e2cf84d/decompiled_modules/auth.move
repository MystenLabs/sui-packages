module 0xffd0f6aed72c21f185ab030757e51eb0ec49c50d3c4e369a195b1fe62e2cf84d::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

