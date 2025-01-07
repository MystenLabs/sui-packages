module 0x98a325024ddd50b46bd58c3925429ecacd95d5c79ac99c4a10841ceca439cdd7::payment_pepe {
    struct PAYMENT_PEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PAYMENT_PEPE>, arg1: 0x2::coin::Coin<PAYMENT_PEPE>) {
        0x2::coin::burn<PAYMENT_PEPE>(arg0, arg1);
    }

    fun init(arg0: PAYMENT_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAYMENT_PEPE>(arg0, 9, b"PAYMENT_PEPE on Sui", b"PAYMENT_PEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAYMENT_PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAYMENT_PEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAYMENT_PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PAYMENT_PEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

