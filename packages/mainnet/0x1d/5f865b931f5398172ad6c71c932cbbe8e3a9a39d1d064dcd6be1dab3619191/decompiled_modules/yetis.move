module 0x1d5f865b931f5398172ad6c71c932cbbe8e3a9a39d1d064dcd6be1dab3619191::yetis {
    struct YETIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETIS>(arg0, 6, b"YETIS", b"Yetis", b"Yetis are here to climb Mt. Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731557415391.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YETIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

