module 0xcacac0669f6b05539f4f4b6d71b15aaf7243ddd27960c4ae74a09001ca469087::yana {
    struct YANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YANA>(arg0, 6, b"YANA", b"Yana baby mammoth", b"YANA is inspired by the discovery of a baby mammoth named after the Yana River in Siberia. This ticker symbolizes the extraordinary preservation of Earth's ancient heritage and the ongoing quest to uncover the secrets of prehistoric life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735019651375.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

