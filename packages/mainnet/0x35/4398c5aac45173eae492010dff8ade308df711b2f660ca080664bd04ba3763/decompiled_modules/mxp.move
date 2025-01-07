module 0x354398c5aac45173eae492010dff8ade308df711b2f660ca080664bd04ba3763::mxp {
    struct MXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXP>(arg0, 9, b"MXP", b"MAxPro", b"Maximum Professional", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03ec5f5a-267b-4517-a36d-7e93f4b363c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

