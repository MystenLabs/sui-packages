module 0x46c73cff60647dce1787e56fa4948c1df7fcb65b760892464f11835c8fb0aee2::aitrends {
    struct AITRENDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITRENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AITRENDS>(arg0, 6, b"AITRENDS", b"AI crypto trends analyst by SuiAI", b"AI crypto trends analyst..analyze the best insights from the crypto market, capturing the best buying and selling trends. and generate newsletters with this information. search the web for information about market movements, anticipating trends in the first information to users of our AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000393211_8a3b848d7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AITRENDS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITRENDS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

