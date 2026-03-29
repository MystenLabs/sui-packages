module 0xfcd556e94160069ee5b9a74a0ae74f69ca4a44ba7aefc453508b644f712885ed::account {
    struct Request has store, key {
        id: 0x2::object::UID,
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : Request {
        abort 0
    }

    // decompiled from Move bytecode v6
}

