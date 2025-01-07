module 0x423d617b025a6e43d4d2b735ff73e2878f95ac6c32a9ee13275ce62db2bb714d::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET>>(0x2::coin::mint<FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 6, b"FAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

