module 0x5d4aa718a0f627103bc33208c27c6c74b8025fefa1677a5883eaa614b0255f41::jexxx {
    struct JEXXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEXXX>(arg0, 6, b"JEXXX", b"Jessica Rabbit", b"PUBLICAEs groundbreaking development of the highly anticipated Metaverse Play-2-Earn mobile game featuring the iconic Jessica Rabbit animated fictional character in a mysterious esoteric and occult realm. Embark on an enthralling journey with Jessica Rabbit while receiving anonymous messages from the notorious cyber-criminal @RyoshiResearch as you level up. At the heart of our P2E game model lies the $JEXXX crypto token and NFTs, engage in thrilling adventures and quests, solve puzzles, and interact with NPCs while fighting decoy characters and otherworldly Web3 LARP entities on your way to conspiracy disclosure as you gradually uncover the hidden identity of Ryoshi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/im_ad8a5d6ce3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEXXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEXXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

