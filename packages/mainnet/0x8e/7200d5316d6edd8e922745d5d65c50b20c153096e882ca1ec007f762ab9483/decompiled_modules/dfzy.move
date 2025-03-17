module 0x8e7200d5316d6edd8e922745d5d65c50b20c153096e882ca1ec007f762ab9483::dfzy {
    struct DFZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFZY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DFZY>(arg0, 6, b"DFZY", b"DogeFrenzy by SuiAI", b"DogeFrenzy is the ultimate meme coin that takes the popular Dogecoin concept to a whole new level. With a playful and energetic community of Doge lovers, DogeFrenzy aims to create a viral sensation in the crypto world. Join the Frenzy today and let's take meme coins to the moon! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/Z108XA.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DFZY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFZY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

