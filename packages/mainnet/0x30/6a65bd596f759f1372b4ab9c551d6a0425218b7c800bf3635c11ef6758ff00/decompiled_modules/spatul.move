module 0x306a65bd596f759f1372b4ab9c551d6a0425218b7c800bf3635c11ef6758ff00::spatul {
    struct SPATUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPATUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPATUL>(arg0, 6, b"SPATUL", b"SPATULE", b"SPATULE HAROW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731524428390.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPATUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPATUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

