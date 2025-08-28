module 0x54112384005d7db85a8861620fa85f7bfdd0def9609e0270efb07d0b62dabbda::Green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 9, b"CANDLE", b"Green", b"green candles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzW4YlhWQAA9j-V?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

