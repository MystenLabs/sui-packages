module 0x48167173804f04dc85c196b3bf6356886e806bb88ccf43d87b4c7cf2b8a9f250::rickiey_coin {
    struct RICKIEY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RICKIEY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RICKIEY_COIN>>(0x2::coin::mint<RICKIEY_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RICKIEY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<RICKIEY_COIN>(arg0, 8, b"RICKIEY", b"RICKIEY Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKIEY_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<RICKIEY_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICKIEY_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

