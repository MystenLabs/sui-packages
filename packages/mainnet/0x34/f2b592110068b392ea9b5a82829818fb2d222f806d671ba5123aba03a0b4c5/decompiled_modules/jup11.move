module 0x34f2b592110068b392ea9b5a82829818fb2d222f806d671ba5123aba03a0b4c5::jup11 {
    struct JUP11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<JUP11>(arg0, 9, b"jup", b"jup11", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<JUP11>(&mut v3, 123000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JUP11>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JUP11>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUP11>>(v2);
    }

    // decompiled from Move bytecode v6
}

