module 0x6933de2d7280c35192ebd8d59a7faabcab5c17219685110cf99edaafbe18ead2::turbo {
    struct TURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBO>(arg0, 6, b"TURBO", b"TURBO on SUI", b"TURBO is the first AI-Generated, Meme Coin, launched with a $69 budget & fully decentralized. It stands for excellence in Web3 innovation. 100% community owned.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_79_K7_Kb0_AAXA_Ws_e04da877d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

