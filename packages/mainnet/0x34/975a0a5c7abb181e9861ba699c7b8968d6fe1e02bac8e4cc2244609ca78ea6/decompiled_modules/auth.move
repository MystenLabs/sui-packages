module 0x34975a0a5c7abb181e9861ba699c7b8968d6fe1e02bac8e4cc2244609ca78ea6::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

