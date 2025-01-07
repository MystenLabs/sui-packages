module 0xc7c04d9921908a14064522e2265a20d11b13e215133ee60b5387abfa677b32c::web3richer_faucet_coin {
    struct WEB3RICHER_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct TotalSupply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<WEB3RICHER_FAUCET_COIN>,
    }

    fun init(arg0: WEB3RICHER_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEB3RICHER_FAUCET_COIN>(arg0, 8, b"WRCF", b"Web3Richer Faucet Coin", b"the faucet coin for web3richer", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEB3RICHER_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WEB3RICHER_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut TotalSupply, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WEB3RICHER_FAUCET_COIN>>(0x2::coin::from_balance<WEB3RICHER_FAUCET_COIN>(0x2::balance::increase_supply<WEB3RICHER_FAUCET_COIN>(&mut arg0.supply, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

