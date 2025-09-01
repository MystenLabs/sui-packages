module 0xe7b46ce0fa94a2d2a297882c7c5f8b18a976f291277d92ad8564b67ac60756b6::Candle {
    struct CANDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDLE>(arg0, 9, b"GOD", b"Candle", b"what we're all looking for. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gzvn0RUaUAA5WRz?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANDLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

