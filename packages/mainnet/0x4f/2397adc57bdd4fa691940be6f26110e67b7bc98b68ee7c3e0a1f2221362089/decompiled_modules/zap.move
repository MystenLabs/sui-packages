module 0x4f2397adc57bdd4fa691940be6f26110e67b7bc98b68ee7c3e0a1f2221362089::zap {
    struct ZAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZAP>(arg0, 6, b"ZAP", b"Zap AI by SuiAI", b"Zap AI is the cutting-edge artificial intelligence designed specifically for the high-stakes world of financial markets. Known for its unparalleled speed in data processing and decision-making, Zap AI transforms milliseconds into opportunities, executing trades with precision and agility. With a core focus on real-time analysis, predictive modeling, and automated trading, Zap AI empowers traders to capitalize on market movements before they blink. Whether it's spotting arbitrage opportunities or navigating through market volatility, Zap AI is the ultimate ally for those seeking to stay ahead in the fast-paced trading arena.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_2_4c5a97fdc1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZAP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

