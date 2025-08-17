module 0xfdd6a0100ac79fa72f15cdafc6cc7adb0ac06e1f9ee4a0d02dec828411ca282c::coin_y {
    struct COIN_Y has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_Y, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_Y>(arg0, 9, b"CoinY", b"CoinY", b"Test coin Y", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_Y>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COIN_Y>>(v1);
    }

    // decompiled from Move bytecode v6
}

