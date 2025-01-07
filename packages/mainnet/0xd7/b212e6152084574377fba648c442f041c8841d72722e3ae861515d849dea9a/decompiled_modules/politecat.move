module 0xd7b212e6152084574377fba648c442f041c8841d72722e3ae861515d849dea9a::politecat {
    struct POLITECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLITECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLITECAT>(arg0, 6, b"PoliteCat", b"Smile", b"Cat meme is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGQ43S2XNAHPDZZH1CVCGJE/01JBGXYMV8W959ANX2BC00XKVJ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLITECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLITECAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

