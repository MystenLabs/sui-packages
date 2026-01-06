module 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::burner {
    struct BurnerRole has drop {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, BurnerRole>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<T0>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::ledger_token::treasury_cap_mut<T0>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::ledger_token_mut<T0>(arg0)), arg2);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_burned_event<T0>(0x2::coin::value<T0>(&arg2), 0x2::tx_context::sender(arg3));
    }

    public fun unwrap<T0, T1>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, BurnerRole>, arg2: &0x2::deny_list::DenyList, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::is_token_registered<T0, T1>(arg0), 13835058291505364993);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg2, v0), 13835339775072141315);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_unwrapped_event<T0, T1>(0x2::coin::value<T1>(&arg3), v0);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::unwrap<T0, T1>(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::stablecoin_mut<T0, T1>(arg0), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

