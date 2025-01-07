module 0x13ed02d4ef593862ae7b9d6560e05120a407f11cb0e50ded4e306be62b50f42e::regulated_coin {
    struct REGULATED_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<REGULATED_COIN>(arg0, 5, b"STABLE$", b"RegulaCoin", b"Example Regulated Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<REGULATED_COIN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGULATED_COIN>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

