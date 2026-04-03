module 0xf123c532454d4e1186ccf85ad63052b82279af218eb6db9ea357a6ee423f5971::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"SUIX", b"Sui X Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIX>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIX>>(v2);
    }

    // decompiled from Move bytecode v6
}

