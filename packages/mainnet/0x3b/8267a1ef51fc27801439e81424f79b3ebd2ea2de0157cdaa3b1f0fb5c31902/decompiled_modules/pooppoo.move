module 0x3b8267a1ef51fc27801439e81424f79b3ebd2ea2de0157cdaa3b1f0fb5c31902::pooppoo {
    struct POOPPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPPOO>(arg0, 6, b"POOPPOO", b"pooppoo Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOPPOO>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOPPOO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POOPPOO>>(v2);
    }

    // decompiled from Move bytecode v6
}

