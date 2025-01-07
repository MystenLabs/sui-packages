module 0x7a1456c25dc3b0491c1e345de6535d59e2d9830f142659bef6a7691876a1a9f6::cheeks {
    struct CHEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEKS>(arg0, 6, b"Cheeks", b"Iron Cheeks", b"Theeths luthus cheekths are all yourths", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731810765641.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEEKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

