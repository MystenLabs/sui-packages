module 0xa91018753e993033bec7468f02a55b1f8eed2d8d33097d46fee2b508060f6cdd::beer {
    struct BEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 9, b"BEER", b"BEER", b"Deployed via Multi-Chain Token Deployer", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BEER>>(0x2::coin::mint<BEER>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEER>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEER>>(v1);
    }

    // decompiled from Move bytecode v7
}

