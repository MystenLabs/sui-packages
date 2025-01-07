module 0x597f2cbd4fadf93690ce5f5ec8201aae492018b95b2b0a453c85bcf5a1925cae::bfgfgfgfgf {
    struct BFGFGFGFGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFGFGFGFGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFGFGFGFGF>(arg0, 9, b"BFGFGFGFGF", b"dfdfdfd", b"jldhtchjfbvhjg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d885b423-24a7-4f3e-9fc0-3b3d04a30c00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFGFGFGFGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFGFGFGFGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

