module 0x2c82f9ddb1d95af8262903c47d41591a371406e5980519482319bd6fd1fcdc8::ccd {
    struct CCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCD>(arg0, 6, b"CCD", b"Coca'Codog", x"436f636120436f646f673a205468652062657665726167652074686174206261726b73206261636b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1628_65a18a2cac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

