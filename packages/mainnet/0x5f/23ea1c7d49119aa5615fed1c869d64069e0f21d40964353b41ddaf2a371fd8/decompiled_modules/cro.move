module 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro {
    struct CRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRO>(arg0, 6, b"CRO", b"CROCODILE PROTOCOL", b"crocodile protocol's native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cro-ag.pages.dev/cro.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRO>>(v1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CRO>>(0x2::coin::mint<CRO>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

