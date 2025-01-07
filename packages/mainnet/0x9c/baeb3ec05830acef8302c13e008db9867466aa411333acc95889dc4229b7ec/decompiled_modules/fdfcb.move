module 0x9cbaeb3ec05830acef8302c13e008db9867466aa411333acc95889dc4229b7ec::fdfcb {
    struct FDFCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDFCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDFCB>(arg0, 6, b"FDFCB", b"DDFGCBCFB", b"XFBXCXF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959982812.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDFCB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDFCB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

