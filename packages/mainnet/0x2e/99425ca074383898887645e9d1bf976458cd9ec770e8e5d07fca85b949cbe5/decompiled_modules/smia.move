module 0x2e99425ca074383898887645e9d1bf976458cd9ec770e8e5d07fca85b949cbe5::smia {
    struct SMIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMIA>(arg0, 6, b"SMIA", b"SUI MADE IN AMERICA", b"Cryptocurrency $smia is a symbol of a new financial era, as unshakable as the foundation of the Statue of Liberty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738284550265.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

