module 0xf08057ed09cac98d90c254277c9bb37afe152221078f115804be885691742c79::aiax {
    struct AIAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIAX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIAX>(arg0, 6, b"AIAX", b"AthenaX9 by SuiAI", b"AthenaX9 is a cutting-edge market intelligence AI Agent that combines advanced AI algorithms with comprehensive blockchain analytics to provide real-time market insights. The platform integrates multi-chain analysis, social sentiment tracking, and smart money movement detection to deliver actionable intelligence for cryptocurrency market participants.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_2f2f2a6740.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIAX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIAX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

