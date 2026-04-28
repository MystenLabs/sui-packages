module 0xe61d35e76ede84c0b0f91ca4176bd3d6012917eb861735b520e2ea47adbfb722::dntbuy {
    struct DNTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DNTBUY>(arg0, 9, b"DNTBUY", b"KOALA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<DNTBUY>>(0x2::coin::mint<DNTBUY>(&mut v3, 10000000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNTBUY>>(v3, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNTBUY>>(v2);
    }

    // decompiled from Move bytecode v6
}

