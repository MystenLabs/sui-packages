module 0xde5ae880b78d81f9a721307c61eedc082d89784c5aedcb220a9b587ae97cf487::CodingGeoff_coin {
    struct CODINGGEOFF_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CODINGGEOFF_COIN>, arg1: 0x2::coin::Coin<CODINGGEOFF_COIN>) {
        0x2::coin::burn<CODINGGEOFF_COIN>(arg0, arg1);
    }

    fun init(arg0: CODINGGEOFF_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODINGGEOFF_COIN>(arg0, 6, b"CodingGeoff COIN", b"CodingGeoff COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CODINGGEOFF_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODINGGEOFF_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CODINGGEOFF_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CODINGGEOFF_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

