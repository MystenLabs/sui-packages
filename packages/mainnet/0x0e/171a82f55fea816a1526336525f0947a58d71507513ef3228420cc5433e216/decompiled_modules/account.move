module 0xe171a82f55fea816a1526336525f0947a58d71507513ef3228420cc5433e216::account {
    struct Request has store, key {
        id: 0x2::object::UID,
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : Request {
        abort 0
    }

    // decompiled from Move bytecode v6
}

