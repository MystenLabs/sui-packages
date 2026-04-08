module 0xe2aca2d33f380d653c3d6f92f716a57cc64ae536661cccddff539491ebaf9eb2::infinity_money {
    struct INFINITY_MONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINITY_MONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFINITY_MONEY>(arg0, 9, b"Infinity", b"Infinity Money", b"infinity money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775666673192-27a584f6fc9bf04ec640cfcce7cdf368.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<INFINITY_MONEY>>(0x2::coin::mint<INFINITY_MONEY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INFINITY_MONEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFINITY_MONEY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

