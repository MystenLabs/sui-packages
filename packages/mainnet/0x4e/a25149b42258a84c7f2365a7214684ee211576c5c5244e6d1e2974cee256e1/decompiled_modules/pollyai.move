module 0x4ea25149b42258a84c7f2365a7214684ee211576c5c5244e6d1e2974cee256e1::pollyai {
    struct POLLYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLYAI>(arg0, 6, b"POLLYAI", b"PollyAI", b"PollyAI is where cutting-edge AI meets meme magic! Built on the SUI blockchain, $POLLYAI isnt just another memecoinits your smart crypto assistant. From hilarious banter to sharp trading insights, PollyAI is here to entertain, educate, and empower the community. Hold $POLLYAI to unlock exclusive perks and join the mission to take memes and AI to the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3c5f9b5d_7d65_4f7d_b706_80867a9e258d_650b481d5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLYAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLLYAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

