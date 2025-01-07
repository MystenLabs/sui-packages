module 0xb3fd89af7c8fca95c22636f77de82250c66622e478b91caa0c7c4bb027d055e5::trumpempire {
    struct TRUMPEMPIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPEMPIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPEMPIRE>(arg0, 6, b"TRUMPEMPIRE", b"TRUMP EMPIRE", b"The ruler of the deep ocean, President Trump, has used his empire to gather an army", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_ec5d7fd805.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPEMPIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPEMPIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

