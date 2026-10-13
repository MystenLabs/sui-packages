module 0xe6cbdb99f64c5f8e55150f5ebc90754a95a05683107c7d05b4154227386972db::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

