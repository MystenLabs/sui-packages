module 0x71519fbf0bf99a4257f163566b9ca757a5515d173f1be887014d538842581af7::account {
    struct Request has store, key {
        id: 0x2::object::UID,
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : Request {
        abort 0
    }

    // decompiled from Move bytecode v6
}

