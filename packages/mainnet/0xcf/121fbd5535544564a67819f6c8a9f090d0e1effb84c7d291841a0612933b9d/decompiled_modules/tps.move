module 0xcf121fbd5535544564a67819f6c8a9f090d0e1effb84c7d291841a0612933b9d::tps {
    struct TPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPS>(arg0, 6, b"TPS", b"TAPIRSUI", b"\"Hello meme lovers! Uncle Tapir, a die-hard meme fan, is happy to meet you at Suinetwork. Let's create the most unique and funny memes together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_8b90ab5969.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

