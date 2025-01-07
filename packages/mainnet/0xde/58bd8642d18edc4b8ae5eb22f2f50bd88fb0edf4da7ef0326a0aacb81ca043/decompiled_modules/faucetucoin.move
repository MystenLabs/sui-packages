module 0xde58bd8642d18edc4b8ae5eb22f2f50bd88fb0edf4da7ef0326a0aacb81ca043::faucetucoin {
    struct FAUCETUCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCETUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETUCOIN>(arg0, 2, b"FAUCETUCOIN", b"FUPC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETUCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCETUCOIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCETUCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCETUCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

