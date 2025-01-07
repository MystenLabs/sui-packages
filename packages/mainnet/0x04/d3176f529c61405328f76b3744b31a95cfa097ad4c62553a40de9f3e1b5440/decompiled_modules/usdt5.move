module 0x4d3176f529c61405328f76b3744b31a95cfa097ad4c62553a40de9f3e1b5440::usdt5 {
    struct USDT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT5>(arg0, 9, b"USDT5", b"USDT 5$", b"USDT to 5$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d16a66d42f58aa59012e48d35cd6aeafblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

