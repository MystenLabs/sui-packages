module 0x143984f88d7712e02be3c3227058a17cb4b5ce354b1e011b4196b362ca14d1f3::prochart {
    struct PROCHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROCHART, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PROCHART>(arg0, 6, b"PROCHART", b"ProChartAI by SuiAI", b"The future of trading. Predictive chart analysis with our tried and tested chart scout.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2129_f9f50fdded.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PROCHART>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROCHART>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

