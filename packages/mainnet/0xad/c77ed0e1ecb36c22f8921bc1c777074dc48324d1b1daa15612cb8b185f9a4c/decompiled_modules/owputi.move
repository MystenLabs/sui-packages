module 0xadc77ed0e1ecb36c22f8921bc1c777074dc48324d1b1daa15612cb8b185f9a4c::owputi {
    struct OWPUTI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OWPUTI>, arg1: 0x2::coin::Coin<OWPUTI>) {
        0x2::coin::burn<OWPUTI>(arg0, arg1);
    }

    fun init(arg0: OWPUTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWPUTI>(arg0, 2, b"OWPUTI", b"suinemjto", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWPUTI>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWPUTI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OWPUTI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OWPUTI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

