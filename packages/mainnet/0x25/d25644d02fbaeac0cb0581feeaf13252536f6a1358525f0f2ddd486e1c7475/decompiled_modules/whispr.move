module 0x25d25644d02fbaeac0cb0581feeaf13252536f6a1358525f0f2ddd486e1c7475::whispr {
    struct WHISPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHISPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHISPR>(arg0, 6, b"WHISPR", b"Whispr", b"Whispr Tech is an AI-powered crypto trading platform that provides real-time market insights, advanced trading signals, and community-driven strategies. Designed for both new and experienced traders, Whispr offers seamless integration with Telegram, customizable dashboards, and tools like the Smart Money Concept and LTF Trading System to track institutional activity and predict market movements. Our mission is to make crypto trading accessible and intelligent for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whispr_264a186add.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHISPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHISPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

