module 0xcc2a8baa01a616b8301e76af596bd4997cd1867516617f41242e26c837acc0ac::ndws_sui {
    struct NDWS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDWS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDWS_SUI>(arg0, 9, b"ndwsSUI", b"NS Deep Wal Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7wiiytcj6qhel34ssbvccgbetq0oprjr.lambda-url.us-west-2.on.aws/?file=2025-04-25T02-10-14-291Z-ba6a371acb5b834c")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NDWS_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDWS_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

