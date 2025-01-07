module 0xb17b64fb5c36a0b2229bfcda4ca9374892bd93f2fa1a652b1b6eaf184484a601::ghx {
    struct GHX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHX>(arg0, 9, b"GHX", b"GamerCoin", b"gamefi coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8133c50b-d1b9-436c-8910-40e9366d807c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHX>>(v1);
    }

    // decompiled from Move bytecode v6
}

