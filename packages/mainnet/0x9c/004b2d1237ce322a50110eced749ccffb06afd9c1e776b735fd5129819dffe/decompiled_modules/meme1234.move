module 0x9c004b2d1237ce322a50110eced749ccffb06afd9c1e776b735fd5129819dffe::meme1234 {
    struct MEME1234 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME1234, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME1234>(arg0, 9, b"MEME1234", b"Meme123", b"This is meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f557b0d6-82f6-4896-9de6-fa26d09448be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME1234>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME1234>>(v1);
    }

    // decompiled from Move bytecode v6
}

