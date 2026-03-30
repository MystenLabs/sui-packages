module 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::framework {
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

