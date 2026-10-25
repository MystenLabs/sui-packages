module 0x994a134ba718f5636242685eda3e3845d2aaeb61e5a51ebb70a6a32dd6c26131::owl {
    struct OWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWL>(arg0, 6, b"OWL", b"Owl", b"Freely transferable Owl coin for a DeepBook OWL/USDC market.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<OWL>>(0x2::coin::mint<OWL>(&mut v2, 1000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWL>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OWL>>(v1, v3);
    }

    // decompiled from Move bytecode v7
}

