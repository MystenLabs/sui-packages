module 0x6c4b463b51d7d2ddf888e5bf24ceec8b79b887e313aa0120256fe3b41942d277::mtdia {
    struct MTDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MTDIA>(arg0, 6, b"MTDIA", b"MASTER DOGE IA by SuiAI", b"Machine learning algorithms can identify complex patterns in historical price and trading volume data. Based on these patterns,MASTER DOGE IA can make predictions about future market trends, helping investors when buying and selling their cryptocurrencies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000394571_89b2cb99ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MTDIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTDIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

