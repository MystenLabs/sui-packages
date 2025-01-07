module 0x17823e9a70e7cbcc426d9cbd985e5394f9300376cb86b0d0af8bae106cb66a0d::AmuroToruFaucet {
    struct AMUROTORUFAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AMUROTORUFAUCET>, arg1: 0x2::coin::Coin<AMUROTORUFAUCET>) {
        0x2::coin::burn<AMUROTORUFAUCET>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AMUROTORUFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AMUROTORUFAUCET>>(0x2::coin::mint<AMUROTORUFAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AMUROTORUFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMUROTORUFAUCET>(arg0, 6, b"AMUROTORUCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMUROTORUFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<AMUROTORUFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

