module 0xac98d261a46baf26a125001fb3291ab790fc18fa72b24317cb7769c13d51cfec::dummycoin {
    struct DUMMYCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUMMYCOIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DUMMYCOIN> {
        0x2::coin::mint<DUMMYCOIN>(arg0, arg1, arg2)
    }

    fun init(arg0: DUMMYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMMYCOIN>(arg0, 9, b"DUMMY", b"Dummy", b"localnet dummy", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMMYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMMYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

