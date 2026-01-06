module 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::reserve_ledger {
    struct RESERVE_LEDGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESERVE_LEDGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RESERVE_LEDGER>(arg0, 6, 0x1::string::utf8(b"RL"), 0x1::string::utf8(b"Reserve Ledger"), 0x1::string::utf8(b"Reserve Ledger Token"), 0x1::string::utf8(b""), arg1);
        let v2 = v0;
        let v3 = 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::new<RESERVE_LEDGER>(v1, 0x2::coin_registry::make_regulated<RESERVE_LEDGER>(&mut v2, true, arg1), 0x2::coin_registry::finalize<RESERVE_LEDGER>(v2, arg1), arg1);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::authorize<0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::AdminRole, bool>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::roles_mut<RESERVE_LEDGER>(&mut v3), 0x2::tx_context::sender(arg1), true);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::share<RESERVE_LEDGER>(v3);
    }

    // decompiled from Move bytecode v6
}

