module 0xdbb37d401459210c7a6be00d71e13b877c5a470067b50aff93f4c1f30b5c012a::jupiter {
    struct JUPITER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUPITER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<JUPITER>(arg0, 9, b"jup", b"Jupiter", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<JUPITER>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JUPITER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JUPITER>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUPITER>>(v2);
    }

    // decompiled from Move bytecode v6
}

