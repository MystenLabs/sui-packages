module 0x64b1f6f09e42d41fd7b8f2da95fc8d0c1f03fe3dda72b143005065e1dcc3fcb7::mihu_faucet_coin {
    struct MIHU_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIHU_FAUCET_COIN>, arg1: 0x2::coin::Coin<MIHU_FAUCET_COIN>) {
        0x2::coin::burn<MIHU_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: MIHU_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHU_FAUCET_COIN>(arg0, 9, b"MIHU_FAUCET_COIN", b"MIHU", b"mihu's coin,this is good", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIHU_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MIHU_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIHU_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MIHU_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

