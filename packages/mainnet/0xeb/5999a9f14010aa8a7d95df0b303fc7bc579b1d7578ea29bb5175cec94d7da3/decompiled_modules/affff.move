module 0xeb5999a9f14010aa8a7d95df0b303fc7bc579b1d7578ea29bb5175cec94d7da3::affff {
    struct AFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFFFF>(arg0, 6, b"AFFFF", b"adf", b"f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFFFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFFFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

