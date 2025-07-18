module 0xa05775788d1c905721190b9cd4239d7605f8cd9c7d7a27f685ab1c0c47c07bbd::suiacc {
    struct SUIACC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIACC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIACC>(arg0, 6, b"SUIACC", b"Suiacelerator", b"@SuiAIFun @suilaunchcoin @SuiNetwork @SuiFoundation @aixdg_agent @tokeninsight_io Launch a project on @SuiAIFun by tagging @SuiBuilders and including the project name and logo. $SUIACC + Suiacelerator https://t.co/dBQEXLCJKw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suiacc-4qb6bn.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIACC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIACC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

