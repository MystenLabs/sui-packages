module 0x9863ad57403bc1a1f412ca637964e5824bcacdb89228a500b5a09f444604b81f::xushizhao_faucet_coin {
    struct XUSHIZHAO_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct MyCoinTreasuryCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<XUSHIZHAO_FAUCET_COIN>,
    }

    fun init(arg0: XUSHIZHAO_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUSHIZHAO_FAUCET_COIN>(arg0, 9, b"xuCoin", b"xushizhao faucet Coin", b"xushizhao tow Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<XUSHIZHAO_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUSHIZHAO_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XUSHIZHAO_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XUSHIZHAO_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

