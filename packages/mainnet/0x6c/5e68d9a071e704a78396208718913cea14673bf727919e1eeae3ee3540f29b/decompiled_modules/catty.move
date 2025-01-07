module 0x6c5e68d9a071e704a78396208718913cea14673bf727919e1eeae3ee3540f29b::catty {
    struct CATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTY>(arg0, 6, b"Catty", b"CATTY", b"Catty is a meme coin on the Sui blockchain ecosystem, featuring an iconic cat mascot and a strong community focus. As a humor-based token, Catty leverages the appeal of memes and a loyal fan base to stand out among crypto enthusiasts. Beyond being a speculative asset, Catty aims to enhance social interaction within its ecosystem through interactive features, community events, and potential integration with games or NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241101_161401_580312d400.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

