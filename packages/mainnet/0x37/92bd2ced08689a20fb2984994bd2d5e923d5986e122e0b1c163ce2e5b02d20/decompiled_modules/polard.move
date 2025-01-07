module 0x3792bd2ced08689a20fb2984994bd2d5e923d5986e122e0b1c163ce2e5b02d20::polard {
    struct POLARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLARD>(arg0, 6, b"Polard", x"506f6c61722053756920f09f92a7", b"Experience the future of crypto with $POLAR Sui, the premium memecoin for the discerning investor. Coming soon on turbos.finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731257720113.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

