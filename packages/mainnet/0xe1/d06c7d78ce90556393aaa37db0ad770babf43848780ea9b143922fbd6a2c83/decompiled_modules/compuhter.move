module 0xe1d06c7d78ce90556393aaa37db0ad770babf43848780ea9b143922fbd6a2c83::compuhter {
    struct COMPUHTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMPUHTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMPUHTER>(arg0, 9, b"COMPUHTER", b"WaweComp", b"Das good compuhter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64a831ad-84ee-4c01-ad38-e7f4f3674ede.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMPUHTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMPUHTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

