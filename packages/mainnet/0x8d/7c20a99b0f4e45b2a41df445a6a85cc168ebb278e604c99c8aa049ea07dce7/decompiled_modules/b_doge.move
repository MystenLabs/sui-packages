module 0x8d7c20a99b0f4e45b2a41df445a6a85cc168ebb278e604c99c8aa049ea07dce7::b_doge {
    struct B_DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DOGE>(arg0, 6, b"B DOGE", b"Burn Doge", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<B_DOGE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B_DOGE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<B_DOGE>>(v2);
    }

    // decompiled from Move bytecode v6
}

