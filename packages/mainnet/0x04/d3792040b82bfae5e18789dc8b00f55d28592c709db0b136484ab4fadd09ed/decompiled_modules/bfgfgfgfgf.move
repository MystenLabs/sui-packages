module 0x4d3792040b82bfae5e18789dc8b00f55d28592c709db0b136484ab4fadd09ed::bfgfgfgfgf {
    struct BFGFGFGFGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFGFGFGFGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFGFGFGFGF>(arg0, 9, b"BFGFGFGFGF", b"dfdfdfd", b"jldhtchjfbvhjg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09bbec52-3729-450d-89fa-06cf4070a9ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFGFGFGFGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFGFGFGFGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

