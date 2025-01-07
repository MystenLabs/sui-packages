module 0x946805ea3acb1340d685169940c0966f126920722966c09eb16d227e7ac52664::zar {
    struct ZAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAR>(arg0, 9, b"ZAR", b"ZAAR", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53781b26-c5d0-48df-ad63-45681be0d3b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

