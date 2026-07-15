module 0xd1a03e7c259a5fbc46cdd9825f88f5f219fa1ccdd2bbd6120c5e41cf5638b8eb::lz_test_coin {
    struct LZ_TEST_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LZ_TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LZ_TEST_COIN>(arg0, 8, b"LZTestCoin", b"LZTestCoin", b"Sui LayerZero OFT representation of LZTestCoin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LZ_TEST_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LZ_TEST_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

