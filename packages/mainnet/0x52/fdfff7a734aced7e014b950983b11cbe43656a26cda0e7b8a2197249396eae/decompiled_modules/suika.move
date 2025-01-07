module 0x52fdfff7a734aced7e014b950983b11cbe43656a26cda0e7b8a2197249396eae::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 6, b"SUIKA", b"SUIKAMON", b"Suikamon is a meme coin inspired by the popular culture surrounding collectible creatures, similar to Pokmon. It combines elements of nostalgia and humor, appealing to both cryptocurrency enthusiasts and fans of the creature-collecting genre. Suikamon features unique digital assets that represent various fictional creatures, each with its own characteristics and rarity. The coin aims to create a vibrant community where users can trade, collect, and engage with these digital creatures while participating in the broader meme coin market. With a focus on fun and community-driven initiatives, Suikamon seeks to leverage the playful nature of meme culture to foster engagement and growth within the cryptocurrency space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Lightning_XL_Suikamon_is_a_meme_coin_inspired_by_the_1_fa007971e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

