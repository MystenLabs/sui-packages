module 0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin {
    struct ZHBBLL_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZHBBLL_COIN>, arg1: 0x2::coin::Coin<ZHBBLL_COIN>) {
        0x2::coin::burn<ZHBBLL_COIN>(arg0, arg1);
    }

    fun init(arg0: ZHBBLL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHBBLL_COIN>(arg0, 9, b"ZHBBLL", b"ZHBBLL_COIN", b"ChainBabyCoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHBBLL_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHBBLL_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZHBBLL_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZHBBLL_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

