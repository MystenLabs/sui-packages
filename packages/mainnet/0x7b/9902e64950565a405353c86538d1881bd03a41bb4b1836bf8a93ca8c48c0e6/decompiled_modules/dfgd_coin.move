module 0x7b9902e64950565a405353c86538d1881bd03a41bb4b1836bf8a93ca8c48c0e6::dfgd_coin {
    struct DFGD_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DFGD_COIN>, arg1: 0x2::coin::Coin<DFGD_COIN>) {
        0x2::coin::burn<DFGD_COIN>(arg0, arg1);
    }

    fun init(arg0: DFGD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFGD_COIN>(arg0, 6, b"WCCC", b"WCCC Token", b"WCCC - my own token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/wccc-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFGD_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFGD_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DFGD_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DFGD_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

