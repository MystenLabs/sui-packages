module 0xa3439a8bce168c3aebdfc80fadf15a2f49f86fa69d982e2310101363feca408e::loreai {
    struct LOREAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOREAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOREAI>(arg0, 6, b"LOREAI", b"LORE SUI AI by SuiAI", b"The AI Narrative Built on $SUI AI.We are excited to introduce LORE AI, a revolutionary concept built on the $SUI AI blockchain. Our aim is to create a unique narrative around Artificial Intelligence, harnessing the power of $SUI AI to bring this vision to life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gemini_Generated_Image_c5bihjc5bihjc5bi_ba43728a80.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOREAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOREAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

