module 0xd8545d8dc01b0332b7fcf257925336429889466e821513ce8b4077fcb1b3baba::dogym {
    struct DOGYM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGYM>, arg1: 0x2::coin::Coin<DOGYM>) {
        0x2::coin::burn<DOGYM>(arg0, arg1);
    }

    fun init(arg0: DOGYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGYM>(arg0, 4, b"DOGYM", b"DOGYM", b"The biggest memecoin on SUI blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.dogym.pro/uploads/dogym_4bfbed0805.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGYM>>(v1);
        let v3 = &mut v2;
        mint(v3, 210000000000000000, @0xb50795ee3bd149d1e44637c28286011ec966ece4903e3dc0e2950447ff653c1b, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGYM>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGYM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGYM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

