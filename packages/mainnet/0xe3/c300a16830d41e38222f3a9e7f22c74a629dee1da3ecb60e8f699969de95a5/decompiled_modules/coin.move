module 0xe3c300a16830d41e38222f3a9e7f22c74a629dee1da3ecb60e8f699969de95a5::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: 0x2::coin::Coin<COIN>) : u64 {
        0x2::coin::burn<COIN>(arg0, arg1)
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN> {
        0x2::coin::mint<COIN>(arg0, arg1, arg2)
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 6, b"WUSDC", b"Wrapped USD Coin", b"Wrapped version of USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg3), arg2);
    }

    public fun unwrap(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: &mut 0x2::coin::TreasuryCap<0x8047311efca416ba10d07ab9a7b09ebc38849db4f42c768d1cacee08a4f22f67::usdc::USDC>, arg2: 0x2::coin::Coin<COIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8047311efca416ba10d07ab9a7b09ebc38849db4f42c768d1cacee08a4f22f67::usdc::USDC> {
        0x2::coin::burn<COIN>(arg0, arg2);
        0x2::coin::mint<0x8047311efca416ba10d07ab9a7b09ebc38849db4f42c768d1cacee08a4f22f67::usdc::USDC>(arg1, 0x2::coin::value<COIN>(&arg2), arg3)
    }

    public fun wrap(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: 0x2::coin::Coin<0x8047311efca416ba10d07ab9a7b09ebc38849db4f42c768d1cacee08a4f22f67::usdc::USDC>, arg2: &mut 0x2::coin::TreasuryCap<0x8047311efca416ba10d07ab9a7b09ebc38849db4f42c768d1cacee08a4f22f67::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN> {
        0x2::coin::burn<0x8047311efca416ba10d07ab9a7b09ebc38849db4f42c768d1cacee08a4f22f67::usdc::USDC>(arg2, arg1);
        0x2::coin::mint<COIN>(arg0, 0x2::coin::value<0x8047311efca416ba10d07ab9a7b09ebc38849db4f42c768d1cacee08a4f22f67::usdc::USDC>(&arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

