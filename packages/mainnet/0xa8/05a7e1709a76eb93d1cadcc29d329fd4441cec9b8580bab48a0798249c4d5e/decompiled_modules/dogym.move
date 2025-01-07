module 0xa805a7e1709a76eb93d1cadcc29d329fd4441cec9b8580bab48a0798249c4d5e::dogym {
    struct DOGYM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGYM>, arg1: 0x2::coin::Coin<DOGYM>) {
        0x2::coin::burn<DOGYM>(arg0, arg1);
    }

    fun init(arg0: DOGYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGYM>(arg0, 4, b"DOGYM", b"DOGYM", b"The biggest memecoin in SUI blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.dogym.pro/uploads/dogym_4bfbed0805.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGYM>>(v1);
        let v3 = &mut v2;
        mint(v3, 210000000000000000, @0xb416fa71712c1900bc458c89eebb6cf2c232e08467c0d0ae3ecef95275ad7779, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGYM>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGYM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGYM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

