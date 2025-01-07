module 0x4cff93fa8794f20bdc8c3a14850e24a93d2755c673501d2d3c1040cd6b232e2a::asdasdasd {
    struct ASDASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASDASD>(arg0, 6, b"ASDASDASD", b"asdasdasd222", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-internal-do-not-share.hop.ag/")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<ASDASDASD>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<ASDASDASD>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

