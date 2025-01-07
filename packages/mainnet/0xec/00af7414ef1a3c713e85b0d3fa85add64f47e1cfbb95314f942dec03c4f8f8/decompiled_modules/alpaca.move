module 0xec00af7414ef1a3c713e85b0d3fa85add64f47e1cfbb95314f942dec03c4f8f8::alpaca {
    struct ALPACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPACA>(arg0, 6, b"Alpaca", b"Cowboy Alpaca", b"In the western.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11072f11_9676_4685_aa1d_67018cb63630_af46d9a208.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

