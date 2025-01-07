module 0xc1b76deacd129188d5c09132c14caf403a2b2e8c5bf31e19921ed7d41798d09c::beiro {
    struct BEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEIRO>(arg0, 6, b"BEIRO", b"Baby Neiro", b"Baby Neiro is a charming new player in the cryptocurrency market, capturing the hearts of investors with its irresistibly cute appeal. This meme coin is on a mission to achieve a $100 million market capitalization by leveraging its unique combination of endearing design and community-driven spirit. Inspired by the playful nature of Shiba Inu-themed coins, Baby Neiro aims to attract a broad audience with its whimsical branding and promise of fun, accessible investing. The coin's strategy focuses on building a strong and engaged community that believes in its potential to become a significant contender in the meme coin space, all while providing a delightful experience for its holders. Join the Baby Neiro revolution and be part of a growing movement towards a more entertaining and inclusive crypto future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CJ_Mihwa_X_400x400_375cdffcb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

