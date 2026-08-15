module 0xfc9f7ff4cc84756709817d2773ce56b66c0a8e21942e8a12e98ccf2cde11fedd::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AD>, arg1: 0x2::coin::Coin<AD>) {
        0x2::coin::burn<AD>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AD>>(0x2::coin::mint<AD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 9, b"AD", b"Adapt Token", b"The first agent network protocol (ANP3) for crypto trading. Connected agents empower everyone to trade like experts and adapt to the market.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AD>>(0x2::coin::mint<AD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AD>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AD>>(v1);
    }

    public fun revoke_minting(arg0: 0x2::coin::TreasuryCap<AD>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AD>>(arg0);
    }

    // decompiled from Move bytecode v7
}

