module 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::pauser {
    struct PauserRole has drop {
        dummy_field: bool,
    }

    public(friend) fun is_pauser_role<T0: drop>() : bool {
        0x1::type_name::with_defining_ids<PauserRole>() == 0x1::type_name::with_defining_ids<T0>()
    }

    public fun pause<T0, T1: drop>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, PauserRole>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::admin::is_admin_role<T1>(), 13835058166951313409);
        assert!(!is_pauser_role<T1>(), 13835339646223122435);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::pause<T1>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles_mut<T0>(arg0));
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_pause_event<T0, T1>(0x2::tx_context::sender(arg2), true);
    }

    public fun resume<T0, T1: drop>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, PauserRole>, arg2: &mut 0x2::tx_context::TxContext) {
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::unpause<T1>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::roles_mut<T0>(arg0));
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_pause_event<T0, T1>(0x2::tx_context::sender(arg2), false);
    }

    // decompiled from Move bytecode v6
}

