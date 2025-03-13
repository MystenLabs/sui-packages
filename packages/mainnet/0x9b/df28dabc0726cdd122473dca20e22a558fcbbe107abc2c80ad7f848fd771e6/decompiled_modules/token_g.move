module 0x9bdf28dabc0726cdd122473dca20e22a558fcbbe107abc2c80ad7f848fd771e6::token_g {
    struct TOKEN_G has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_G>(arg0, 9, b"TKNG", b"TOKEN_G", b"Test token G", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/8183/standard/200X200.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_G>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_G>>(v1);
    }

    // decompiled from Move bytecode v6
}

