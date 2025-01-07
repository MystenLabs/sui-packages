module 0xb70d0430aa2c7695080a59f736f9c577b2fa0d6db7e38152bb38f22a4a667046::CHRISTMASGAINS {
    struct CHRISTMASGAINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRISTMASGAINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRISTMASGAINS>(arg0, 6, b"Christmas Gains", b"CHG", b"Everyone wants christmas gains or not? Special oportunity here :).", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHRISTMASGAINS>>(v1);
        0x2::coin::mint_and_transfer<CHRISTMASGAINS>(&mut v2, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRISTMASGAINS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

