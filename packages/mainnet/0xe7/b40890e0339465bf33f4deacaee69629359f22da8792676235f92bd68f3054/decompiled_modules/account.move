module 0xe7b40890e0339465bf33f4deacaee69629359f22da8792676235f92bd68f3054::account {
    struct Request has store, key {
        id: 0x2::object::UID,
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : Request {
        abort 0
    }

    // decompiled from Move bytecode v6
}

