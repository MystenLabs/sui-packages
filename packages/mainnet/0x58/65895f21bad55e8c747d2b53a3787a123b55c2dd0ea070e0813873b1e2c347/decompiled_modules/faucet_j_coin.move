module 0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin {
    struct FAUCET_J_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_J_COIN>, arg1: 0x2::coin::Coin<FAUCET_J_COIN>) {
        0x2::coin::burn<FAUCET_J_COIN>(arg0, arg1);
    }

    fun init(arg0: FAUCET_J_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_J_COIN>(arg0, 9, b"CRF", b"FAUCET_COIN", b"Janrone Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/1483883")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_J_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_J_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_J_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET_J_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

