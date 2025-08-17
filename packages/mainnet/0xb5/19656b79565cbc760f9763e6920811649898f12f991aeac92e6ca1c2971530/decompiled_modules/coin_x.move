module 0xb519656b79565cbc760f9763e6920811649898f12f991aeac92e6ca1c2971530::coin_x {
    struct COIN_X has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_X>(arg0, 9, b"CoinX", b"CoinX", b"Test coin X", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COIN_X>>(v1);
    }

    // decompiled from Move bytecode v6
}

