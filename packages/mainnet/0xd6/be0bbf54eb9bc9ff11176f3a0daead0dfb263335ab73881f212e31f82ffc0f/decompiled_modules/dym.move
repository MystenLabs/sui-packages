module 0xd6be0bbf54eb9bc9ff11176f3a0daead0dfb263335ab73881f212e31f82ffc0f::dym {
    struct DYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYM>(arg0, 1, b"DYM", b"Dymension", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DYM>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

