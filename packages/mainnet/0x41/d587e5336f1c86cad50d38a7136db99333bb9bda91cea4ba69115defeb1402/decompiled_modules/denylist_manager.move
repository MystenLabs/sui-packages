module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::denylist_manager {
    struct DenylistManagerRole {
        dummy_field: bool,
    }

    public fun add_to_denylist(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<DenylistManagerRole>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_address_added_to_denylist(arg3);
        if (0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::has_benefactor(arg0, arg3)) {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::set_enabled(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor_mut(arg0, arg3), false);
        };
        0x2::coin::deny_list_v2_add<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(arg2, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::deny_cap_mut(arg0), arg3, arg4);
    }

    public fun remove_from_denylist(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<DenylistManagerRole>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_address_removed_from_denylist(arg3);
        0x2::coin::deny_list_v2_remove<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(arg2, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::deny_cap_mut(arg0), arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

