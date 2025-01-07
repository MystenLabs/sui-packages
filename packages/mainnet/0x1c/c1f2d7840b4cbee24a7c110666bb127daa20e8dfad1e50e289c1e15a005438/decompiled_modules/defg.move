module 0x1cc1f2d7840b4cbee24a7c110666bb127daa20e8dfad1e50e289c1e15a005438::defg {
    struct DEFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<DEFG>(arg0, 6, b"ADEFG", b"ADEFG XX Something Yield", b"ADEFG XX Something Yield", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEFG>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<DEFG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

