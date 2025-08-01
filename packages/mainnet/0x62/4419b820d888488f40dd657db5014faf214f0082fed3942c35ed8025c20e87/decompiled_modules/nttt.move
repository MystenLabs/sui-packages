module 0x624419b820d888488f40dd657db5014faf214f0082fed3942c35ed8025c20e87::nttt {
    struct NTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTTT>(arg0, 6, b"NTTT", b"Test NTT token", b"Test NTT token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

