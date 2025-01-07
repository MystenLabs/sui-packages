module 0xcb8e92d6283229511b298fb21df80190d6f6b776efaa248b9cc559524c4d7eef::sagsagas {
    struct SAGSAGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGSAGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGSAGAS>(arg0, 6, b"SAGSAGAS", b"asgasg", b"asgsagsag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/bublsui/photo")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<SAGSAGAS>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<SAGSAGAS>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

