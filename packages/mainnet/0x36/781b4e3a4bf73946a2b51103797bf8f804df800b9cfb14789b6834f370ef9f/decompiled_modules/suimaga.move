module 0x36781b4e3a4bf73946a2b51103797bf8f804df800b9cfb14789b6834f370ef9f::suimaga {
    struct SUIMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIMAGA>(arg0, 6, b"SUIMAGA", b"SuiMAGA by SuiAI", b"SuiMAGA is the ultimate AI meme generator, now live on the SuiAI platform. Create hilarious, creative, and engaging memes effortlessly by leveraging cutting-edge AI technology. Whether you're looking to share a laugh or spark a conversation, SuiMAGA makes meme creation fun, fast, and easy. Try it now and let your imagination run wild!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6885_86c3f9e784.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMAGA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAGA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

