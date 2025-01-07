module 0x5585705cdf34c7a9b1739b680052c18283507e37286cb4f49a25f012ed6d5a1d::siuuuu {
    struct SIUUUU has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIUUUU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIUUUU>>(0x2::coin::mint<SIUUUU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SIUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUUU>(arg0, 6, b"SIUUUU", b"SIUUUU", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUUUU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUUU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

