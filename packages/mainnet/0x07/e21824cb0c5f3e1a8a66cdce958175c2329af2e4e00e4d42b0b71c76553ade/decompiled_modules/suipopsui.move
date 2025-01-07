module 0x7e21824cb0c5f3e1a8a66cdce958175c2329af2e4e00e4d42b0b71c76553ade::suipopsui {
    struct SUIPOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOPSUI>(arg0, 6, b"SUIPOPSUI", b"suipopsui", b"suipopsui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPOPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPOPSUI>>(0x2::coin::mint<SUIPOPSUI>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOPSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

