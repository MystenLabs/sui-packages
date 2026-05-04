module 0x3fdaa5c6ab55cad20331db3846ffc150225351baa86aaecc512f057e2735fccf::iamout {
    struct IAMOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAMOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAMOUT>(arg0, 6, b"IAMOUT", b"I AM OUT", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IAMOUT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IAMOUT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IAMOUT>>(v2);
    }

    // decompiled from Move bytecode v6
}

