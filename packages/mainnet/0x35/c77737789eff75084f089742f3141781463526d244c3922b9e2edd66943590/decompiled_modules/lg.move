module 0x35c77737789eff75084f089742f3141781463526d244c3922b9e2edd66943590::lg {
    struct LG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LG>(arg0, 9, b"LG", b"Legacy coi", b"Coin for aiding of charity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84af7148-acf3-480e-8667-b7def031319c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LG>>(v1);
    }

    // decompiled from Move bytecode v6
}

