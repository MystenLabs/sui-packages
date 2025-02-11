module 0x1701527a2f29b3c92c75eb0664e63f86d9b775b08677bdbab712f537bb8c6242::layer {
    struct LAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAYER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAYER>(arg0, 9, b"LAYER", b"LAYER4xPpTCb3QL8S9u41EAhAX7mhBn8Q6xMTwY2Yzc", x"48617264776172652d616363656c6572617465642053564d2c207363616c656420696e66696e6974656c792e20e2889e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://statics.solscan.io/cdn/imgs/s60?ref=68747470733a2f2f6d657461646174612e736f6c617965722e6f72672f6c617965722f696d6167652e706e67")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAYER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LAYER>>(0x2::coin::mint<LAYER>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAYER>>(v2);
    }

    // decompiled from Move bytecode v6
}

