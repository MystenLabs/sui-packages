module 0xb562d4d34f3fb26a6a079de8e29a6a0a47d02ea290dea3572966f1f1948aca2f::account {
    struct Request has store, key {
        id: 0x2::object::UID,
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : Request {
        abort 0
    }

    // decompiled from Move bytecode v6
}

