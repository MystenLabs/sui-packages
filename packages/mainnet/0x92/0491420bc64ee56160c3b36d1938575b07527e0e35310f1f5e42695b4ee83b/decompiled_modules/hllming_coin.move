module 0x920491420bc64ee56160c3b36d1938575b07527e0e35310f1f5e42695b4ee83b::hllming_coin {
    struct HLLMING_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HLLMING_COIN>, arg1: 0x2::coin::Coin<HLLMING_COIN>) {
        0x2::coin::burn<HLLMING_COIN>(arg0, arg1);
    }

    fun init(arg0: HLLMING_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLLMING_COIN>(arg0, 9, b"HLLMING_COIN", b"HLLMING_COIN", b"coin create by mqh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169317797")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLLMING_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLLMING_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HLLMING_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HLLMING_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

