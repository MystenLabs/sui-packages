module 0x159b478f8bdfb09c770fa701973fa9038173a0ea174f5392f2bd39fbe7da11a9::capi {
    struct CAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPI>(arg0, 9, b"CAPI", b"CAPI", b"CAPI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAPI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

