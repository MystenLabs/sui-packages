module 0x8c67b2e20b4a40c14a301a5c27f93744531a3f230230111e01e6a4d968ad76ac::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 6, b"MY_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

