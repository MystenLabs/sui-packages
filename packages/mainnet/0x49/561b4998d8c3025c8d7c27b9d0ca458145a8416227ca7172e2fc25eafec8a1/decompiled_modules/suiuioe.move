module 0x49561b4998d8c3025c8d7c27b9d0ca458145a8416227ca7172e2fc25eafec8a1::suiuioe {
    struct SUIUIOE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIUIOE>, arg1: 0x2::coin::Coin<SUIUIOE>) {
        0x2::coin::burn<SUIUIOE>(arg0, arg1);
    }

    fun init(arg0: SUIUIOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUIOE>(arg0, 2, b"SUIUIOE", b"bobasui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIUIOE>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 10000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUIOE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIUIOE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIUIOE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

