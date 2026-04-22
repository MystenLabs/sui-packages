module 0x72469f9541dea1dea3168ab7fbddd7c28f9d25c74d1697bdda49371fa01a2fac::fuckwife {
    struct FUCKWIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKWIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKWIFE>(arg0, 6, b"FUCKWIFE", b"FUCKWIFE", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKWIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKWIFE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

