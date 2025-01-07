module 0x73779404e981a116f05b08cf94513a976383d9195d111d215c757b487779f811::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct MYCOINStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<MYCOIN>,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 6, b"TESTCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

