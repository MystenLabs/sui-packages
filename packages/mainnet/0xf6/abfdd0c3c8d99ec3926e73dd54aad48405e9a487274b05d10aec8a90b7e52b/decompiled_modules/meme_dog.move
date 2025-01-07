module 0xf6abfdd0c3c8d99ec3926e73dd54aad48405e9a487274b05d10aec8a90b7e52b::meme_dog {
    struct MEME_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_DOG>(arg0, 9, b"MEME_DOG", b"SuiDoge", b"Dog meme coin on the SUI network is a cryptocurrency that combines the popularity of dog memes with blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7073c46b-df8b-4dc0-b8b8-242253e264a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

