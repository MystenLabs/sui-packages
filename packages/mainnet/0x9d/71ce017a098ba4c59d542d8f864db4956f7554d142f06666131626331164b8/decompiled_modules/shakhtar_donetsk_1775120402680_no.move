module 0x9d71ce017a098ba4c59d542d8f864db4956f7554d142f06666131626331164b8::shakhtar_donetsk_1775120402680_no {
    struct SHAKHTAR_DONETSK_1775120402680_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAKHTAR_DONETSK_1775120402680_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAKHTAR_DONETSK_1775120402680_NO>(arg0, 0, b"SHAKHTAR_DONETSK_1775120402680_NO", b"SHAKHTAR_DONETSK_1775120402680 NO", b"SHAKHTAR_DONETSK_1775120402680 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAKHTAR_DONETSK_1775120402680_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAKHTAR_DONETSK_1775120402680_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

