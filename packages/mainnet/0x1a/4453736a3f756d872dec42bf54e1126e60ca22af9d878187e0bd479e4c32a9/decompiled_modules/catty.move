module 0x1a4453736a3f756d872dec42bf54e1126e60ca22af9d878187e0bd479e4c32a9::catty {
    struct CATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CATTY>(arg0, 6, b"CATTY", b"Catty Coin", b"Catty Coin", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CATTY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATTY>>(v2);
    }

    public fun mint_coin(arg0: u64, arg1: &mut 0x2::coin::TreasuryCap<CATTY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CATTY>>(0x2::coin::mint<CATTY>(arg1, arg0, arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CATTY>>(0x2::coin::mint<CATTY>(arg1, arg0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

