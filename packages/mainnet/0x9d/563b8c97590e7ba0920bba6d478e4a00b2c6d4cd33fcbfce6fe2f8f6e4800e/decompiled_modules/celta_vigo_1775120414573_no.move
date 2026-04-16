module 0x9d563b8c97590e7ba0920bba6d478e4a00b2c6d4cd33fcbfce6fe2f8f6e4800e::celta_vigo_1775120414573_no {
    struct CELTA_VIGO_1775120414573_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELTA_VIGO_1775120414573_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CELTA_VIGO_1775120414573_NO>(arg0, 0, b"CELTA_VIGO_1775120414573_NO", b"CELTA_VIGO_1775120414573 NO", b"CELTA_VIGO_1775120414573 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CELTA_VIGO_1775120414573_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELTA_VIGO_1775120414573_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

