module 0xbc0e57e634cedd1c7dcc06d44c1cfbcdbc799a1cb1fcb0f154cf7e50687ec203::bamboo_coin {
    struct BAMBOO_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMBOO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMBOO_COIN>(arg0, 9, b"BAMBOO", b"Bamboo Coin", b"Bamboo Coin new launch on cetus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775999624090-a6a8f1f74e7802d3215c998ef3421ad4.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BAMBOO_COIN>>(0x2::coin::mint<BAMBOO_COIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAMBOO_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMBOO_COIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

