module 0xac7c12b59d7293c048907c0aa81733c1d9b07b1744f3846779123b26716af8c0::zar {
    struct ZAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAR>(arg0, 9, b"ZAR", b"ZAAR", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/344f398c-6a22-4528-a751-8d6b92dfc913.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

