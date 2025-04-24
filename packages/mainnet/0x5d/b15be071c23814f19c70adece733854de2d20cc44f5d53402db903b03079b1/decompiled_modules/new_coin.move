module 0x5db15be071c23814f19c70adece733854de2d20cc44f5d53402db903b03079b1::new_coin {
    struct NEW_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW_COIN>(arg0, 9, b"NEW", b"New Coin", b"A coin with a fixed 1 billion supply", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NEW_COIN>>(0x2::coin::from_balance<NEW_COIN>(0x2::coin::mint_balance<NEW_COIN>(&mut v2, 1000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEW_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEW_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

