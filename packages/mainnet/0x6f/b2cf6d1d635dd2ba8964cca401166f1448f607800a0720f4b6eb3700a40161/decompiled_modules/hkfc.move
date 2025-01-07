module 0x6fb2cf6d1d635dd2ba8964cca401166f1448f607800a0720f4b6eb3700a40161::hkfc {
    struct HKFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKFC>(arg0, 6, b"HKFC", b"HIPPO KFC", b"https://x.com/KFC_ES/status/1843276577330876530", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_6ab2c52c24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HKFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

