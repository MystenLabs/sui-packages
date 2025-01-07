module 0x7f26c9cdb12383f29de9271be5d71858dcf5aa25c7c62281d739653cac23e091::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 6, b"SPepe", b"SeiPepe", b"SuiPepe is the ultimate meme coin on the Sui blockchain, blending the fun and humor of internet culture with the power of decentralized finance. Join the Pepe revolution and be part of a community-driven project thats taking memes to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000349_9ffb150317.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

