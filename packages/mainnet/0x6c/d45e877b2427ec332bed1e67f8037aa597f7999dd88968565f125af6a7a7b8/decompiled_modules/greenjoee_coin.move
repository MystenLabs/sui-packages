module 0x6cd45e877b2427ec332bed1e67f8037aa597f7999dd88968565f125af6a7a7b8::greenjoee_coin {
    struct GREENJOEE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GREENJOEE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GREENJOEE_COIN>>(0x2::coin::mint<GREENJOEE_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GREENJOEE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<GREENJOEE_COIN>(arg0, 8, b"GREENJOEE", b"GREENJOEE Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENJOEE_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<GREENJOEE_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREENJOEE_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

