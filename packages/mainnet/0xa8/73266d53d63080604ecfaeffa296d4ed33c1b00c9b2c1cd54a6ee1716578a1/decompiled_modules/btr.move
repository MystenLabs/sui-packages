module 0xa873266d53d63080604ecfaeffa296d4ed33c1b00c9b2c1cd54a6ee1716578a1::btr {
    struct BTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTR>(arg0, 9, b"BTR", b"BeTeR", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dbad33f-95c5-4fff-b729-ba3f92c4963b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

