module 0x81a4209ce897ae29751e830b05b70e66ccbb52d2bc224481a2ac2ee1febe01a4::ascb {
    struct ASCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASCB>(arg0, 9, b"ASCB", b"sacabamfunARMY", b"sacabamfun", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASCB>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASCB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

