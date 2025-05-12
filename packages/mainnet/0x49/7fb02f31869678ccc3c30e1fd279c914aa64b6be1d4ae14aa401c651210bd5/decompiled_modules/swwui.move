module 0x497fb02f31869678ccc3c30e1fd279c914aa64b6be1d4ae14aa401c651210bd5::swwui {
    struct SWWUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWWUI>, arg1: 0x2::coin::Coin<SWWUI>) {
        0x2::coin::burn<SWWUI>(arg0, arg1);
    }

    fun init(arg0: SWWUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWWUI>(arg0, 2, b"SWWUI", b"sowwui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWWUI>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWWUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWWUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWWUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

