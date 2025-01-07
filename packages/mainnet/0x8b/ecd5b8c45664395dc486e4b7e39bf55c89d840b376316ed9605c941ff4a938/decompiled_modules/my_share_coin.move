module 0x8becd5b8c45664395dc486e4b7e39bf55c89d840b376316ed9605c941ff4a938::my_share_coin {
    struct MY_SHARE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_SHARE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_SHARE_COIN>(arg0, 6, b"silver-x", b"my share coin", b"a share coin by test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_SHARE_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_SHARE_COIN>>(v0);
    }

    public fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<MY_SHARE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_SHARE_COIN>>(0x2::coin::mint<MY_SHARE_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

