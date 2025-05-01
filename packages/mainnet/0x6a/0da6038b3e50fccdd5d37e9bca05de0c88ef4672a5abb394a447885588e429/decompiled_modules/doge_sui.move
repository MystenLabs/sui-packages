module 0x6a0da6038b3e50fccdd5d37e9bca05de0c88ef4672a5abb394a447885588e429::doge_sui {
    struct DOGE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE_SUI>(arg0, 9, b"dogeSUI", b"Doge Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7wiiytcj6qhel34ssbvccgbetq0oprjr.lambda-url.us-west-2.on.aws/?file=2025-04-27T13-49-51-630Z-e8cef786eb451811")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

