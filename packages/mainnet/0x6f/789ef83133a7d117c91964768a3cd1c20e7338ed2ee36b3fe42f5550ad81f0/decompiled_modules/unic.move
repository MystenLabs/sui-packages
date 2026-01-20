module 0x6f789ef83133a7d117c91964768a3cd1c20e7338ed2ee36b3fe42f5550ad81f0::unic {
    struct UNIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIC>(arg0, 8, b"UNIC", b"UniCore Token", b"The utility token for UniCore DePIN network", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<UNIC>>(0x2::coin::mint<UNIC>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

