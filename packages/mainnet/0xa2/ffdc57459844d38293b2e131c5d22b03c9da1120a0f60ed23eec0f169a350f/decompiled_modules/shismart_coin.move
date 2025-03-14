module 0xa2ffdc57459844d38293b2e131c5d22b03c9da1120a0f60ed23eec0f169a350f::shismart_coin {
    struct SHISMART_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHISMART_COIN>, arg1: 0x2::coin::Coin<SHISMART_COIN>) {
        0x2::coin::burn<SHISMART_COIN>(arg0, arg1);
    }

    fun init(arg0: SHISMART_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHISMART_COIN>(arg0, 6, b"shismart COIN", b"shismart COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHISMART_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHISMART_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHISMART_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHISMART_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

