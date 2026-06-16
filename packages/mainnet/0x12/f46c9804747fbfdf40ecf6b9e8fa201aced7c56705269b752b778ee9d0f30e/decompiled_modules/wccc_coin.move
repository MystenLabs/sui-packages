module 0x12f46c9804747fbfdf40ecf6b9e8fa201aced7c56705269b752b778ee9d0f30e::wccc_coin {
    struct WCCC_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WCCC_COIN>, arg1: 0x2::coin::Coin<WCCC_COIN>) {
        0x2::coin::burn<WCCC_COIN>(arg0, arg1);
    }

    fun init(arg0: WCCC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCCC_COIN>(arg0, 6, b"WCCC", b"WCCC Token", b"WCCC - my own token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/wccc-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCCC_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCCC_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WCCC_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WCCC_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

