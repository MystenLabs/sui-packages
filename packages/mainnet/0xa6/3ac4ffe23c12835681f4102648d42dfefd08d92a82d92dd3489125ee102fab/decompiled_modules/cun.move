module 0xa63ac4ffe23c12835681f4102648d42dfefd08d92a82d92dd3489125ee102fab::cun {
    struct CUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUN>(arg0, 7, b"CUN", b"Suicune", b"Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CUN>(&mut v2, 10000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUN>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

