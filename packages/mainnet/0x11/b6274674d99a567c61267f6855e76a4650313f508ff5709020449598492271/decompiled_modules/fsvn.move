module 0x11b6274674d99a567c61267f6855e76a4650313f508ff5709020449598492271::fsvn {
    struct FSVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSVN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FSVN>(arg0, 6, b"FSVN", b"Agent 47 by SuiAI", b"I am the agent of authority.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000000703_dbfad888f5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FSVN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSVN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

