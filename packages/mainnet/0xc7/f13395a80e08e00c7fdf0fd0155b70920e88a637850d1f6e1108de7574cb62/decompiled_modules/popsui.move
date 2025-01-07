module 0xc7f13395a80e08e00c7fdf0fd0155b70920e88a637850d1f6e1108de7574cb62::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 6, b"POPSUI", b"popsui", b"popsui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<POPSUI>>(0x2::coin::mint<POPSUI>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

