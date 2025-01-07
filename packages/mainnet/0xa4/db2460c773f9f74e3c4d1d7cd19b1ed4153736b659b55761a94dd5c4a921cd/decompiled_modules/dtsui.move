module 0xa4db2460c773f9f74e3c4d1d7cd19b1ed4153736b659b55761a94dd5c4a921cd::dtsui {
    struct DTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTSUI>(arg0, 9, b"DTSUI", b"DESENS TOCEN", b"DESENS TOCEN ON SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DTSUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

