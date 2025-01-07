module 0x72eaae820e5f010d6f7de3b223bbc0742b56a23c3b4eeb89e203fac2885dd066::asdasdasd {
    struct ASDASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASDASD>(arg0, 6, b"ASDASDASD", b"asdasdasd", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bestoftelegram.com/static/animated-stickers/img/Khinkali/Khinkali3.jpg")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<ASDASDASD>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<ASDASDASD>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

