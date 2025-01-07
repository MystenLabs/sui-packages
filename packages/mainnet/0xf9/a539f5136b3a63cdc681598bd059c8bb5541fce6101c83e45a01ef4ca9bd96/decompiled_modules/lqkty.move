module 0xf9a539f5136b3a63cdc681598bd059c8bb5541fce6101c83e45a01ef4ca9bd96::lqkty {
    struct LQKTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LQKTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LQKTY>(arg0, 6, b"LQKTY", b"LiquidCat", b"The most fluid feline on the blockchain! Cats are just liquid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733581735233.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LQKTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LQKTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

