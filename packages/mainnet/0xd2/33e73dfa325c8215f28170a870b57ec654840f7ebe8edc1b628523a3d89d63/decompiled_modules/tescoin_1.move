module 0xd233e73dfa325c8215f28170a870b57ec654840f7ebe8edc1b628523a3d89d63::tescoin_1 {
    struct TESCOIN_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESCOIN_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESCOIN_1>(arg0, 6, b"TESCOIN1", b"tescoin1", b"tescoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://test.com")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<TESCOIN_1>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<TESCOIN_1>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

