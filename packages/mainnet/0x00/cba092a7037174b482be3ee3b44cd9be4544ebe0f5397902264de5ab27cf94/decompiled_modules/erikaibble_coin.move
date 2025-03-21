module 0xcba092a7037174b482be3ee3b44cd9be4544ebe0f5397902264de5ab27cf94::erikaibble_coin {
    struct ERIKAIBBLE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ERIKAIBBLE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ERIKAIBBLE_COIN>>(0x2::coin::mint<ERIKAIBBLE_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ERIKAIBBLE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ERIKAIBBLE_COIN>(arg0, 8, b"ERIKAIBBLE", b"ERIKAIBBLE Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIKAIBBLE_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ERIKAIBBLE_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERIKAIBBLE_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

