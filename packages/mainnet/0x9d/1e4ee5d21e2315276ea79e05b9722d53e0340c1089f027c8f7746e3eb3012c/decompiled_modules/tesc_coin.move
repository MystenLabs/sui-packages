module 0x9d1e4ee5d21e2315276ea79e05b9722d53e0340c1089f027c8f7746e3eb3012c::tesc_coin {
    struct TESC_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESC_COIN>, arg1: 0x2::coin::Coin<TESC_COIN>) {
        0x2::coin::burn<TESC_COIN>(arg0, arg1);
    }

    fun init(arg0: TESC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESC_COIN>(arg0, 9, b"TESC", b"CEST", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/benjabbbb/default/refs/heads/main/28b17219.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESC_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESC_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESC_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESC_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

