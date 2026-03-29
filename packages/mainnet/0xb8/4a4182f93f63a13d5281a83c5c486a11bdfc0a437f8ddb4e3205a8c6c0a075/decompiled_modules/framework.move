module 0xb84a4182f93f63a13d5281a83c5c486a11bdfc0a437f8ddb4e3205a8c6c0a075::framework {
    struct AccountRequest has drop {
        dummy: bool,
    }

    public fun account_address(arg0: &0x2::object::UID) : address {
        @0x0
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : AccountRequest {
        AccountRequest{dummy: false}
    }

    // decompiled from Move bytecode v6
}

