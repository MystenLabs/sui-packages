module 0x79ecd947a84277c07b7fde291a6f288cbf7877f30982e6541cd9900a16cfb7fd::gaga {
    struct GAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAGA>(arg0, 9, b"GAGA", b"GAGA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAGA>>(v1);
        0x2::coin::mint_and_transfer<GAGA>(&mut v2, 1500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GAGA>>(v2);
    }

    // decompiled from Move bytecode v6
}

