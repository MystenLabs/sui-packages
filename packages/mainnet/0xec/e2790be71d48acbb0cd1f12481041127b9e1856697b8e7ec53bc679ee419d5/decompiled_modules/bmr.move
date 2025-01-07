module 0xece2790be71d48acbb0cd1f12481041127b9e1856697b8e7ec53bc679ee419d5::bmr {
    struct BMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMR>(arg0, 9, b"BMR", b"bluemonste", b"bluemonster meme coin is going to rise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfd700e7-2486-49b6-ab91-fda3c4cffdc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMR>>(v1);
    }

    // decompiled from Move bytecode v6
}

