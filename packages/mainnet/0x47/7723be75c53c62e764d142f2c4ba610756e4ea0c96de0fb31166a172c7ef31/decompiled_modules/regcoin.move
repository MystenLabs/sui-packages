module 0x477723be75c53c62e764d142f2c4ba610756e4ea0c96de0fb31166a172c7ef31::regcoin {
    struct REGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<REGCOIN>(arg0, 6, b"REGCOIN", b"REGCOIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<REGCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

