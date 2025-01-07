module 0x6fc292825b93c2c57309f502fbab894353156c99cd8b0165da7ef8f4b64803b7::hiby {
    struct HIBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIBY>(arg0, 9, b"HIBY", b"HIBY", b"HIBY", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIBY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIBY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

