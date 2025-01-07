module 0xb9c4d3659b3f1e29ac20f11fa9c147bb9f15908dd0fc836e90f6d25afc05513b::mc_coin {
    struct MC_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MC_COIN>, arg1: 0x2::coin::Coin<MC_COIN>) {
        0x2::coin::burn<MC_COIN>(arg0, arg1);
    }

    fun init(arg0: MC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC_COIN>(arg0, 6, b"MC", b"MC Coin", b"mc_coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MC_COIN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MC_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MC_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

