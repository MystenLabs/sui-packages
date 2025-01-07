module 0xf8180188f1b718f4681720fb37a8eea23ca18e2028c389a30b30750a6c04b83b::wpp {
    struct WPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPP>(arg0, 9, b"WPP", b"Ayud", b"WEWEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fcb2c5c-bd13-4927-afb8-3ab7ebe71c2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

