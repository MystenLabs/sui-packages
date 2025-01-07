module 0x3a03eea1df1a90947e7c677da57967442dede647a1459b88af170a2044bd0a4d::bubai {
    struct BUBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBAI>(arg0, 6, b"BUBAI", b"Bubble Ai", b"BubbleAI is a professional off-chain data analysis platform with the fastest news media capture speed and top artificial intelligence sentiment analysis tools in the industry, which can help traders make the fastest trading decisions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049423_1b5a09547e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

