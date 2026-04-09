module 0x2c9c3ff3e44230ed664d2631d55d85fe1d5b16a1db3462fb00d3a13ec46f8283::boost {
    struct BOOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOST>(arg0, 6, b"BOOST", b"Boost Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOST>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOOST>>(v2);
    }

    // decompiled from Move bytecode v6
}

