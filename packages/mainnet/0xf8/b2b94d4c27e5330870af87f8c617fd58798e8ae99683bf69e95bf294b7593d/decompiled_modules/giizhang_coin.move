module 0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_coin {
    struct GIIZHANG_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GIIZHANG_COIN>, arg1: 0x2::coin::Coin<GIIZHANG_COIN>) {
        0x2::coin::burn<GIIZHANG_COIN>(arg0, arg1);
    }

    fun init(arg0: GIIZHANG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIIZHANG_COIN>(arg0, 9, b"GIIZHANG_COIN", b"GIIZHANG_COIN", b"coin create by mqh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169957055?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIIZHANG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIIZHANG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GIIZHANG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GIIZHANG_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

