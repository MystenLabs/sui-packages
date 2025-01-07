module 0xc5c9efe6ca4219ff66ee75f6249c883f47ea24184b0345487f849357d9da149e::boom_x {
    struct BOOM_X has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM_X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM_X>(arg0, 9, b"BOOM_X", b"Boom X ", b"Way To Change ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01ec202a-c78e-4593-80a4-1892329e1ea4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM_X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM_X>>(v1);
    }

    // decompiled from Move bytecode v6
}

