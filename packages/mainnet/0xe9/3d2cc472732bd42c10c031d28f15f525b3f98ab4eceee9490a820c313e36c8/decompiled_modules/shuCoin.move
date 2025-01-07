module 0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin {
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

