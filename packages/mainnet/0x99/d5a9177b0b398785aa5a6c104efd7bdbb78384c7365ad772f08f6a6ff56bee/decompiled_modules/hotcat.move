module 0x99d5a9177b0b398785aa5a6c104efd7bdbb78384c7365ad772f08f6a6ff56bee::hotcat {
    struct HOTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTCAT>(arg0, 6, b"HOTCAT", b"HopCat", x"4669727320636174206f6e20486f7046756e0a0a57656273697465202d2068747470733a2f2f686f706361742e66756e2f0a0a54776974746572202d2068747470733a2f2f782e636f6d2f486f70436174537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://web.telegram.org/7c9594d2-9058-47e9-9a03-575516906f05")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<HOTCAT>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<HOTCAT>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

