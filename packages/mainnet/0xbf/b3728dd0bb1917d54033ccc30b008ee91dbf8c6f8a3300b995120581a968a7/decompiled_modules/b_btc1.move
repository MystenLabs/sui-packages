module 0xbfb3728dd0bb1917d54033ccc30b008ee91dbf8c6f8a3300b995120581a968a7::b_btc1 {
    struct B_BTC1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BTC1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BTC1>(arg0, 9, b"bBTC1", b"bToken BTC1", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BTC1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BTC1>>(v1);
    }

    // decompiled from Move bytecode v6
}

