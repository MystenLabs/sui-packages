module 0xca2439190c31df87e4b45c75b056c6187a264fb8e95cd18d5ccf71352dff8fc7::candle {
    struct CANDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDLE>(arg0, 0, b"CANDLE", b"CANDLE", b"Utility token of the Stashdrop ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://stashdrop.org/assets/tokens/candle.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CANDLE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDLE>>(v2, @0xd27cc4a3a53b74e3abebb100949839d37d21264ad7616f7653019803fc43a046);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

