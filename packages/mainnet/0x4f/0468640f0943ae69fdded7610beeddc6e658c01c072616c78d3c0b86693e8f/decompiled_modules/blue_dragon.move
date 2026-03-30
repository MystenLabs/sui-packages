module 0x4f0468640f0943ae69fdded7610beeddc6e658c01c072616c78d3c0b86693e8f::blue_dragon {
    struct BLUE_DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE_DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE_DRAGON>(arg0, 6, b"BLUE DRAGON", b"Blue Dragon", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUE_DRAGON>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE_DRAGON>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUE_DRAGON>>(v2);
    }

    // decompiled from Move bytecode v6
}

