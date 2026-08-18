module 0x463cb6e2edb912464375500af918d5a3c313395d294935304f016d28c32d10fd::ffff {
    struct FFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFF>(arg0, 6, b"FFFF", b"f", b"asdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

