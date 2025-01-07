module 0xffda5863bf0dd833e4f7684f71f5eb3d42ca913ed9584b42ba4362c12dd9b50f::trace {
    struct TRACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRACE>(arg0, 6, b"TRACE", b"Trace Ai", b"Revolutionize your trading with Trace Ai! Our platform offers cutting-edge features like real-time transaction analysis, alpha trader identification, advanced wallet analytics, and copy trading. Trace Ai's bot is revolutionizing the trading game by providing real-time analysis and comprehensive insights, empowering traders to make informed decisions and maximize their profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044533_f43cc4ed73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

