module 0x1ba1b638dc02149aac17b0a1f704f0f66f5e1af7f1b4ae9fba1463d76df315a4::dummycoin {
    struct DUMMYCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUMMYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUMMYCOIN>>(0x2::coin::mint<DUMMYCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DUMMYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMMYCOIN>(arg0, 6, b"DUMMYCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMMYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMMYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

