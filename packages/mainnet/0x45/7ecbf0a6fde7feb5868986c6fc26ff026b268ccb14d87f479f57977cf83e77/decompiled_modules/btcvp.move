module 0x457ecbf0a6fde7feb5868986c6fc26ff026b268ccb14d87f479f57977cf83e77::btcvp {
    struct BTCVP has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BTCVP>, arg1: 0x2::coin::Coin<BTCVP>) {
        0x2::coin::burn<BTCVP>(arg0, arg1);
    }

    fun init(arg0: BTCVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCVP>(arg0, 8, b"BTCvp", b"BTCvp", b"An simple token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCVP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCVP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTCVP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTCVP>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

