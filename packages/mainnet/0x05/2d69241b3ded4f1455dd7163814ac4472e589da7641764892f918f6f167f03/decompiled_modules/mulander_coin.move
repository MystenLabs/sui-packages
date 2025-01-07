module 0x52d69241b3ded4f1455dd7163814ac4472e589da7641764892f918f6f167f03::mulander_coin {
    struct MULANDER_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MULANDER_COIN>, arg1: 0x2::coin::Coin<MULANDER_COIN>) {
        0x2::coin::burn<MULANDER_COIN>(arg0, arg1);
    }

    fun init(arg0: MULANDER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULANDER_COIN>(arg0, 6, b"LAN", b"Mulander sui coin", b"Treasury in sui move", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULANDER_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MULANDER_COIN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MULANDER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MULANDER_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

