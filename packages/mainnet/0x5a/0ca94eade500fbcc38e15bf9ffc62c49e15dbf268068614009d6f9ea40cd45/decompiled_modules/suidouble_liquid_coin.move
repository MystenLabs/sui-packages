module 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin {
    struct SUIDOUBLE_LIQUID_COIN has drop {
        dummy_field: bool,
    }

    public(friend) fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDOUBLE_LIQUID_COIN>, arg1: 0x2::coin::Coin<SUIDOUBLE_LIQUID_COIN>) {
        0x2::coin::burn<SUIDOUBLE_LIQUID_COIN>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDOUBLE_LIQUID_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDOUBLE_LIQUID_COIN>>(0x2::coin::mint<SUIDOUBLE_LIQUID_COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SUIDOUBLE_LIQUID_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOUBLE_LIQUID_COIN>(arg0, 9, b"iSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOUBLE_LIQUID_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOUBLE_LIQUID_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_and_return(arg0: &mut 0x2::coin::TreasuryCap<SUIDOUBLE_LIQUID_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIDOUBLE_LIQUID_COIN> {
        0x2::coin::mint<SUIDOUBLE_LIQUID_COIN>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

