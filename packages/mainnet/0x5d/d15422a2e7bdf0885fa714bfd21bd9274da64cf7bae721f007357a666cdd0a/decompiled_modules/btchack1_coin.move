module 0x5dd15422a2e7bdf0885fa714bfd21bd9274da64cf7bae721f007357a666cdd0a::btchack1_coin {
    struct BTCHACK1_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCHACK1_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCHACK1_COIN>(arg0, 9, b"BTCHACK1", b"BTCHACK1_COIN", b"BTCHACK1 Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCHACK1_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCHACK1_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTCHACK1_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTCHACK1_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

