module 0x4d0199262c69a89a36b285eb92b4c8c8fe1cf73eb8158e4819ac39da26337fb2::blackrock {
    struct BLACKROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKROCK>(arg0, 6, b"BLACKROCK", b"Black Rock Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLACKROCK>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACKROCK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLACKROCK>>(v2);
    }

    // decompiled from Move bytecode v6
}

