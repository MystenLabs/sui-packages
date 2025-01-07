module 0x6dedd501c0053fa135033a86b23123041d32a239f42673246d30952c3f1336f0::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"symbol", b"token name", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, @0x0);
    }

    public entry fun transfer_to_burn_address(arg0: 0x2::coin::Coin<TARZAN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TARZAN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

