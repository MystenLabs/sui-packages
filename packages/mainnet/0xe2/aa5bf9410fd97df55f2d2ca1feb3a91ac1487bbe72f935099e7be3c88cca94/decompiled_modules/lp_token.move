module 0xe2aa5bf9410fd97df55f2d2ca1feb3a91ac1487bbe72f935099e7be3c88cca94::lp_token {
    struct LP_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<LP_TOKEN>(arg0, 6, b"Lotus LP Token", b"LFLP", b"LP token for Lotus Finance", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<LP_TOKEN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_TOKEN>>(v0, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LP_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

