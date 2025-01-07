module 0x630f2b2866ada39b91905f3b751be9e931b7e15da34d29ec922c0c9bf3e6f18c::sui_kini {
    struct SUI_KINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_KINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_KINI>(arg0, 6, b"SUIKINI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_KINI>>(v1);
        0x2::coin::mint_and_transfer<SUI_KINI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_KINI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

