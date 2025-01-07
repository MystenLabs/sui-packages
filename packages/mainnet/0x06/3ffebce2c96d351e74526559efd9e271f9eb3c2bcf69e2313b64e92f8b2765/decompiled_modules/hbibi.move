module 0x63ffebce2c96d351e74526559efd9e271f9eb3c2bcf69e2313b64e92f8b2765::hbibi {
    struct HBIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBIBI>(arg0, 6, b"HBIBI", b"Habibi", b"Habibi Coin is a community-driven meme coin on the Solana blockchain, inspired by the popular internet meme \"Habibi.\" It's a decentralized, open-source cryptocurrency with a focus on entertainment, community engagement, and charitable giving.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5408_2903e004d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

