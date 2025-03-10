module 0xd1f8115d522169237ce55ba3a2186dabca1d0d8fe96dd5d7514103150eccec6c::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 6, b"CUIDAQUAN_COIN", b"cuidaquan_coin", b"my_coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

