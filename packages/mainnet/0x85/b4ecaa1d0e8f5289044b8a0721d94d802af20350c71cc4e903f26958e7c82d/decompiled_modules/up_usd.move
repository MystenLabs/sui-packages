module 0x85b4ecaa1d0e8f5289044b8a0721d94d802af20350c71cc4e903f26958e7c82d::up_usd {
    struct UP_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP_USD>(arg0, 9, b"upUSD", b"DoubleUp USD", b"Stable-value Chip in DoubleUp (www.doubleup.fun)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.doubleup.fun/Diamond_Only.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP_USD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UP_USD>>(v1);
    }

    // decompiled from Move bytecode v6
}

