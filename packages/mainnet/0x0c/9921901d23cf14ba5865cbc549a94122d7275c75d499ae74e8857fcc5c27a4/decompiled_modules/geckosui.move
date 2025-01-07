module 0xc9921901d23cf14ba5865cbc549a94122d7275c75d499ae74e8857fcc5c27a4::geckosui {
    struct GECKOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKOSUI>(arg0, 6, b"GECKOSUI", b"GECKO", b"Explore the key stages of our Geckos NFT journey, from initial minting to exclusive events and exciting giveaways.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_033800982_5c10b62b0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECKOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

