module 0xed5e64402a417c2f2e9f32ff3890768d1bfac8dbde22bd2dd3d73f63b6076218::moon_cat {
    struct MOON_CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON_CAT>(arg0, 6, b"MOON CAT", b"Moon CAT", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOON_CAT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON_CAT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOON_CAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

