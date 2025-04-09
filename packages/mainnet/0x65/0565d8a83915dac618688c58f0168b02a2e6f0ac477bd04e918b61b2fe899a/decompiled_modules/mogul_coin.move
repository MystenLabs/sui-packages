module 0x650565d8a83915dac618688c58f0168b02a2e6f0ac477bd04e918b61b2fe899a::mogul_coin {
    struct MOGUL_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGUL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGUL_COIN>(arg0, 6, b"MOGUL", b"MOGUL Coin", b"MOGUL Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/5CWRcYw.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGUL_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGUL_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

