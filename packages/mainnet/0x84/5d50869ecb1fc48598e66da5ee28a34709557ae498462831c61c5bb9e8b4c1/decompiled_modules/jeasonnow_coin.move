module 0x845d50869ecb1fc48598e66da5ee28a34709557ae498462831c61c5bb9e8b4c1::jeasonnow_coin {
    struct JEASONNOW_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JEASONNOW_COIN>, arg1: 0x2::coin::Coin<JEASONNOW_COIN>) {
        0x2::coin::burn<JEASONNOW_COIN>(arg0, arg1);
    }

    fun init(arg0: JEASONNOW_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEASONNOW_COIN>(arg0, 8, b"JC", b"JeasonnowCoin", b"Jeasonnow Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEASONNOW_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEASONNOW_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JEASONNOW_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JEASONNOW_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

