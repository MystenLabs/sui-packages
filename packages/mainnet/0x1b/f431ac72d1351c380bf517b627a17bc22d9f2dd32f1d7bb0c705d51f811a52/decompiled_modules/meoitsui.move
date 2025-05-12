module 0x1bf431ac72d1351c380bf517b627a17bc22d9f2dd32f1d7bb0c705d51f811a52::meoitsui {
    struct MEOITSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEOITSUI>, arg1: 0x2::coin::Coin<MEOITSUI>) {
        0x2::coin::burn<MEOITSUI>(arg0, arg1);
    }

    fun init(arg0: MEOITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOITSUI>(arg0, 2, b"MEOITSUI", b"meowsui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOITSUI>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOITSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEOITSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEOITSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

