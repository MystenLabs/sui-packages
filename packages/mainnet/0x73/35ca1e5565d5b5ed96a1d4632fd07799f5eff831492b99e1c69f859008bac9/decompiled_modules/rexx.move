module 0x7335ca1e5565d5b5ed96a1d4632fd07799f5eff831492b99e1c69f859008bac9::rexx {
    struct REXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REXX>(arg0, 6, b"REXX", b"SuiRex", b"rexxrexxrexxrexxrexxrexxrexx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/suirex_/header_photo")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<REXX>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<REXX>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

