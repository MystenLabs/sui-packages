module 0x54451c5e6c91be572a3366819f9ed94d4063f253b0a0774d22ba7baddc53c437::tsla {
    struct TSLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSLA>(arg0, 6, b"TSLA", b"TSLA on SUI", b"Welcome to TSLA on SUI. The new meme narrative revolving around traditional assets, led by SPX, currently standing at a $630 Million Market Cap, has begun! Prepare for this Elon backed gem of the cycle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Coin_810232dfbc.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

