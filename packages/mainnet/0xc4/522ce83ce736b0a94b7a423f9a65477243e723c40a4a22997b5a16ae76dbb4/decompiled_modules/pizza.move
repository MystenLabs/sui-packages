module 0xc4522ce83ce736b0a94b7a423f9a65477243e723c40a4a22997b5a16ae76dbb4::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", b"Pizza crowfund", b"Just a crowdfund for restaurant pizza. Buy little, add liquidity and have faith.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745386833948.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIZZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

