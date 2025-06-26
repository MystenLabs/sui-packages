module 0x96064b23ddee6d43e7c4cc5c51eb64a9ec38c1472816477b9d9cd87194ebf19::pletok {
    struct PLETOK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PLETOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PLETOK>>(0x2::coin::mint<PLETOK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PLETOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLETOK>(arg0, 6, b"PLETOK", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLETOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLETOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

