module 0xec53c35fcfe5ab6ae16d7d43ff11eca998ede175c6f7cb6e470505fdddcd945e::sagesui {
    struct SAGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGESUI>(arg0, 1, b"SAGESUI", b"SAGESUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAGESUI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

