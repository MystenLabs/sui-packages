module 0x9f7e7adf17d45e5583c4db18dff7ce0ce16b27421b0b86545b9b734e740eeec0::b_pawtato_coin_water {
    struct B_PAWTATO_COIN_WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_WATER>(arg0, 9, b"bWATER", b"bToken WATER", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

