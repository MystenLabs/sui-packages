module 0xfdf87c1b5e69dc6e705e34216a5bc6ad4f0a130dca271df94df7c85d23357785::feya_coin_faucet {
    struct FEYA_COIN_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEYA_COIN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEYA_COIN_FAUCET>(arg0, 9, b"FYCF", b"FeyaM Coin Faucet", b"Feya's first faucet coin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEYA_COIN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FEYA_COIN_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FEYA_COIN_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FEYA_COIN_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

