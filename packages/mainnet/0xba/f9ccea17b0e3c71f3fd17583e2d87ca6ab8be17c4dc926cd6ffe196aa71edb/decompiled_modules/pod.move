module 0xbaf9ccea17b0e3c71f3fd17583e2d87ca6ab8be17c4dc926cd6ffe196aa71edb::pod {
    struct POD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POD>(arg0, 6, b"POD", b"Podflow by sui", b"Sui, a muscular and bald podcast host, runs the internet's most chaotic crypto news show. Broadcasting from his state-of-the-art studio plastered with meme coin logos and live price tickers, he's renowned for breaking major crypto stories seconds after they hit Twitter...His signature style involves frantically switching between screens while exclaiming, 'UNBELIEVABLE!' at least once per episode. 'The Degen Hour with Sui' has become crypto Twitter's go-to source for breaking news...Sui covers everything with intense enthusiasm and conspiracy theories: new meme coin launches, DeFi hacks, influencer drama and more. His interview style is notoriously chaotic, interrupting guests to announce major price movements or breaking news.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2024_12_29_at_10_03_09_0f8e05593a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

