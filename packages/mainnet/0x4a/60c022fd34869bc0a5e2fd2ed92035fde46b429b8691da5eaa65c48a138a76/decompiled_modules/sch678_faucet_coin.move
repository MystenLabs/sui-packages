module 0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin {
    struct SCH678_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SCH678_FAUCET_COIN>, arg1: 0x2::coin::Coin<SCH678_FAUCET_COIN>) {
        0x2::coin::burn<SCH678_FAUCET_COIN>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SCH678_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCH678_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SCH678_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH678_FAUCET_COIN>(arg0, 9, b"SCH678_FAUCET_COIN", b"SCH678_FAUCET_COIN", b"my first faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCH678_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SCH678_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

