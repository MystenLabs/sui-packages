module 0xbf9965f50d7255f6d4d76c37ad53a7af8c75894e1b979c9596bbca971e9a562a::pota {
    struct POTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTA>(arg0, 6, b"POTA", b"Sui Pota", b"Presenting the most hated potato head to you, Pota. Unlike all of those other lovely memes, like Pepe and Shiba, this guy is a fucking villain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_09_T140123_305_8c0f46bb48.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

