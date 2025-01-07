module 0x6d2f7ed7d120ddf011754fc82753b2b79b2514913877c6d1d64dbac5a953eb0b::myro {
    struct MYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYRO>(arg0, 9, b"SUI MYRO", b"MYRO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYRO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

