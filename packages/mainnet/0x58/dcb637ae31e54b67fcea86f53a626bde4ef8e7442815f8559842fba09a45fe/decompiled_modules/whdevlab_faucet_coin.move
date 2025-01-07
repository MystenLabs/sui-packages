module 0x58dcb637ae31e54b67fcea86f53a626bde4ef8e7442815f8559842fba09a45fe::whdevlab_faucet_coin {
    struct WHDEVLAB_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WHDEVLAB_FAUCET_COIN>, arg1: 0x2::coin::Coin<WHDEVLAB_FAUCET_COIN>) {
        0x2::coin::burn<WHDEVLAB_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: WHDEVLAB_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHDEVLAB_FAUCET_COIN>(arg0, 9, b"WHDEVLAB_FAUCET", b"faucet coin", b"faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHDEVLAB_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WHDEVLAB_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHDEVLAB_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WHDEVLAB_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

