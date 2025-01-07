module 0x8c80ef9f2cc36c522a91d85db958eb3982fe3ed580dfa6ac8c36fae15f215dd2::my_first_coin {
    struct MY_FIRST_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_FIRST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_FIRST_COIN>(arg0, 6, b"MY_FIRST_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_FIRST_COIN>>(v1);
        0x2::coin::mint_and_transfer<MY_FIRST_COIN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_FIRST_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

