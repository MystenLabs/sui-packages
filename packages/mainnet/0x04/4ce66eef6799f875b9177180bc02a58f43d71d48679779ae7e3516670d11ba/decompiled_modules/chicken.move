module 0x44ce66eef6799f875b9177180bc02a58f43d71d48679779ae7e3516670d11ba::chicken {
    struct CHICKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHICKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHICKEN>>(0x2::coin::mint<CHICKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEN>(arg0, 6, b"CHICKEN", b"chicken chen", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICKEN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CHICKEN>>(v0);
    }

    // decompiled from Move bytecode v6
}

