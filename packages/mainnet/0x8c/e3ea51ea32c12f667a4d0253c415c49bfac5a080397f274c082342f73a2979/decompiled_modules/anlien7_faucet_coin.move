module 0x8ce3ea51ea32c12f667a4d0253c415c49bfac5a080397f274c082342f73a2979::anlien7_faucet_coin {
    struct ANLIEN7_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANLIEN7_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANLIEN7_FAUCET_COIN>(arg0, 9, b"ANLIEN7", b"ANLIEN7_FAUCET_COIN", b"ANLIEN7 FAUCET Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANLIEN7_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ANLIEN7_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANLIEN7_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANLIEN7_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

