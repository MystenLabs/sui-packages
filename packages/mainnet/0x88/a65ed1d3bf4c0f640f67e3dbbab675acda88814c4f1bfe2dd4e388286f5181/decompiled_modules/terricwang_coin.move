module 0x88a65ed1d3bf4c0f640f67e3dbbab675acda88814c4f1bfe2dd4e388286f5181::terricwang_coin {
    struct TERRICWANG_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TERRICWANG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TERRICWANG_COIN>>(0x2::coin::mint<TERRICWANG_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TERRICWANG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TERRICWANG_COIN>(arg0, 8, b"TERRICWANG", b"TERRICWANG Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERRICWANG_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TERRICWANG_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERRICWANG_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

