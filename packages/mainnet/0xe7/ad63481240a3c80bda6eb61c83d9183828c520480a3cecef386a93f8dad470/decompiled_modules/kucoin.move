module 0xe7ad63481240a3c80bda6eb61c83d9183828c520480a3cecef386a93f8dad470::kucoin {
    struct KUCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUCOIN>(arg0, 9, b"KUCOIN", b"Kucoin", b"KUCOIN Coin is a Meme coin, KUCOIN released First on SUI blockchain with inspiration and main image from the KUCOIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/840fd8aa-8d46-4978-a230-e6e4d43d2195.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

