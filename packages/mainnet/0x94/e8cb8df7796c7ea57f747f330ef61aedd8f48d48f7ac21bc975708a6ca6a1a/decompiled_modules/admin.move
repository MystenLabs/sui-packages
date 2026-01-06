module 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::admin {
    public fun add_ledger_token_valid_mint_recipient<T0>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::ledger_token::valid_recipients_mut<T0>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::ledger_token_mut<T0>(arg0));
        assert!(!0x2::table::contains<address, bool>(v0, arg2), 13835058519138631681);
        0x2::table::add<address, bool>(v0, arg2, true);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_mint_recipient_added_event<T0, T0>(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun add_stablecoin_valid_mint_recipient<T0, T1>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::is_token_registered<T0, T1>(arg0), 13835621288703688709);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::add_valid_mint_recipient<T0, T1>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::stablecoin_mut<T0, T1>(arg0), arg2);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_mint_recipient_added_event<T0, T1>(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun authorize_role<T0, T1, T2: drop>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>, arg2: address) {
        if (0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::is_minter_role<T2, T1>()) {
            0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::authorize<T2, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::MinterRateLimit<T1>>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles_mut<T0>(arg0), arg2, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::default_mint_rate_limit<T1>());
        } else {
            0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::authorize<T2, bool>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles_mut<T0>(arg0), arg2, true);
        };
    }

    public fun deauthorize_role<T0, T1: drop, T2: drop + store>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>, arg2: address) {
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::deauthorize<T1, T2>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles_mut<T0>(arg0), arg2);
    }

    public(friend) fun is_admin_role<T0: drop>() : bool {
        0x1::type_name::with_defining_ids<0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>() == 0x1::type_name::with_defining_ids<T0>()
    }

    public fun remove_ledger_token_valid_mint_recipient<T0>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::ledger_token::valid_recipients_mut<T0>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::ledger_token_mut<T0>(arg0));
        assert!(0x2::table::contains<address, bool>(v0, arg2), 13835340084309786627);
        0x2::table::remove<address, bool>(v0, arg2);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_mint_recipient_removed_event<T0, T0>(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun remove_stablecoin_valid_mint_recipient<T0, T1>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::is_token_registered<T0, T1>(arg0), 13835621370308067333);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::remove_mint_recipient<T0, T1>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::stablecoin_mut<T0, T1>(arg0), arg2);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_mint_recipient_removed_event<T0, T1>(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun set_version<T0>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::assert_is_authorized<0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles<T0>(arg0), 0x2::tx_context::sender(arg2));
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::set_version<T0>(arg0, arg1);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_new_version_event<T0>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun update_and_reset_rate_limit<T0, T1>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::AdminRole>, arg2: address, arg3: u64) {
        assert!(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::is_authorized<0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::MinterRole<T1>>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles<T0>(arg0), arg2), 13835903124457783303);
        assert!(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::contains<0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::MinterRole<T1>, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::MinterRateLimit<T1>>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles<T0>(arg0), arg2), 13836184612319526921);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::update_and_reset_rate_limit<T1>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::config_mut<0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::MinterRole<T1>, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::minter::MinterRateLimit<T1>>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles_mut<T0>(arg0), arg2), arg3);
    }

    // decompiled from Move bytecode v6
}

