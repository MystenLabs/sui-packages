module 0xdd083a7e120d105a6d8ad0e4d0bc7affbe6c16dca517cad0274a1d6f75ec2d06::tuno {
    struct TUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNO>(arg0, 6, b"TUNO", b"tuno", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TUNO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

