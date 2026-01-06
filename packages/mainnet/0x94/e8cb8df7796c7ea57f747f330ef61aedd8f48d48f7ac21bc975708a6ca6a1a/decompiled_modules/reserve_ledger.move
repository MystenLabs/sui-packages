module 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::reserve_ledger {
    struct RESERVE_LEDGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESERVE_LEDGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RESERVE_LEDGER>(arg0, 6, 0x1::string::utf8(b"RL"), 0x1::string::utf8(b"Reserve Ledger"), 0x1::string::utf8(b"Reserve Ledger Token"), 0x1::string::utf8(b""), arg1);
        let v2 = v0;
        let v3 = 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::new<RESERVE_LEDGER>(v1, 0x2::coin_registry::make_regulated<RESERVE_LEDGER>(&mut v2, true, arg1), 0x2::coin_registry::finalize<RESERVE_LEDGER>(v2, arg1), arg1);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::authorize<0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole, bool>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles_mut<RESERVE_LEDGER>(&mut v3), 0x2::tx_context::sender(arg1), true);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::share<RESERVE_LEDGER>(v3);
    }

    // decompiled from Move bytecode v6
}

