module 0x6a848c670f11951081b6c08c3116f567dc1b9e446931c96486ec4b1a21ae2801::tiwnd {
    struct TIWND has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIWND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIWND>(arg0, 9, b"TIWND", b"bdbd", b"nfnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53427cc9-81d3-45c0-8b33-7ba8c8c2dcd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIWND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIWND>>(v1);
    }

    // decompiled from Move bytecode v6
}

