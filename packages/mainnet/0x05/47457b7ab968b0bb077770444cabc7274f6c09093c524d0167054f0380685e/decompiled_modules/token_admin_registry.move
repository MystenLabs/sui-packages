module 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::token_admin_registry {
    struct TokenAdminRegistryState has store, key {
        id: 0x2::object::UID,
        token_configs: 0x2::linked_table::LinkedTable<address, TokenConfig>,
        token_pool_package_id_to_coin_metadata: 0x2::linked_table::LinkedTable<address, address>,
    }

    struct TokenConfig has copy, drop, store {
        token_pool_package_id: address,
        token_pool_module: 0x1::string::String,
        token_type: 0x1::ascii::String,
        administrator: address,
        pending_administrator: address,
        token_pool_type_proof: 0x1::ascii::String,
        lock_or_burn_params: vector<address>,
        release_or_mint_params: vector<address>,
    }

    struct PoolSet has copy, drop {
        coin_metadata_address: address,
        previous_pool_package_id: address,
        new_pool_package_id: address,
        token_pool_type_proof: 0x1::ascii::String,
        lock_or_burn_params: vector<address>,
        release_or_mint_params: vector<address>,
    }

    struct PoolRegistered has copy, drop {
        coin_metadata_address: address,
        token_pool_package_id: address,
        administrator: address,
        token_pool_type_proof: 0x1::ascii::String,
    }

    struct PoolUnregistered has copy, drop {
        coin_metadata_address: address,
        previous_pool_address: address,
    }

    struct AdministratorTransferRequested has copy, drop {
        coin_metadata_address: address,
        current_admin: address,
        new_admin: address,
    }

    struct AdministratorTransferred has copy, drop {
        coin_metadata_address: address,
        new_admin: address,
    }

    public fun accept_admin_role(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        accept_admin_role_internal(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    fun accept_admin_role_internal(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: address) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"accept_admin_role"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<TokenAdminRegistryState>(arg0);
        assert!(0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1), 4);
        let v1 = 0x2::linked_table::borrow_mut<address, TokenConfig>(&mut v0.token_configs, arg1);
        assert!(v1.pending_administrator == arg2, 1);
        v1.administrator = v1.pending_administrator;
        v1.pending_administrator = @0x0;
        let v2 = AdministratorTransferred{
            coin_metadata_address : arg1,
            new_admin             : v1.administrator,
        };
        0x2::event::emit<AdministratorTransferred>(v2);
    }

    public fun get_all_configured_tokens(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: u64) : (vector<address>, address, bool) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"get_all_configured_tokens"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0);
        let v1 = 0;
        let v2 = vector[];
        let v3 = arg1;
        if (arg1 == @0x0) {
            if (0x2::linked_table::is_empty<address, TokenConfig>(&v0.token_configs)) {
                return (v2, arg1, false)
            };
            if (arg2 == 0) {
                return (v2, arg1, true)
            };
            let v4 = *0x1::option::borrow<address>(0x2::linked_table::front<address, TokenConfig>(&v0.token_configs));
            v3 = v4;
            0x1::vector::push_back<address>(&mut v2, v4);
            v1 = 1;
        } else {
            assert!(0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1), 6);
        };
        while (v1 < arg2) {
            let v5 = 0x2::linked_table::next<address, TokenConfig>(&v0.token_configs, v3);
            if (0x1::option::is_none<address>(v5)) {
                return (v2, v3, false)
            };
            let v6 = *0x1::option::borrow<address>(v5);
            v3 = v6;
            0x1::vector::push_back<address>(&mut v2, v6);
            v1 = v1 + 1;
        };
        (v2, v3, 0x1::option::is_some<address>(0x2::linked_table::next<address, TokenConfig>(&v0.token_configs, v3)))
    }

    public fun get_pool(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : address {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"get_pool"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0);
        if (0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1)) {
            0x2::linked_table::borrow<address, TokenConfig>(&v0.token_configs, arg1).token_pool_package_id
        } else {
            @0x0
        }
    }

    public fun get_pool_local_token(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : address {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"get_pool_local_token"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0);
        if (0x2::linked_table::contains<address, address>(&v0.token_pool_package_id_to_coin_metadata, arg1)) {
            *0x2::linked_table::borrow<address, address>(&v0.token_pool_package_id_to_coin_metadata, arg1)
        } else {
            @0x0
        }
    }

    public fun get_pools(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: vector<address>) : vector<address> {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"get_pools"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0);
        let v1 = vector[];
        let v2 = &arg1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(v2)) {
            let v4 = *0x1::vector::borrow<address>(v2, v3);
            if (0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, v4)) {
                0x1::vector::push_back<address>(&mut v1, 0x2::linked_table::borrow<address, TokenConfig>(&v0.token_configs, v4).token_pool_package_id);
            } else {
                0x1::vector::push_back<address>(&mut v1, @0x0);
            };
            v3 = v3 + 1;
        };
        v1
    }

    public fun get_token_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : (address, address, address) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"get_token_config"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0);
        if (0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1)) {
            let v4 = 0x2::linked_table::borrow<address, TokenConfig>(&v0.token_configs, arg1);
            (v4.token_pool_package_id, v4.administrator, v4.pending_administrator)
        } else {
            (@0x0, @0x0, @0x0)
        }
    }

    public fun get_token_config_data(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : (address, 0x1::string::String, 0x1::ascii::String, address, address, 0x1::ascii::String, vector<address>, vector<address>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"get_token_config_data"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0);
        if (0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1)) {
            let v9 = 0x2::linked_table::borrow<address, TokenConfig>(&v0.token_configs, arg1);
            (v9.token_pool_package_id, v9.token_pool_module, v9.token_type, v9.administrator, v9.pending_administrator, v9.token_pool_type_proof, v9.lock_or_burn_params, v9.release_or_mint_params)
        } else {
            (@0x0, 0x1::string::utf8(b""), 0x1::ascii::string(b""), @0x0, @0x0, 0x1::ascii::string(b""), vector[], vector[])
        }
    }

    public fun get_token_config_struct(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : TokenConfig {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"get_token_config_struct"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0);
        if (0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1)) {
            *0x2::linked_table::borrow<address, TokenConfig>(&v0.token_configs, arg1)
        } else {
            TokenConfig{token_pool_package_id: @0x0, token_pool_module: 0x1::string::utf8(b""), token_type: 0x1::ascii::string(b""), administrator: @0x0, pending_administrator: @0x0, token_pool_type_proof: 0x1::ascii::string(b""), lock_or_burn_params: vector[], release_or_mint_params: vector[]}
        }
    }

    public fun initialize(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 9);
        assert!(!0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::contains<TokenAdminRegistryState>(arg0), 2);
        let v0 = TokenAdminRegistryState{
            id                                     : 0x2::object::new(arg2),
            token_configs                          : 0x2::linked_table::new<address, TokenConfig>(arg2),
            token_pool_package_id_to_coin_metadata : 0x2::linked_table::new<address, address>(arg2),
        };
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::add<TokenAdminRegistryState>(arg0, arg1, v0, arg2);
    }

    public fun is_administrator(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: address) : bool {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"is_administrator"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0);
        assert!(0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1), 4);
        0x2::linked_table::borrow<address, TokenConfig>(&v0.token_configs, arg1).administrator == arg2
    }

    public fun is_pool_registered(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : bool {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"is_pool_registered"), 1);
        0x2::linked_table::contains<address, TokenConfig>(&0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<TokenAdminRegistryState>(arg0).token_configs, arg1)
    }

    public fun mcms_accept_admin_role(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"accept_admin_role"), 8);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v4, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        accept_admin_role_internal(arg0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address());
    }

    public fun mcms_register_pool(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"register_pool"), 8);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(v0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<address>();
        let v7 = 0;
        while (v7 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v6, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<address>();
        let v9 = 0;
        while (v9 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v8, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3));
            v9 = v9 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        register_pool_as_owner(v0, arg0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_string(&mut v3), 0x1::ascii::string(0x1::string::into_bytes(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_string(&mut v3))), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3), 0x1::ascii::string(0x1::string::into_bytes(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_string(&mut v3))), v6, v8, arg3);
    }

    public fun mcms_transfer_admin_role(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"transfer_admin_role"), 8);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v4, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        transfer_admin_role_internal(arg0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address());
    }

    public fun mcms_unregister_pool(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"unregister_pool"), 8);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v4, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        unregister_pool_internal(arg0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v3), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address());
    }

    public fun register_pool<T0, T1: drop>(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: address, arg4: vector<address>, arg5: vector<address>, arg6: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::publisher_wrapper::PublisherWrapper<T1>, arg7: T1) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"register_pool"), 1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        register_pool_internal(arg0, 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(arg2), 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::publisher_wrapper::get_package_address<T1>(arg6), 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::module_string(&v0))), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), arg3, 0x1::type_name::into_string(v0), arg4, arg5);
    }

    public fun register_pool_as_owner(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg1: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg2: address, arg3: address, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: address, arg7: 0x1::ascii::String, arg8: vector<address>, arg9: vector<address>, arg10: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg1, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"register_pool_as_owner"), 1);
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg0) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg1), 9);
        register_pool_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun register_pool_internal(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: 0x1::ascii::String, arg5: address, arg6: 0x1::ascii::String, arg7: vector<address>, arg8: vector<address>) {
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<TokenAdminRegistryState>(arg0);
        assert!(!0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1), 3);
        let v1 = TokenConfig{
            token_pool_package_id  : arg2,
            token_pool_module      : arg3,
            token_type             : arg4,
            administrator          : arg5,
            pending_administrator  : @0x0,
            token_pool_type_proof  : arg6,
            lock_or_burn_params    : arg7,
            release_or_mint_params : arg8,
        };
        0x2::linked_table::push_back<address, TokenConfig>(&mut v0.token_configs, arg1, v1);
        assert!(!0x2::linked_table::contains<address, address>(&v0.token_pool_package_id_to_coin_metadata, arg2), 10);
        0x2::linked_table::push_back<address, address>(&mut v0.token_pool_package_id_to_coin_metadata, arg2, arg1);
        let v2 = PoolRegistered{
            coin_metadata_address : arg1,
            token_pool_package_id : arg2,
            administrator         : arg5,
            token_pool_type_proof : arg6,
        };
        0x2::event::emit<PoolRegistered>(v2);
        let v3 = PoolSet{
            coin_metadata_address    : arg1,
            previous_pool_package_id : @0x0,
            new_pool_package_id      : arg2,
            token_pool_type_proof    : arg6,
            lock_or_burn_params      : arg7,
            release_or_mint_params   : arg8,
        };
        0x2::event::emit<PoolSet>(v3);
    }

    public fun register_pool_with_currency<T0, T1: drop>(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: address, arg4: vector<address>, arg5: vector<address>, arg6: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::publisher_wrapper::PublisherWrapper<T1>, arg7: T1) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"register_pool_with_currency"), 1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        register_pool_internal(arg0, 0x2::object::id_address<0x2::coin_registry::Currency<T0>>(arg2), 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::publisher_wrapper::get_package_address<T1>(arg6), 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::module_string(&v0))), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), arg3, 0x1::type_name::into_string(v0), arg4, arg5);
    }

    public fun transfer_admin_role(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        transfer_admin_role_internal(arg0, arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    fun transfer_admin_role_internal(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: address, arg3: address) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"transfer_admin_role"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<TokenAdminRegistryState>(arg0);
        assert!(0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1), 4);
        let v1 = 0x2::linked_table::borrow_mut<address, TokenConfig>(&mut v0.token_configs, arg1);
        assert!(v1.administrator == arg3, 5);
        v1.pending_administrator = arg2;
        let v2 = AdministratorTransferRequested{
            coin_metadata_address : arg1,
            current_admin         : v1.administrator,
            new_admin             : arg2,
        };
        0x2::event::emit<AdministratorTransferRequested>(v2);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"TokenAdminRegistry 1.6.0")
    }

    public fun unregister_pool(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        unregister_pool_internal(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    fun unregister_pool_internal(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: address) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"token_admin_registry"), 0x1::string::utf8(b"unregister_pool"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<TokenAdminRegistryState>(arg0);
        assert!(0x2::linked_table::contains<address, TokenConfig>(&v0.token_configs, arg1), 4);
        let v1 = 0x2::linked_table::remove<address, TokenConfig>(&mut v0.token_configs, arg1);
        assert!(v1.administrator == arg2 || v1.administrator == 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address(), 7);
        let v2 = v1.token_pool_package_id;
        assert!(0x2::linked_table::contains<address, address>(&v0.token_pool_package_id_to_coin_metadata, v2), 11);
        0x2::linked_table::remove<address, address>(&mut v0.token_pool_package_id_to_coin_metadata, v2);
        let v3 = PoolUnregistered{
            coin_metadata_address : arg1,
            previous_pool_address : v2,
        };
        0x2::event::emit<PoolUnregistered>(v3);
    }

    // decompiled from Move bytecode v6
}

