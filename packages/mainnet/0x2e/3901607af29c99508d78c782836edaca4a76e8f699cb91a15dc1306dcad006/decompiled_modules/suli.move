module 0x2e3901607af29c99508d78c782836edaca4a76e8f699cb91a15dc1306dcad006::suli {
    struct SULI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULI>(arg0, 9, b"SULI", b"sullivan", b"KIND MONSTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84c3f2d7-9c43-4965-afa4-37eac40192b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SULI>>(v1);
    }

    // decompiled from Move bytecode v6
}

