module 0x829335c3efcfccf10beaf2f52f596b9224212b6adb18108b75aa8cd94f0d5b9f::shuCoin {
    struct SHUCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUCOIN>(arg0, 8, b"SHUCOIN", b"SHUCOIN", b"this is shuCoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SHUCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

