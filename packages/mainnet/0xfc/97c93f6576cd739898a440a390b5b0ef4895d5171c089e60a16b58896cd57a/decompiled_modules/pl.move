module 0xfc97c93f6576cd739898a440a390b5b0ef4895d5171c089e60a16b58896cd57a::pl {
    struct PL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PL>(arg0, 9, b"PL", b"Phelan mem", b"Meme coin is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1abcef28-a0c5-4f51-8b78-d5e67d57c52d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PL>>(v1);
    }

    // decompiled from Move bytecode v6
}

