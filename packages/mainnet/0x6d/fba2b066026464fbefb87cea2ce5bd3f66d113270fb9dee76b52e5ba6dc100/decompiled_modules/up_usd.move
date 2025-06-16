module 0x6dfba2b066026464fbefb87cea2ce5bd3f66d113270fb9dee76b52e5ba6dc100::up_usd {
    struct UP_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP_USD>(arg0, 9, b"upUSD", b"upUSD", b"DoubleUp USD (www.doubleup.fun)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.doubleup.fun/Diamond_Only.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP_USD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UP_USD>>(v1);
    }

    // decompiled from Move bytecode v6
}

