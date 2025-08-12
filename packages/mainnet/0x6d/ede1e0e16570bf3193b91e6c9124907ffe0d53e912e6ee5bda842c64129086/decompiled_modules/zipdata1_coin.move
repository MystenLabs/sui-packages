module 0x6dede1e0e16570bf3193b91e6c9124907ffe0d53e912e6ee5bda842c64129086::zipdata1_coin {
    struct ZIPDATA1_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZIPDATA1_COIN>, arg1: 0x2::coin::Coin<ZIPDATA1_COIN>) {
        0x2::coin::burn<ZIPDATA1_COIN>(arg0, arg1);
    }

    fun init(arg0: ZIPDATA1_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIPDATA1_COIN>(arg0, 9, b"ZIPDATA1", b"ZIPDATA1_COIN", b"ZIPDATA1 Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/0")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIPDATA1_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIPDATA1_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZIPDATA1_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZIPDATA1_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

