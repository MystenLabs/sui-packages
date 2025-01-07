module 0x456be599b2176b2426608f653999b38d3c41c49ac065969c7bdfd24da0be86e4::sch678_coin {
    struct SCH678_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SCH678_COIN>, arg1: 0x2::coin::Coin<SCH678_COIN>) {
        0x2::coin::burn<SCH678_COIN>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SCH678_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCH678_COIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<SCH678_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SCH678_COIN>>(0x2::coin::split<SCH678_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SCH678_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH678_COIN>(arg0, 9, b"SCH678_COIN", b"sch678", b"my first coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCH678_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH678_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

