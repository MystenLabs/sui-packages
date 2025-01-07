module 0x3532789c2976cbc05868dba979423c5f6376da1de5ef1257d55d296b99e3c15a::jianhawang_coin {
    struct JIANHAWANG_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JIANHAWANG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JIANHAWANG_COIN>>(0x2::coin::mint<JIANHAWANG_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JIANHAWANG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<JIANHAWANG_COIN>(arg0, 8, b"JIANHAWANG", b"JIANHAWANG Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIANHAWANG_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<JIANHAWANG_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIANHAWANG_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

