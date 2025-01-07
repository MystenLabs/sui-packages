module 0xc8bca10bd162c4f82f4582fcf8f33ef30a08a057737b62ca34fcc8bb7d1b6aa4::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KIKI>(arg0, 6, b"KIKI", b"KIKICat by SuiAI", b"The $KIKI project is a unique blend of meme culture, artificial intelligence, and digital IP, built on the Solana blockchain...It transforms KIKI, a globally recognized Giphy IP with over 11 billion views, into a next-generation Al-driven meme coin...The purpose of the project is to establish $KIKI as a symbol of resilience, creativity, and innovation in the Web3 space...$KIKI serves as the first Al-powered digital IP capable of autonomously evolving its narrative and generating content through generative Al. It is designed to drive engagement and community participation through its Al Agent, which empowers users to create and interact with memes, stories, and digital assets in a novel way...Backed by the world's largest meme community ($SHIB ecosystem) and prominent Web3 backers, $KIKI combines strong community-driven narratives, cutting-edge Al technology, and the global appeal of meme culture to redefine the future of the meme economy. The project also features permanently locked liquidity and an immutable smart contract for enhanced stability and security, ensuring long-term sustainability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/6c010229_6760_4391_985d_0c41002d9d3f_d6493b4fc3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KIKI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

