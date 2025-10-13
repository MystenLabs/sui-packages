module 0x4249879b317387f8b15ea9eafcb502258bc1c7a4fe6c3c528624c57e3d40fe10::gamma {
    struct GAMMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMMA>(arg0, 9, b"GAMMA", b"Gamma Coin", b"Custom GAMMA token on SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GAMMA>>(0x2::coin::mint<GAMMA>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAMMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

