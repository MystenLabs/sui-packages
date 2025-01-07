module 0x17c4b6d783073406f77cacb21ff6ab906d9fdc5f4d825113819c62bfc49aa423::mint_coin {
    struct MINT_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINT_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MINT_COIN>>(0x2::coin::mint<MINT_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MINT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINT_COIN>(arg0, 9, b"USDS", b"Sui USD", b"Sui USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/usdd-usdd-logo.png?v=035")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINT_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MINT_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

