module 0xbab0cc4d4f89de01be2a2445b63edc4f17eabf39ded9760d8e42a7238b82e62c::ikappy1111 {
    struct IKAPPY1111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKAPPY1111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKAPPY1111>(arg0, 9, b"IKAPPY1111", b"ikappy", b"The divine squid that exists in the land of snow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0c46e10-a157-46d5-bfdd-ff636414b934.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKAPPY1111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKAPPY1111>>(v1);
    }

    // decompiled from Move bytecode v6
}

