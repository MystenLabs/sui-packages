module 0xfe0319a9f464a896fbd72a441e62ed6522b89244ced9f50c1c65540e6f76da65::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"Cat", b"TurboCat", x"54776974746572203a2068747470733a2f2f782e636f6d2f486f704361745375690a57656273697465203a2068747470733a2f2f686f706361742e66756e2f0a54656c656772616d3a2068747470733a2f2f742e6d652f486f70436174537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990191617.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

