module 0xe3c7827b2919c9b85b936e0e824b9b68cc4c1da33e88bc74e06521cc02699ffb::magic {
    struct MAGIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGIC>(arg0, 6, b"MAGIC", b"Magic: The Gathering on SUI", b"Welcome to the OG community token for the world of Magic: The Gathering trading cards.  Where MTG fandom meets crypto innovation. Whether you're a Blue mage brewing strategies or a Red mage chasing pumps, your decks now part of our multiverse.!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_c5df9297f0254ae3a2cb50da3126b7c6_raw_45b9decfb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

