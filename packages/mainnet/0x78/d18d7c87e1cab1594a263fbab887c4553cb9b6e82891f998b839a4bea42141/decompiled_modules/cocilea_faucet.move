module 0x78d18d7c87e1cab1594a263fbab887c4553cb9b6e82891f998b839a4bea42141::cocilea_faucet {
    struct COCILEA_FAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COCILEA_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COCILEA_FAUCET>>(0x2::coin::mint<COCILEA_FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COCILEA_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCILEA_FAUCET>(arg0, 6, b"COCILEA FAUCET", b"COCILEA FAUCET", b"COCILEA FAUCET", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCILEA_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<COCILEA_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

