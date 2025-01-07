module 0x1a98c181ce323d1571be1f805b3d5d19e98c1f79492aa32f592e7fd4575fd9e2::msend {
    struct MSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSEND>(arg0, 6, b"MSEND", b"MSEND", b"MSEND", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

