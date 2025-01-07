module 0x7b9d39ff97c37b020713dbc41b4fe91f2100ba08e516aa798763fb70ce8f584::my_gamble {
    struct MY_GAMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_GAMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_GAMBLE>(arg0, 9, b"MY_GAMBLE", b"GAMBLE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MY_GAMBLE>(&mut v2, 9999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_GAMBLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_GAMBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

