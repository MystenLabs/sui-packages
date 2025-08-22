module 0x488413e44b4b7c62ce10421f525849066ea64a9959ff36ddd6af81d12213457d::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

