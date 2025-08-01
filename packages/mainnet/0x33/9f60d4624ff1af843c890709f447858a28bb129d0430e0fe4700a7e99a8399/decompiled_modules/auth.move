module 0x339f60d4624ff1af843c890709f447858a28bb129d0430e0fe4700a7e99a8399::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

