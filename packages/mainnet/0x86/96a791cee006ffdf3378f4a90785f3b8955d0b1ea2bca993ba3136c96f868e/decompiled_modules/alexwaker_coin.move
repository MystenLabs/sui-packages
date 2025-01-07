module 0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin {
    struct ALEXWAKER_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ALEXWAKER_COIN>, arg1: 0x2::coin::Coin<ALEXWAKER_COIN>) {
        0x2::coin::burn<ALEXWAKER_COIN>(arg0, arg1);
    }

    fun init(arg0: ALEXWAKER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALEXWAKER_COIN>(arg0, 9, b"AWC2", b"ALEXWAKER COIN NO2", b"Alexwaker Coin No2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALEXWAKER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALEXWAKER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<ALEXWAKER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ALEXWAKER_COIN>>(0x2::coin::mint<ALEXWAKER_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

