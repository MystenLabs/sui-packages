module 0x7586df08d080f128555266c33e9b7a81e46830fc9a456310b3e64883f9654166::GOLDMAN {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xbc5950046e56037c8a5020dda371b81ee421490469d0bdda575ff80d6e284a8e::connector_v3::new<GOLDMAN>(arg0, 1000, b"goldman", b"GOLDMAN", x"676f6c646d616e2062792073756966756e20f09f9887", b"http://127.0.0.1:8000/api/v1/blob/4x5FRA-9nziMytUbhUuGOFCF7EWH1EgdRAusZTJuCx4", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

