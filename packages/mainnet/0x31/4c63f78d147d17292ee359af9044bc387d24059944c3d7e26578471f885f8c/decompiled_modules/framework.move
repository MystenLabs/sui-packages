module 0x314c63f78d147d17292ee359af9044bc387d24059944c3d7e26578471f885f8c::framework {
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

