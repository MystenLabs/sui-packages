module 0x7c30288bfaff40355c4fba5d98bb52aedd61d18bfa3ce48ec9c027d1f454e445::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SOG", b"SUI's DOg", b"first dog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/9dAOHoISzXM/hqdefault.jpg?sqp=-oaymwEmCOADEOgC8quKqQMa8AEB-AHeAoAChgKKAgwIABABGHIgVygvMA8=&rs=AOn4CLAYTx5JNYAtMzMT8qoGdHGgJckZ_w")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<SOG>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<SOG>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

