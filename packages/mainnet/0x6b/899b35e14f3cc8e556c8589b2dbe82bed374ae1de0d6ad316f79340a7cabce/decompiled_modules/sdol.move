module 0x6b899b35e14f3cc8e556c8589b2dbe82bed374ae1de0d6ad316f79340a7cabce::sdol {
    struct SDOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOL>(arg0, 6, b"SDOL", b"Sui Dolphin", b"About About Tokenomics Buy Now Newsletter MOVEPUMP BIRDEYE suivision MOVEPUMP EXCHANGE MOVEPUMP The story of SDOL began with a group of young developers passionate about blockchain technology and memes. They wanted to create a coin that was both entertaining and had great growth potential. And so SDOL was born, with the mission of bringing joy and connecting the crypto community. JOIN TELEGRAM In a colorful blockchain universe, a small but extremely adorable shark with red lips and round eyes appeared. That is SDOL, the brand new meme coin on the Sui blockchain. With its unique appearance and humorous personality, SDOL quickly became a social media phenomenon, attracting the attention of millions of users", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_20_45_40_a14505e832.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

