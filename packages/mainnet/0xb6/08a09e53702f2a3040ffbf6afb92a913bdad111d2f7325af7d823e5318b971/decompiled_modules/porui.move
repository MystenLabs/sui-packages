module 0xb608a09e53702f2a3040ffbf6afb92a913bdad111d2f7325af7d823e5318b971::porui {
    struct PORUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PORUI>, arg1: 0x2::coin::Coin<PORUI>) {
        0x2::coin::burn<PORUI>(arg0, arg1);
    }

    fun init(arg0: PORUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORUI>(arg0, 2, b"PORUI", b"moitoyi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORUI>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PORUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PORUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

