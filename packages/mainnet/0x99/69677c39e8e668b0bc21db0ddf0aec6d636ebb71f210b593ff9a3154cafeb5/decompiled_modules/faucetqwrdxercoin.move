module 0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin {
    struct FAUCETQWRDXERCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCETQWRDXERCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETQWRDXERCOIN>(arg0, 6, b"FAUCETQWRDXERCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETQWRDXERCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCETQWRDXERCOIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCETQWRDXERCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCETQWRDXERCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

