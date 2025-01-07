module 0xcd0af46a89ed3a8bf85ebd07c0e941c4fd9b027027cfff59b2893094e4c93dcf::suipop {
    struct SUIPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOP>(arg0, 6, b"SUIPOP", b"suipop", b"suipop", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPOP>>(0x2::coin::mint<SUIPOP>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

