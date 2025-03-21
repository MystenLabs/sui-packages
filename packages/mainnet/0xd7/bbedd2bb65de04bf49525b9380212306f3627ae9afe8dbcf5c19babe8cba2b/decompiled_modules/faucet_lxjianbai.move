module 0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai {
    struct FAUCET_LXJIANBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET_LXJIANBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_LXJIANBAI>(arg0, 9, b"FAUCET_LXJIANBAI", b"FAUCET_LXJIANBAI", b"FAUCET_LXJIANBAI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_LXJIANBAI>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_LXJIANBAI>>(v0);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_LXJIANBAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_LXJIANBAI>>(0x2::coin::mint<FAUCET_LXJIANBAI>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

