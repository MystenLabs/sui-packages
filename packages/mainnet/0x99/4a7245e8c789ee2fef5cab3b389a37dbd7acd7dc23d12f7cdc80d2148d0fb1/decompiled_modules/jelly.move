module 0x994a7245e8c789ee2fef5cab3b389a37dbd7acd7dc23d12f7cdc80d2148d0fb1::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLY>(arg0, 6, b"JELLY", b"JELLYJELLY AI", b"JellyJelly AI is an autonomous research agent designed to analyze and track JellyJelly, its founders and its team by collecting real-time data from X (Twitter) and online sources. It integrates sentiment analysis, memory functionality, and emotional intelligence to continuously refine its insights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250130_142736_595_15026112b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

