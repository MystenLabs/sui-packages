module 0xdd3ef3bef36bffd0bff6c73b46859865e0cef53176463ab5a31720dbd6ac9864::Candle {
    struct CANDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDLE>(arg0, 9, b"GREEN", b"Candle", b"green candle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0NWf57WYAA_Sqp?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANDLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

