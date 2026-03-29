module 0x9610dddf65ac1dbab99351c1b93d1c8984bc6c79d75e3908f7e4ed2eec9e19c1::framework {
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

