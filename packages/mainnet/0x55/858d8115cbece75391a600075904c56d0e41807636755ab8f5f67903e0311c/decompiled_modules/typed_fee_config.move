module 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_config {
    struct TypedFeeAdminCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct TypedFeeConfig<phantom T0> has key {
        id: 0x2::object::UID,
        policy_version: u64,
        config_version: u64,
        network: u8,
        asset_type_bytes: vector<u8>,
        decimals: u8,
        bps: u64,
        min_fee_amount: u64,
        max_fee_amount: u64,
        min_viable_order_amount: u64,
        enabled: bool,
    }

    struct TypedFeeConfigCreated<phantom T0> has copy, drop {
        config_id: 0x2::object::ID,
        policy_version: u64,
        config_version: u64,
        network: u8,
        asset_type_bytes: vector<u8>,
        decimals: u8,
        bps: u64,
        min_fee_amount: u64,
        max_fee_amount: u64,
        min_viable_order_amount: u64,
        enabled: bool,
    }

    struct TypedFeeConfigUpdated<phantom T0> has copy, drop {
        config_id: 0x2::object::ID,
        previous_config_version: u64,
        previous_enabled: bool,
        previous_policy_version: u64,
        previous_decimals: u8,
        previous_bps: u64,
        previous_min_fee_amount: u64,
        previous_max_fee_amount: u64,
        previous_min_viable_order_amount: u64,
        policy_version: u64,
        config_version: u64,
        network: u8,
        asset_type_bytes: vector<u8>,
        decimals: u8,
        bps: u64,
        min_fee_amount: u64,
        max_fee_amount: u64,
        min_viable_order_amount: u64,
        enabled: bool,
    }

    struct TypedFeeConfigEnabledSet<phantom T0> has copy, drop {
        config_id: 0x2::object::ID,
        previous_config_version: u64,
        config_version: u64,
        network: u8,
        asset_type_bytes: vector<u8>,
        previous_enabled: bool,
        enabled: bool,
    }

    public(friend) fun abi_public_package_only_until_publish() : u8 {
        4
    }

    public(friend) fun admin_cap_public_transfer_allowed<T0>() : bool {
        false
    }

    public fun admin_update_can_enable_collateral_lane<T0>() : bool {
        false
    }

    fun assert_supported_config_target<T0>() {
        assert!(config_target_supported<T0>(), 1);
    }

    fun assert_supported_policy_version(arg0: u64) {
        assert!(arg0 == 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::minimum_start_policy_version(), 3);
    }

    fun assert_valid_config_params<T0>(arg0: u64, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(config_params_valid<T0>(arg0, arg1, arg2, arg3, arg4, arg5), 2);
    }

    public fun asset_type_matches_config<T0>(arg0: &TypedFeeConfig<T0>) : bool {
        0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::onchain_asset_lane_manager::matches_supported_order_typed_non_sui_asset_bytes<T0>(&arg0.asset_type_bytes)
    }

    public fun bps<T0>(arg0: &TypedFeeConfig<T0>) : u64 {
        arg0.bps
    }

    public(friend) fun config_event_audit_skeleton_active<T0>() : bool {
        config_target_supported<T0>()
    }

    public(friend) fun config_helper_abi_classification<T0>() : u8 {
        if (config_target_supported<T0>()) {
            return 4
        };
        3
    }

    public(friend) fun config_level_ready_for_runtime_candidate<T0>(arg0: &TypedFeeConfig<T0>) : bool {
        arg0.enabled && minimum_start_config<T0>(arg0)
    }

    public(friend) fun config_lifecycle_package_created_owned() : u8 {
        1
    }

    public(friend) fun config_mutation_events_emitted<T0>() : bool {
        config_target_supported<T0>()
    }

    public fun config_params_valid<T0>(arg0: u64, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : bool {
        arg0 == 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::minimum_start_policy_version() && 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::admin_update_params_valid<T0>(arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun config_public_transfer_allowed<T0>() : bool {
        false
    }

    public fun config_shape_valid<T0>(arg0: &TypedFeeConfig<T0>) : bool {
        if (config_target_supported<T0>()) {
            if (asset_type_matches_config<T0>(arg0)) {
                if (arg0.network == network_for_config_target<T0>()) {
                    if (arg0.config_version >= 1) {
                        config_params_valid<T0>(arg0.policy_version, arg0.decimals, arg0.bps, arg0.min_fee_amount, arg0.max_fee_amount, arg0.min_viable_order_amount)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun config_target_supported<T0>() : bool {
        if (0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_policy::exact_typed_fee_policy_required<T0>()) {
            if (0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_policy::typed_collateral_fee_policy_closed<T0>()) {
                0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::onchain_asset_lane_manager::is_supported_order_typed_non_sui_asset<T0>()
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun config_version<T0>(arg0: &TypedFeeConfig<T0>) : u64 {
        arg0.config_version
    }

    public(friend) fun create_admin_cap<T0>(arg0: &mut 0x2::tx_context::TxContext) : TypedFeeAdminCap<T0> {
        assert_supported_config_target<T0>();
        TypedFeeAdminCap<T0>{id: 0x2::object::new(arg0)}
    }

    public(friend) fun create_config<T0>(arg0: &TypedFeeAdminCap<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : TypedFeeConfig<T0> {
        assert_supported_config_target<T0>();
        assert_supported_policy_version(arg1);
        assert!(arg2 == 1, 3);
        assert_valid_config_params<T0>(arg1, arg3, arg4, arg5, arg6, arg7);
        let v0 = TypedFeeConfig<T0>{
            id                      : 0x2::object::new(arg9),
            policy_version          : arg1,
            config_version          : arg2,
            network                 : network_for_config_target<T0>(),
            asset_type_bytes        : supported_asset_type_bytes<T0>(),
            decimals                : arg3,
            bps                     : arg4,
            min_fee_amount          : arg5,
            max_fee_amount          : arg6,
            min_viable_order_amount : arg7,
            enabled                 : arg8,
        };
        emit_config_created<T0>(&v0);
        v0
    }

    public(friend) fun create_minimum_start_config<T0>(arg0: &TypedFeeAdminCap<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : TypedFeeConfig<T0> {
        create_config<T0>(arg0, 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::minimum_start_policy_version(), 1, 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::native_sui_usdc_decimals(), 0, 0, 0, 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::min_viable_order_amount_floor(), arg1, arg2)
    }

    public(friend) fun created_event_counts_as_enablement_event<T0>() : bool {
        false
    }

    public(friend) fun custody_model_defer_owner_vault_decision() : u8 {
        1
    }

    public(friend) fun custody_package_controlled_owned() : u8 {
        1
    }

    public fun decimals<T0>(arg0: &TypedFeeConfig<T0>) : u8 {
        arg0.decimals
    }

    public fun disabled_seed_entry_creates_enabled_config<T0>() : bool {
        disabled_seed_entry_source_candidate<T0>() && false
    }

    public fun disabled_seed_entry_expected_custody<T0>() : 0x1::option::Option<address> {
        if (disabled_seed_entry_source_candidate<T0>()) {
            return 0x1::option::some<address>(@0x3b8916cf8bc90fdfcb0a5fd511f35a3d1ddc567817ca9e6164f9dd217077d1fe)
        };
        0x1::option::none<address>()
    }

    public fun disabled_seed_entry_hard_one_shot_claimed<T0>() : bool {
        disabled_seed_entry_source_candidate<T0>() && false
    }

    public fun disabled_seed_entry_runtime_enablement_allowed<T0>() : bool {
        disabled_seed_entry_source_candidate<T0>() && false
    }

    public fun disabled_seed_entry_shares_or_vaults_config<T0>() : bool {
        disabled_seed_entry_source_candidate<T0>() && false
    }

    public fun disabled_seed_entry_source_candidate<T0>() : bool {
        0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::onchain_asset_lane_manager::matches_sui_usdc_testnet_type<T0>() && config_target_supported<T0>()
    }

    public fun e_invalid_params() : u64 {
        2
    }

    public fun e_invalid_version() : u64 {
        3
    }

    public fun e_seed_entry_retired() : u64 {
        5
    }

    public fun e_unauthorized_seed() : u64 {
        4
    }

    public fun e_unsupported_asset() : u64 {
        1
    }

    fun emit_config_created<T0>(arg0: &TypedFeeConfig<T0>) {
        let v0 = TypedFeeConfigCreated<T0>{
            config_id               : 0x2::object::id<TypedFeeConfig<T0>>(arg0),
            policy_version          : arg0.policy_version,
            config_version          : arg0.config_version,
            network                 : arg0.network,
            asset_type_bytes        : arg0.asset_type_bytes,
            decimals                : arg0.decimals,
            bps                     : arg0.bps,
            min_fee_amount          : arg0.min_fee_amount,
            max_fee_amount          : arg0.max_fee_amount,
            min_viable_order_amount : arg0.min_viable_order_amount,
            enabled                 : arg0.enabled,
        };
        0x2::event::emit<TypedFeeConfigCreated<T0>>(v0);
    }

    fun emit_config_enabled_set<T0>(arg0: &TypedFeeConfig<T0>, arg1: u64, arg2: bool) {
        let v0 = TypedFeeConfigEnabledSet<T0>{
            config_id               : 0x2::object::id<TypedFeeConfig<T0>>(arg0),
            previous_config_version : arg1,
            config_version          : arg0.config_version,
            network                 : arg0.network,
            asset_type_bytes        : arg0.asset_type_bytes,
            previous_enabled        : arg2,
            enabled                 : arg0.enabled,
        };
        0x2::event::emit<TypedFeeConfigEnabledSet<T0>>(v0);
    }

    fun emit_config_updated<T0>(arg0: &TypedFeeConfig<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = TypedFeeConfigUpdated<T0>{
            config_id                        : 0x2::object::id<TypedFeeConfig<T0>>(arg0),
            previous_config_version          : arg1,
            previous_enabled                 : arg2,
            previous_policy_version          : arg3,
            previous_decimals                : arg4,
            previous_bps                     : arg5,
            previous_min_fee_amount          : arg6,
            previous_max_fee_amount          : arg7,
            previous_min_viable_order_amount : arg8,
            policy_version                   : arg0.policy_version,
            config_version                   : arg0.config_version,
            network                          : arg0.network,
            asset_type_bytes                 : arg0.asset_type_bytes,
            decimals                         : arg0.decimals,
            bps                              : arg0.bps,
            min_fee_amount                   : arg0.min_fee_amount,
            max_fee_amount                   : arg0.max_fee_amount,
            min_viable_order_amount          : arg0.min_viable_order_amount,
            enabled                          : arg0.enabled,
        };
        0x2::event::emit<TypedFeeConfigUpdated<T0>>(v0);
    }

    public fun enabled<T0>(arg0: &TypedFeeConfig<T0>) : bool {
        arg0.enabled
    }

    public(friend) fun enablement_event_requires_state_change() : u8 {
        1
    }

    public(friend) fun entry_initializer_present<T0>() : bool {
        false
    }

    public(friend) fun event_abi_classification<T0>() : u8 {
        if (config_target_supported<T0>()) {
            return 1
        };
        3
    }

    public(friend) fun event_abi_delete_before_publish() : u8 {
        3
    }

    public(friend) fun event_abi_is_publish_final<T0>() : bool {
        false
    }

    public(friend) fun event_abi_publish_candidate() : u8 {
        1
    }

    public(friend) fun event_abi_publish_final() : u8 {
        2
    }

    public(friend) fun events_source_test_audit_skeleton() : u8 {
        1
    }

    public(friend) fun initializer_absent_until_publish_slice() : u8 {
        1
    }

    public(friend) fun live_config_initial_enabled_must_be_disabled() : u8 {
        1
    }

    public(friend) fun live_config_object_seed_path_open<T0>() : bool {
        false
    }

    public(friend) fun live_initializer_may_create_enabled_config<T0>() : bool {
        false
    }

    public fun max_fee_amount<T0>(arg0: &TypedFeeConfig<T0>) : u64 {
        arg0.max_fee_amount
    }

    public fun min_fee_amount<T0>(arg0: &TypedFeeConfig<T0>) : u64 {
        arg0.min_fee_amount
    }

    public fun min_viable_order_amount<T0>(arg0: &TypedFeeConfig<T0>) : u64 {
        arg0.min_viable_order_amount
    }

    public fun minimum_start_config<T0>(arg0: &TypedFeeConfig<T0>) : bool {
        if (config_shape_valid<T0>(arg0)) {
            if (arg0.policy_version == 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::minimum_start_policy_version()) {
                if (arg0.config_version >= 1) {
                    if (arg0.decimals == 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::native_sui_usdc_decimals()) {
                        if (arg0.bps == 0) {
                            if (arg0.min_fee_amount == 0) {
                                if (arg0.max_fee_amount == 0) {
                                    arg0.min_viable_order_amount == 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::min_viable_order_amount_floor()
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun network<T0>(arg0: &TypedFeeConfig<T0>) : u8 {
        arg0.network
    }

    public fun network_for_config_target<T0>() : u8 {
        if (0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::onchain_asset_lane_manager::matches_sui_usdc_testnet_type<T0>()) {
            return 1
        };
        if (0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::onchain_asset_lane_manager::matches_sui_usdc_mainnet_type<T0>()) {
            return 2
        };
        0
    }

    public fun network_mainnet() : u8 {
        2
    }

    public fun network_testnet() : u8 {
        1
    }

    public fun network_unsupported() : u8 {
        0
    }

    public(friend) fun no_publish_yet() : u8 {
        1
    }

    public(friend) fun noop_set_enabled_allowed<T0>() : bool {
        false
    }

    public fun policy_version<T0>(arg0: &TypedFeeConfig<T0>) : u64 {
        arg0.policy_version
    }

    public(friend) fun product_runtime_wiring_open_with_config<T0>(arg0: &TypedFeeConfig<T0>) : bool {
        config_level_ready_for_runtime_candidate<T0>(arg0) && false
    }

    public(friend) fun publish_readiness_abi_boundary_closed<T0>() : bool {
        if (config_target_supported<T0>()) {
            if (no_publish_yet() == 1) {
                if (live_config_initial_enabled_must_be_disabled() == 1) {
                    if (enablement_event_requires_state_change() == 1) {
                        if (!event_abi_is_publish_final<T0>()) {
                            if (config_helper_abi_classification<T0>() == 4) {
                                if (!entry_initializer_present<T0>() || disabled_seed_entry_source_candidate<T0>()) {
                                    if (!live_config_object_seed_path_open<T0>()) {
                                        if (!live_initializer_may_create_enabled_config<T0>()) {
                                            if (!created_event_counts_as_enablement_event<T0>()) {
                                                if (!noop_set_enabled_allowed<T0>()) {
                                                    !store_ability_required_for_current_lifecycle<T0>()
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun seed_entry_absent() : u8 {
        0
    }

    public fun seed_entry_classification<T0>() : u8 {
        if (disabled_seed_entry_source_candidate<T0>()) {
            return 2
        };
        0
    }

    public fun seed_entry_operator_gated_testnet_retained() : u8 {
        1
    }

    public fun seed_entry_retired_after_seed() : u8 {
        2
    }

    public(friend) fun seed_lifecycle_deferred_until_owner_decision() : u8 {
        1
    }

    public(friend) fun seed_model_defer_seed_until_publish_decision() : u8 {
        1
    }

    public fun seed_sui_usdc_testnet_minimum_start_config<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x3b8916cf8bc90fdfcb0a5fd511f35a3d1ddc567817ca9e6164f9dd217077d1fe, 4);
        assert!(disabled_seed_entry_source_candidate<T0>(), 1);
        abort 5
    }

    public(friend) fun set_enabled<T0>(arg0: &TypedFeeAdminCap<T0>, arg1: &mut TypedFeeConfig<T0>, arg2: u64, arg3: bool) {
        assert_supported_config_target<T0>();
        assert!(config_shape_valid<T0>(arg1), 2);
        assert!(arg2 > arg1.config_version, 3);
        assert!(arg3 != arg1.enabled, 2);
        arg1.config_version = arg2;
        arg1.enabled = arg3;
        emit_config_enabled_set<T0>(arg1, arg1.config_version, arg1.enabled);
    }

    public(friend) fun set_enabled_only_enablement_path<T0>() : bool {
        config_target_supported<T0>()
    }

    public(friend) fun store_ability_required_for_current_lifecycle<T0>() : bool {
        false
    }

    fun supported_asset_type_bytes<T0>() : vector<u8> {
        let v0 = 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::onchain_asset_lane_manager::supported_order_typed_non_sui_asset_bytes<T0>();
        assert!(0x1::option::is_some<vector<u8>>(&v0), 1);
        0x1::option::destroy_some<vector<u8>>(v0)
    }

    public fun testnet_usdc_seed_custody() : address {
        @0x3b8916cf8bc90fdfcb0a5fd511f35a3d1ddc567817ca9e6164f9dd217077d1fe
    }

    public fun testnet_usdc_seed_operator() : address {
        @0x3b8916cf8bc90fdfcb0a5fd511f35a3d1ddc567817ca9e6164f9dd217077d1fe
    }

    public fun unauthenticated_update_path_available<T0>() : bool {
        false
    }

    public(friend) fun update_config<T0>(arg0: &TypedFeeAdminCap<T0>, arg1: &mut TypedFeeConfig<T0>, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        assert_supported_config_target<T0>();
        assert_supported_policy_version(arg2);
        assert!(config_shape_valid<T0>(arg1), 2);
        assert!(arg3 > arg1.config_version, 3);
        assert_valid_config_params<T0>(arg2, arg4, arg5, arg6, arg7, arg8);
        arg1.policy_version = arg2;
        arg1.config_version = arg3;
        arg1.decimals = arg4;
        arg1.bps = arg5;
        arg1.min_fee_amount = arg6;
        arg1.max_fee_amount = arg7;
        arg1.min_viable_order_amount = arg8;
        emit_config_updated<T0>(arg1, arg1.config_version, arg1.enabled, arg1.policy_version, arg1.decimals, arg1.bps, arg1.min_fee_amount, arg1.max_fee_amount, arg1.min_viable_order_amount);
    }

    public(friend) fun update_config_enabled_mutation_allowed<T0>() : bool {
        false
    }

    public(friend) fun update_event_previous_enabled_emitted<T0>() : bool {
        config_target_supported<T0>()
    }

    public(friend) fun update_event_previous_fee_fields_emitted<T0>() : bool {
        config_target_supported<T0>()
    }

    // decompiled from Move bytecode v7
}

