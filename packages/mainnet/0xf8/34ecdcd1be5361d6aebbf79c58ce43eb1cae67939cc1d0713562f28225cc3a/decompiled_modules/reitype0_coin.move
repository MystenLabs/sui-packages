module 0xf834ecdcd1be5361d6aebbf79c58ce43eb1cae67939cc1d0713562f28225cc3a::reitype0_coin {
    struct REITYPE0_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<REITYPE0_COIN>, arg1: 0x2::coin::Coin<REITYPE0_COIN>) {
        0x2::coin::burn<REITYPE0_COIN>(arg0, arg1);
    }

    fun init(arg0: REITYPE0_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REITYPE0_COIN>(arg0, 9, b"REITYPE0_COIN", b"REITYPE0", b"first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/161667098")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REITYPE0_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REITYPE0_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REITYPE0_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REITYPE0_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

