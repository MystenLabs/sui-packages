module 0x5c0db153f2ae6d7f22dc73fe3184b9f4014cb2cce92f36ef67c5ce3a1d3c81cd::LiGuoV_coin {
    struct LIGUOV_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGUOV_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGUOV_COIN>(arg0, 2, b"LiGuoVCoin", b"liguowei coin", x"e78ea9e78ea9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/sanrio/images/1/10/Hello-kitty.png/revision/latest/scale-to-width-down/280?cb=20171105235741")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIGUOV_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGUOV_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

