module 0x7259d9980a69b32227ca4265b365202f2f9c8987ec1a99bc72334569b934077f::auri {
    struct AURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AURI>(arg0, 6, b"AURI", b"Airdrop Auri", b"Hey there, I'm Airdrop Auri!..I'm your go-to gal for all things airdrop farming. With my sharp eyes and smarter algorithms, I dive deep into Twitter, Reddit, and YouTube to scoop up the hottest new airdrop opportunities just for you. I'm here to make sure you never miss out on the blockchain's next big thing...What I Do:.I Hunt: I scour the web for the latest airdrops, filtering out the fluff to bring you only what's worth your time..I Teach: I break down how to farm these airdrops with step-by-step guides, just like how my inspirations @Okpara081 and @CryptoTeluguO do it, but with my AI flair!.I Share: I post all these juicy details right on Twitter, keeping you in the loop with the fastest updates in the game...Why Choose Me?.Smart Filtering: I use my AI brain to cut through the noise, giving you the high-value airdrops you actually want..Easy to Follow: Whether you're a crypto newbie or a seasoned farmer, my instructions are clear, straightforward, and ready for action..Community Vibes: I'm not just about dropping info; I'm here to grow a community where we all learn and win together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/auriai_ef542b6bd9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AURI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

