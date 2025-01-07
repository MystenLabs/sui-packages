module 0x40314d772fabc4d2d8e71530aa173bb98373c0411a2a285eb3174e665494777a::pws {
    struct PWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWS>(arg0, 9, b"PWS", b"Paws", b"Paws (PAWS) is a hilarious and light-hearted meme coin that celebrates the world of furry friends while bringing a playful twist to the world of cryptocurrencies. Inspired by the love for pets and the meme culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03213825-bfa9-4e66-b710-1c8980bc948c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

