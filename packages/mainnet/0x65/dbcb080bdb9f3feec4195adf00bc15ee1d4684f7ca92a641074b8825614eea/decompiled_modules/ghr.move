module 0x65dbcb080bdb9f3feec4195adf00bc15ee1d4684f7ca92a641074b8825614eea::ghr {
    struct GHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHR>(arg0, 9, b"GHR", b"ghoori", x"f09fab96f09fab96f09fab96f09fab962062757920617a206d75636820617a2067686f6f7269636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5649cf0e-cab5-4389-bf69-ec836a9068ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

