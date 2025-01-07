module 0x601c4afc2c276d68a8c51582d8d3140b208fb0da34d61fc61dc10b84bb8b84f0::share_coin {
    struct SHARE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARE_COIN>(arg0, 6, b"somewhere1 Faucet ", b"Fauet coin", b"this is faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARE_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SHARE_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

