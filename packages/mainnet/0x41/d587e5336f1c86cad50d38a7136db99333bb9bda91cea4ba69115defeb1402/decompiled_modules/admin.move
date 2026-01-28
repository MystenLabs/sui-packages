module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::admin {
    public fun authorize_role<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>, arg2: address) {
        assert!(!0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::is_benefactor_role<T0>(), 13835339762187108353);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_role_authorized<T0>(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::authorize<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::roles_mut(arg0), arg2);
    }

    public fun deauthorize_role<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>, arg2: address) {
        assert!(!0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::is_benefactor_role<T0>(), 13835339792251879425);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_role_deauthorized<T0>(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::deauthorize<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::roles_mut(arg0), arg2);
    }

    public fun disable_global_pause(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_global_coin_pause_disabled();
        0x2::coin::deny_list_v2_disable_global_pause<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(arg2, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::deny_cap_mut(arg0), arg3);
    }

    public fun enable_benefactor(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>, arg2: address) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_benefactor_enabled(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::set_enabled(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor_mut(arg0, arg2), true);
    }

    public fun enable_collateral<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_enabled<T0>();
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::set_enabled<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0), true);
    }

    public fun enable_global_pause(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_global_coin_pause_enabled();
        0x2::coin::deny_list_v2_enable_global_pause<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(arg2, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::deny_cap_mut(arg0), arg3);
    }

    public fun enable_mint_redeem(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_mint_redeem_enabled();
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::enable_mint_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0));
    }

    public fun set_version(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::assert_is_authorized<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::roles_for_version_update(arg0), 0x2::tx_context::sender(arg2));
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::set_version(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut_for_version_update(arg0), arg1);
    }

    // decompiled from Move bytecode v6
}

