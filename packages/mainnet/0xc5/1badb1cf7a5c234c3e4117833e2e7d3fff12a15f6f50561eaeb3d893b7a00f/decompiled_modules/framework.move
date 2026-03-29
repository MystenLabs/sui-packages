module 0xc51badb1cf7a5c234c3e4117833e2e7d3fff12a15f6f50561eaeb3d893b7a00f::framework {
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

