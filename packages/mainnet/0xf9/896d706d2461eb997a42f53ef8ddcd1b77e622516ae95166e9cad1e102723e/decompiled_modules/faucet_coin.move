module 0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun faucet(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 9, b"xiaxianlinFaucet", b"xiaxianlinFaucet", b"this is my faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

