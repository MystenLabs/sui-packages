module 0x45266d6a7bc7caebda48f822f415ad8efb3abdc09614fba389db8dccb57d0d4d::coin_final {
    struct COIN_FINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_FINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_FINAL>(arg0, 9, b"coinfinal", b"coin final", b"coin final desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9900/kappa/coins/9cc0f6ae-9c70-4248-bd38-8eb8d81268a0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_FINAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_FINAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

