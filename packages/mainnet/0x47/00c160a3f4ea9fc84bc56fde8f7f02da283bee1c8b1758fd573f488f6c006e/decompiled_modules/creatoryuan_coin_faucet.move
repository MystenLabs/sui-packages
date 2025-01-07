module 0x4700c160a3f4ea9fc84bc56fde8f7f02da283bee1c8b1758fd573f488f6c006e::creatoryuan_coin_faucet {
    struct CREATORYUAN_COIN_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATORYUAN_COIN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATORYUAN_COIN_FAUCET>(arg0, 6, b"CYCF", b"CreatorYuan Faucet Coin", b"this is CreatorYuan Faucet Coin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREATORYUAN_COIN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CREATORYUAN_COIN_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

