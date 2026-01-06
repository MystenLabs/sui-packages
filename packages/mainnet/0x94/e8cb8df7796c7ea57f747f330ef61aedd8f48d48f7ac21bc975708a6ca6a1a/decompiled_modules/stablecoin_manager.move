module 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin_manager {
    struct StablecoinManagerRole has drop {
        dummy_field: bool,
    }

    public fun register_stablecoin<T0, T1>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, StablecoinManagerRole>, arg2: &0x2::coin_registry::Currency<T0>, arg3: &0x2::coin_registry::Currency<T1>, arg4: 0x2::coin::TreasuryCap<T1>, arg5: 0x2::coin::DenyCapV2<T1>, arg6: 0x2::coin_registry::MetadataCap<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin_registry::decimals<T0>(arg2) == 0x2::coin_registry::decimals<T1>(arg3), 13835339710647631875);
        assert!(0x2::coin::total_supply<T1>(&arg4) == 0, 13835339719237697541);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::register_stablecoin<T0, T1>(arg0, arg4, arg5, arg6, arg7);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_stablecoin_registered_event<T0, T1>(0x2::tx_context::sender(arg7));
    }

    public fun unregister_stablecoin<T0, T1>(arg0: &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::TokenAuthority<T0>, arg1: &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::auth::Auth<T0, StablecoinManagerRole>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T1>, 0x2::coin::DenyCapV2<T1>, 0x2::coin_registry::MetadataCap<T1>) {
        assert!(0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::is_token_registered<T0, T1>(arg0), 13835058321570136065);
        let (v0, v1, v2) = 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority::unregister_stablecoin<T0, T1>(arg0);
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::events::emit_stablecoin_unregistered_event<T0, T1>(0x2::tx_context::sender(arg2));
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

