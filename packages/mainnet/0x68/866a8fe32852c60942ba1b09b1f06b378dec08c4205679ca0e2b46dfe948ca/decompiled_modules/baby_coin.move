module 0x68866a8fe32852c60942ba1b09b1f06b378dec08c4205679ca0e2b46dfe948ca::baby_coin {
    struct BABY_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABY_COIN>, arg1: 0x2::coin::Coin<BABY_COIN>) {
        0x2::coin::burn<BABY_COIN>(arg0, arg1);
    }

    fun init(arg0: BABY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY_COIN>(arg0, 9, b"BABY", b"BABY_COIN", b"ChainBabyCoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

