module 0x4d4492d7801a2e5dbe7d97a7a8e3470457d3bce209897c0c5cecdb39925ca570::xiaoshenyuan_coin {
    struct XIAOSHENYUAN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XIAOSHENYUAN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XIAOSHENYUAN_COIN>>(0x2::coin::mint<XIAOSHENYUAN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XIAOSHENYUAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<XIAOSHENYUAN_COIN>(arg0, 8, b"XIAOSHENYUAN", b"XIAOSHENYUAN Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAOSHENYUAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<XIAOSHENYUAN_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIAOSHENYUAN_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

