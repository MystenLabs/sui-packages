module 0x919db1db921191bd77910afab462a520b9f2209ca491cdf62ef608c1eaf88198::limitcool_coin {
    struct LIMITCOOL_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIMITCOOL_COIN>, arg1: 0x2::coin::Coin<LIMITCOOL_COIN>) {
        0x2::coin::burn<LIMITCOOL_COIN>(arg0, arg1);
    }

    fun init(arg0: LIMITCOOL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMITCOOL_COIN>(arg0, 6, b"limitcool COIN", b"limitcool COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIMITCOOL_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMITCOOL_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIMITCOOL_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIMITCOOL_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

