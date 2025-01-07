module 0x2e83851121e56ac100b29300554ddd157f4dcac44a1acc449a5d90f979dd3a68::durp {
    struct DURP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DURP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DURP>(arg0, 6, b"DURP", b"$DURP The Capy", x"68692e20696d2e20647572702e0a0a4d65207361696c696e67207468652053554920736561", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2f1a23b7_2131_4d65_a5af_2714699fef07_c91493117f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DURP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DURP>>(v1);
    }

    // decompiled from Move bytecode v6
}

