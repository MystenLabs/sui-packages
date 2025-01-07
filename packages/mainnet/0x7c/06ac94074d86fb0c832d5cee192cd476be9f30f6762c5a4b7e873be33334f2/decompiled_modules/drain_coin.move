module 0x7c06ac94074d86fb0c832d5cee192cd476be9f30f6762c5a4b7e873be33334f2::drain_coin {
    struct DRAIN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRAIN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DRAIN_COIN>>(0x2::coin::mint<DRAIN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DRAIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAIN_COIN>(arg0, 9, b"USDS", b"Sui USD", b"Sui USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/usdd-usdd-logo.png?v=035")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAIN_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DRAIN_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

