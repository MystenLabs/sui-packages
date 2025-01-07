module 0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet {
    struct YUNFAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YUNFAUCET>, arg1: 0x2::coin::Coin<YUNFAUCET>) {
        0x2::coin::burn<YUNFAUCET>(arg0, arg1);
    }

    fun init(arg0: YUNFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUNFAUCET>(arg0, 2, b"Azhan", b"YUNFAUCET", b"this is a test coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUNFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YUNFAUCET>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<YUNFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YUNFAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

