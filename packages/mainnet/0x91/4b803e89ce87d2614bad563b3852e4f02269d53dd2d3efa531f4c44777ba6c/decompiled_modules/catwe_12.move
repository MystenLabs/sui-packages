module 0x914b803e89ce87d2614bad563b3852e4f02269d53dd2d3efa531f4c44777ba6c::catwe_12 {
    struct CATWE_12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWE_12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWE_12>(arg0, 9, b"CATWE_12", b"Catwe", b"For task", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1bae082-e1a4-442e-8cfb-0b26335704c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWE_12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWE_12>>(v1);
    }

    // decompiled from Move bytecode v6
}

