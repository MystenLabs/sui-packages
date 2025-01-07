module 0xbbcc498a1f1ccf300efdfaf105cce64b8321434d114a036f806465c6f4218306::defg {
    struct DEFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<DEFG>(arg0, 6, b"DEFG", b"DEFG XX Something Yield", b"DEFG XX Something Yield", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEFG>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<DEFG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

