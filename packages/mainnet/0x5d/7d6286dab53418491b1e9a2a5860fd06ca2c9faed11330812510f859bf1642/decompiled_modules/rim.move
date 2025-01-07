module 0x5d7d6286dab53418491b1e9a2a5860fd06ca2c9faed11330812510f859bf1642::rim {
    struct RIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIM>(arg0, 9, b"RIM", b"RIMURU", b"Meme anime on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9917e94f-7cbb-4286-9b72-5befff5dde71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

