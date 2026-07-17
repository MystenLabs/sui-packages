module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position {
    struct OpportunityAccounting has key {
        id: 0x2::object::UID,
        opportunity_id: vector<u8>,
        spoke_chain: vector<u8>,
        accounting_asset: 0x1::type_name::TypeName,
        native_asset_binding: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding,
        strategy_id: 0x1::option::Option<vector<u8>>,
        protocol_config_id: 0x1::option::Option<0x2::object::ID>,
        registry_admin_cap_id: 0x1::option::Option<0x2::object::ID>,
        strategy_registry_id: 0x1::option::Option<0x2::object::ID>,
        guardrails_id: 0x1::option::Option<0x2::object::ID>,
        guardrails_hash: 0x1::option::Option<vector<u8>>,
        adapter_registry_id: 0x2::object::ID,
        adapter_id: vector<u8>,
        adapter_source: 0x1::type_name::TypeName,
        adapter_nonce: u64,
        liquid_assets_micros: u128,
        deployed_assets_micros: u128,
        in_transit_assets_micros: u128,
        total_assets_micros: u128,
        total_shares: u128,
        fee_basis_assets_micros: u128,
        high_water_pps: u128,
        lead_fee_bps: u64,
        day_share_bps: u64,
        lead_fee_destination: address,
        day_fee_destination: address,
        adapter_destination: address,
    }

    struct Position has key {
        id: 0x2::object::UID,
        leg_accounting_id: 0x2::object::ID,
        opportunity_id: vector<u8>,
        entry_route_legs: vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>,
        depositor: address,
        payout_destination: address,
        origin_chain: vector<u8>,
        origin_asset: 0x1::type_name::TypeName,
        strategy_id: 0x1::option::Option<vector<u8>>,
        guardrails_id: 0x1::option::Option<0x2::object::ID>,
        leader_may_force_exit: bool,
        force_exit_policy_id: 0x1::option::Option<0x2::object::ID>,
        shares: u128,
    }

    struct OwnerPayout<phantom T0> {
        position_id: 0x2::object::ID,
        leg_accounting_id: 0x2::object::ID,
        destination: address,
        origin_chain: vector<u8>,
        origin_asset: 0x1::type_name::TypeName,
        shares_burned: u128,
        assets_micros: u128,
    }

    struct LiquidExitProceeds<phantom T0> {
        proceeds: 0x2::coin::Coin<T0>,
    }

    struct DeployedExitProceeds<phantom T0> {
        proceeds: 0x2::coin::Coin<T0>,
    }

    struct AdapterDeploymentReceipt<phantom T0, phantom T1> {
        accounting_id: 0x2::object::ID,
        adapter_source: 0x1::type_name::TypeName,
        nonce: u64,
        in_flight: 0x2::coin::Coin<T1>,
    }

    struct AdapterReturnReceipt<phantom T0, phantom T1> {
        accounting_id: 0x2::object::ID,
        purpose_id: 0x2::object::ID,
        adapter_source: 0x1::type_name::TypeName,
        nonce: u64,
        proceeds: 0x1::option::Option<0x2::coin::Coin<T1>>,
    }

    struct AdapterCloseoutReturnReceipt<phantom T0, phantom T1> {
        accounting_id: 0x2::object::ID,
        purpose_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        shares: u128,
        reserved_assets_micros: u128,
        reserved_fee_basis_micros: u128,
        adapter_source: 0x1::type_name::TypeName,
        nonce: u64,
        proceeds: 0x1::option::Option<0x2::coin::Coin<T1>>,
    }

    struct PositionOpened has copy, drop {
        position_id: 0x2::object::ID,
        leg_accounting_id: 0x2::object::ID,
        opportunity_id: vector<u8>,
        entry_route_legs: vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>,
        depositor: address,
        payout_destination: address,
        origin_chain: vector<u8>,
        origin_asset: 0x1::type_name::TypeName,
        strategy_id: 0x1::option::Option<vector<u8>>,
        guardrails_id: 0x1::option::Option<0x2::object::ID>,
        leader_may_force_exit: bool,
        force_exit_policy_id: 0x1::option::Option<0x2::object::ID>,
        assets_micros: u128,
        shares_minted: u128,
    }

    struct OwnerExitRecorded has copy, drop {
        position_id: 0x2::object::ID,
        leg_accounting_id: 0x2::object::ID,
        payout_destination: address,
        origin_chain: vector<u8>,
        origin_asset: 0x1::type_name::TypeName,
        shares_burned: u128,
        assets_micros: u128,
    }

    struct AccountingCreated has copy, drop {
        accounting_id: 0x2::object::ID,
        strategy_registry_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        opportunity_id: vector<u8>,
        guardrails_id: 0x2::object::ID,
        adapter_registry_id: 0x2::object::ID,
        adapter_id: vector<u8>,
        adapter_source: 0x1::type_name::TypeName,
    }

    public fun leader_may_force_exit(arg0: &Position) : bool {
        arg0.leader_may_force_exit
    }

    public fun accounting_asset(arg0: &OpportunityAccounting) : 0x1::type_name::TypeName {
        arg0.accounting_asset
    }

    public fun accounting_guardrails_hash(arg0: &OpportunityAccounting) : 0x1::option::Option<vector<u8>> {
        arg0.guardrails_hash
    }

    public fun accounting_guardrails_id(arg0: &OpportunityAccounting) : 0x1::option::Option<0x2::object::ID> {
        arg0.guardrails_id
    }

    public fun accounting_id(arg0: &OpportunityAccounting) : 0x2::object::ID {
        0x2::object::id<OpportunityAccounting>(arg0)
    }

    public(friend) fun accounting_native_asset_binding(arg0: &OpportunityAccounting) : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding {
        arg0.native_asset_binding
    }

    public fun accounting_opportunity_id(arg0: &OpportunityAccounting) : vector<u8> {
        arg0.opportunity_id
    }

    public fun accounting_strategy_id(arg0: &OpportunityAccounting) : 0x1::option::Option<vector<u8>> {
        arg0.strategy_id
    }

    public fun accounting_strategy_registry_id(arg0: &OpportunityAccounting) : 0x1::option::Option<0x2::object::ID> {
        arg0.strategy_registry_id
    }

    public(friend) fun adapter_destination_for_package(arg0: &OpportunityAccounting) : address {
        arg0.adapter_destination
    }

    public(friend) fun apply_fee_crystallization(arg0: &mut OpportunityAccounting, arg1: u128) {
        assert!(arg0.liquid_assets_micros >= arg1, 21);
        assert!(arg0.total_assets_micros >= arg1, 10);
        arg0.liquid_assets_micros = arg0.liquid_assets_micros - arg1;
        arg0.total_assets_micros = arg0.total_assets_micros - arg1;
        if (arg0.total_assets_micros > arg0.fee_basis_assets_micros) {
            arg0.fee_basis_assets_micros = arg0.total_assets_micros;
        };
        arg0.high_water_pps = price_per_share_ceil_from_totals(arg0.fee_basis_assets_micros, arg0.total_shares);
        assert_accounting_invariant(arg0);
    }

    public(friend) fun apply_full_reconciliation(arg0: &mut OpportunityAccounting, arg1: u128, arg2: u128) {
        assert!(arg0.in_transit_assets_micros == 0, 26);
        arg0.deployed_assets_micros = 0;
        arg0.liquid_assets_micros = arg0.liquid_assets_micros + arg1;
        arg0.total_assets_micros = arg0.liquid_assets_micros;
        if (arg0.total_assets_micros > arg0.fee_basis_assets_micros) {
            arg0.fee_basis_assets_micros = arg0.total_assets_micros;
        };
        arg0.high_water_pps = arg2;
        assert_accounting_invariant(arg0);
    }

    public(friend) fun apply_measured_reallocation(arg0: &mut OpportunityAccounting, arg1: u128, arg2: u128) {
        assert!(arg0.in_transit_assets_micros >= arg1, 10);
        arg0.in_transit_assets_micros = arg0.in_transit_assets_micros - arg1;
        arg0.deployed_assets_micros = arg0.deployed_assets_micros + arg2;
        arg0.total_assets_micros = arg0.total_assets_micros - arg1 + arg2;
        assert_accounting_invariant(arg0);
    }

    public(friend) fun apply_measured_spoke_return(arg0: &mut OpportunityAccounting, arg1: u128, arg2: u128) {
        assert!(arg0.deployed_assets_micros >= arg1, 10);
        arg0.deployed_assets_micros = arg0.deployed_assets_micros - arg1;
        arg0.liquid_assets_micros = arg0.liquid_assets_micros + arg2;
        arg0.total_assets_micros = arg0.total_assets_micros - arg1 + arg2;
        assert_accounting_invariant(arg0);
    }

    fun assert_accounting_invariant(arg0: &OpportunityAccounting) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg0.native_asset_binding);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg0.native_asset_binding) == arg0.spoke_chain, 6);
        assert!(arg0.total_assets_micros == arg0.liquid_assets_micros + arg0.deployed_assets_micros + arg0.in_transit_assets_micros, 19);
    }

    fun assert_adapter_receipt<T0, T1>(arg0: &OpportunityAccounting, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64) {
        assert_adapter_source<T0, T1>(arg0);
        assert!(arg1 == 0x2::object::id<OpportunityAccounting>(arg0), 5);
        assert!(arg2 == arg0.adapter_source, 28);
        assert!(arg3 == arg0.adapter_nonce, 29);
    }

    fun assert_adapter_source<T0, T1>(arg0: &OpportunityAccounting) {
        assert_nonprimitive_adapter_witness<T0>();
        assert!(arg0.accounting_asset == 0x1::type_name::with_original_ids<T1>(), 6);
        assert!(arg0.adapter_source == 0x1::type_name::with_original_ids<T0>(), 28);
    }

    fun assert_canonical_accounting_authority(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_strategy_registry_id(arg0);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_strategy_registry_admin_cap_id(arg0);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_adapter_registry_v2_id(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 27);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 27);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry>(arg1), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap>(arg2), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg3), 27);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::governance(arg1) == 0x2::tx_context::sender(arg4), 27);
    }

    fun assert_canonical_managed_binding<T0>(arg0: &OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2) : vector<u8> {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.protocol_config_id), 7);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.registry_admin_cap_id), 7);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.strategy_registry_id), 7);
        assert!(0x1::option::is_some<vector<u8>>(&arg0.strategy_id), 7);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.guardrails_id), 7);
        assert!(0x1::option::is_some<vector<u8>>(&arg0.guardrails_hash), 7);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.protocol_config_id) == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg1), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.strategy_registry_id) == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry>(arg2), 27);
        assert!(arg0.adapter_registry_id == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg4), 27);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_strategy_registry_id(arg1);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_strategy_registry_admin_cap_id(arg1);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_adapter_registry_v2_id(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 27);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 27);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry>(arg2), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == *0x1::option::borrow<0x2::object::ID>(&arg0.registry_admin_cap_id), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg4), 27);
        let v3 = *0x1::option::borrow<vector<u8>>(&arg0.strategy_id);
        let v4 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::record(arg2, v3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::guardrails_id(v4) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg3), 7);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::guardrails_hash(v4) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg3), 7);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.guardrails_id) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg3), 7);
        assert!(*0x1::option::borrow<vector<u8>>(&arg0.guardrails_hash) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg3), 7);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg3), 7);
        assert!(arg0.accounting_asset == 0x1::type_name::with_original_ids<T0>(), 6);
        v3
    }

    fun assert_current_managed_authority<T0>(arg0: &OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg5: u64) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::assert_accepts_new_deposit(arg2, assert_canonical_managed_binding<T0>(arg0, arg1, arg2, arg3, arg4));
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2_on_chain(arg4, arg0.adapter_id, arg0.spoke_chain);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_allocation_allowed<T0>(arg3, arg0.opportunity_id, arg0.spoke_chain, arg5);
    }

    fun assert_nonprimitive_adapter_witness<T0>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 30);
    }

    fun assert_plain_accounting(arg0: &OpportunityAccounting) {
        assert!(!0x1::option::is_some<vector<u8>>(&arg0.strategy_id), 7);
        assert!(!0x1::option::is_some<0x2::object::ID>(&arg0.strategy_registry_id), 7);
    }

    fun assert_policy_binding(arg0: &0x1::option::Option<vector<u8>>, arg1: &0x1::option::Option<0x2::object::ID>) {
        if (!0x1::option::is_some<vector<u8>>(arg0)) {
            assert!(!0x1::option::is_some<0x2::object::ID>(arg1), 24);
            return
        };
        assert!(!0x1::vector::is_empty<u8>(0x1::option::borrow<vector<u8>>(arg0)), 23);
    }

    public(friend) fun attest_adapter_closeout_return<T0: drop, T1>(arg0: &OpportunityAccounting, arg1: &T0, arg2: &Position, arg3: u128, arg4: 0x2::object::ID, arg5: 0x1::option::Option<0x2::coin::Coin<T1>>, arg6: &0x2::tx_context::TxContext) : AdapterCloseoutReturnReceipt<T0, T1> {
        assert!(0x2::tx_context::sender(arg6) == arg2.depositor, 3);
        attest_adapter_closeout_return_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    fun attest_adapter_closeout_return_internal<T0, T1>(arg0: &OpportunityAccounting, arg1: &Position, arg2: u128, arg3: 0x2::object::ID, arg4: 0x1::option::Option<0x2::coin::Coin<T1>>) : AdapterCloseoutReturnReceipt<T0, T1> {
        assert_adapter_source<T0, T1>(arg0);
        let v0 = if (arg2 == arg0.total_shares) {
            arg0.fee_basis_assets_micros
        } else {
            convert_to_assets(arg2, arg0.fee_basis_assets_micros, arg0.total_shares)
        };
        AdapterCloseoutReturnReceipt<T0, T1>{
            accounting_id             : 0x2::object::id<OpportunityAccounting>(arg0),
            purpose_id                : arg3,
            position_id               : 0x2::object::id<Position>(arg1),
            shares                    : arg2,
            reserved_assets_micros    : preview_deployed_exit_basis<T1>(arg0, arg1, arg2),
            reserved_fee_basis_micros : v0,
            adapter_source            : 0x1::type_name::with_original_ids<T0>(),
            nonce                     : arg0.adapter_nonce,
            proceeds                  : arg4,
        }
    }

    public(friend) fun attest_adapter_deployment<T0: drop, T1>(arg0: &OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg5: &T0, arg6: u64, arg7: 0x2::coin::Coin<T1>) : AdapterDeploymentReceipt<T0, T1> {
        assert_current_managed_authority<T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        attest_adapter_deployment_internal<T0, T1>(arg0, arg7)
    }

    fun attest_adapter_deployment_internal<T0, T1>(arg0: &OpportunityAccounting, arg1: 0x2::coin::Coin<T1>) : AdapterDeploymentReceipt<T0, T1> {
        assert_adapter_source<T0, T1>(arg0);
        let v0 = (0x2::coin::value<T1>(&arg1) as u128);
        assert!(v0 > 0, 1);
        assert!(arg0.liquid_assets_micros >= v0, 21);
        AdapterDeploymentReceipt<T0, T1>{
            accounting_id  : 0x2::object::id<OpportunityAccounting>(arg0),
            adapter_source : 0x1::type_name::with_original_ids<T0>(),
            nonce          : arg0.adapter_nonce,
            in_flight      : arg1,
        }
    }

    public(friend) fun attest_adapter_return<T0: drop, T1>(arg0: &OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg5: &T0, arg6: 0x2::object::ID, arg7: 0x1::option::Option<0x2::coin::Coin<T1>>) : AdapterReturnReceipt<T0, T1> {
        assert_canonical_managed_binding<T1>(arg0, arg1, arg2, arg3, arg4);
        attest_adapter_return_internal<T0, T1>(arg0, arg6, arg7)
    }

    fun attest_adapter_return_internal<T0, T1>(arg0: &OpportunityAccounting, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>) : AdapterReturnReceipt<T0, T1> {
        assert_adapter_source<T0, T1>(arg0);
        AdapterReturnReceipt<T0, T1>{
            accounting_id  : 0x2::object::id<OpportunityAccounting>(arg0),
            purpose_id     : arg1,
            adapter_source : 0x1::type_name::with_original_ids<T0>(),
            nonce          : arg0.adapter_nonce,
            proceeds       : arg2,
        }
    }

    fun authorize_owner_exit<T0>(arg0: &mut OpportunityAccounting, arg1: &mut Position, arg2: u128, arg3: u128, arg4: u128, arg5: &0x2::tx_context::TxContext) : OwnerPayout<T0> {
        assert!(0x2::tx_context::sender(arg5) == arg1.depositor, 3);
        assert!(0x2::object::id<OpportunityAccounting>(arg0) == arg1.leg_accounting_id, 5);
        assert!(0x1::type_name::with_original_ids<T0>() == arg1.origin_asset, 6);
        assert!(arg2 > 0, 2);
        assert!(arg1.shares >= arg2, 4);
        assert!(arg0.total_shares >= arg2, 16);
        let v0 = if (arg2 == arg0.total_shares) {
            arg0.total_assets_micros
        } else {
            convert_to_assets(arg2, arg0.total_assets_micros, arg0.total_shares)
        };
        assert!(v0 > 0, 1);
        assert!(arg0.total_assets_micros >= v0, 10);
        assert!(arg3 + arg4 == v0, 17);
        assert!(arg0.liquid_assets_micros >= arg3, 21);
        assert!(arg0.deployed_assets_micros >= arg4, 22);
        let v1 = arg0.total_shares;
        arg1.shares = arg1.shares - arg2;
        arg0.total_shares = arg0.total_shares - arg2;
        reduce_fee_basis_for_burn(arg0, arg2, v1);
        arg0.liquid_assets_micros = arg0.liquid_assets_micros - arg3;
        arg0.deployed_assets_micros = arg0.deployed_assets_micros - arg4;
        arg0.total_assets_micros = arg0.total_assets_micros - v0;
        assert_accounting_invariant(arg0);
        let v2 = arg1.payout_destination;
        let v3 = OwnerExitRecorded{
            position_id        : 0x2::object::id<Position>(arg1),
            leg_accounting_id  : arg1.leg_accounting_id,
            payout_destination : v2,
            origin_chain       : arg1.origin_chain,
            origin_asset       : arg1.origin_asset,
            shares_burned      : arg2,
            assets_micros      : v0,
        };
        0x2::event::emit<OwnerExitRecorded>(v3);
        OwnerPayout<T0>{
            position_id       : 0x2::object::id<Position>(arg1),
            leg_accounting_id : arg1.leg_accounting_id,
            destination       : v2,
            origin_chain      : arg1.origin_chain,
            origin_asset      : arg1.origin_asset,
            shares_burned     : arg2,
            assets_micros     : v0,
        }
    }

    public(friend) fun begin_measured_reallocation(arg0: &mut OpportunityAccounting, arg1: u64) : u128 {
        assert!(arg1 > 0 && arg1 <= 10000, 20);
        let v0 = (((arg0.deployed_assets_micros as u256) * (arg1 as u256) / (10000 as u256)) as u128);
        assert!(v0 > 0, 1);
        arg0.deployed_assets_micros = arg0.deployed_assets_micros - v0;
        arg0.in_transit_assets_micros = arg0.in_transit_assets_micros + v0;
        assert_accounting_invariant(arg0);
        v0
    }

    public(friend) fun consume_adapter_closeout_return<T0, T1>(arg0: &mut OpportunityAccounting, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u128, arg4: AdapterCloseoutReturnReceipt<T0, T1>) : (u128, u128, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        let AdapterCloseoutReturnReceipt {
            accounting_id             : v0,
            purpose_id                : v1,
            position_id               : v2,
            shares                    : v3,
            reserved_assets_micros    : v4,
            reserved_fee_basis_micros : v5,
            adapter_source            : v6,
            nonce                     : v7,
            proceeds                  : v8,
        } = arg4;
        assert_adapter_receipt<T0, T1>(arg0, v0, v6, v7);
        assert!(v1 == arg1, 5);
        assert!(v2 == arg2, 5);
        assert!(v3 == arg3, 17);
        arg0.adapter_nonce = arg0.adapter_nonce + 1;
        (v4, v5, v8)
    }

    public(friend) fun consume_adapter_full_return<T0, T1>(arg0: &mut OpportunityAccounting, arg1: 0x2::object::ID, arg2: AdapterReturnReceipt<T0, T1>) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        let AdapterReturnReceipt {
            accounting_id  : v0,
            purpose_id     : v1,
            adapter_source : v2,
            nonce          : v3,
            proceeds       : v4,
        } = arg2;
        assert_adapter_receipt<T0, T1>(arg0, v0, v2, v3);
        assert!(v1 == arg1, 5);
        arg0.adapter_nonce = arg0.adapter_nonce + 1;
        v4
    }

    public fun convert_to_assets(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_math::to_assets(arg0, arg1, arg2)
    }

    public fun convert_to_shares(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_math::to_shares(arg0, arg1, arg2)
    }

    public fun create_managed_accounting<T0: drop, T1>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: address, arg13: address, arg14: address, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_managed_accounting_with_binding<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, resolve_managed_native_asset_binding<T1>(arg4, arg7, arg8), arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    fun create_managed_accounting_with_binding<T0: drop, T1>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: address, arg13: address, arg14: address, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_canonical_accounting_authority(arg0, arg1, arg2, arg3, arg15);
        assert_nonprimitive_adapter_witness<T0>();
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::assert_accepts_new_deposit(arg1, arg5);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2_on_chain(arg3, arg9, arg7);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::record(arg1, arg5);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::guardrails_id(v0);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::guardrails_hash(v0);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg4), 7);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg4) == v1, 7);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg4) == v2, 7);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_allocation_allowed<T1>(arg4, arg6, arg7, 1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_allocation_allowed(arg4, &arg8, arg6, 1);
        let v3 = new_accounting<T1>(arg6, arg7, 0x1::option::some<vector<u8>>(arg5), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap>(arg2)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry>(arg1)), 0x1::option::some<0x2::object::ID>(v1), 0x1::option::some<vector<u8>>(v2), arg8, 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg3), arg9, 0x1::type_name::with_original_ids<T0>(), arg10, arg11, arg12, arg13, arg14, arg15);
        let v4 = 0x2::object::id<OpportunityAccounting>(&v3);
        let v5 = AccountingCreated{
            accounting_id        : v4,
            strategy_registry_id : 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry>(arg1),
            strategy_id          : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::strategy_id(v0),
            opportunity_id       : v3.opportunity_id,
            guardrails_id        : v1,
            adapter_registry_id  : 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg3),
            adapter_id           : v3.adapter_id,
            adapter_source       : 0x1::type_name::with_original_ids<T0>(),
        };
        0x2::event::emit<AccountingCreated>(v5);
        0x2::transfer::share_object<OpportunityAccounting>(v3);
        v4
    }

    public(friend) fun credit_remaining_leg_dust(arg0: &mut OpportunityAccounting, arg1: u128) {
        arg0.deployed_assets_micros = arg0.deployed_assets_micros + arg1;
        arg0.total_assets_micros = arg0.total_assets_micros + arg1;
        assert_accounting_invariant(arg0);
    }

    public fun deployed_assets_micros(arg0: &OpportunityAccounting) : u128 {
        arg0.deployed_assets_micros
    }

    public fun entry_route_legs(arg0: &Position) : vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding> {
        arg0.entry_route_legs
    }

    public(friend) fun fee_basis_assets_micros_for_package(arg0: &OpportunityAccounting) : u128 {
        arg0.fee_basis_assets_micros
    }

    public(friend) fun fee_policy_for_package(arg0: &OpportunityAccounting) : (u64, u64, address, address) {
        (arg0.lead_fee_bps, arg0.day_share_bps, arg0.lead_fee_destination, arg0.day_fee_destination)
    }

    public fun force_exit_policy_id(arg0: &Position) : 0x1::option::Option<0x2::object::ID> {
        arg0.force_exit_policy_id
    }

    public fun guardrails_id(arg0: &Position) : 0x1::option::Option<0x2::object::ID> {
        arg0.guardrails_id
    }

    public fun high_water_pps(arg0: &OpportunityAccounting) : u128 {
        arg0.high_water_pps
    }

    public fun in_transit_assets_micros(arg0: &OpportunityAccounting) : u128 {
        arg0.in_transit_assets_micros
    }

    public fun leg_accounting_id(arg0: &Position) : 0x2::object::ID {
        arg0.leg_accounting_id
    }

    public fun liquid_assets_micros(arg0: &OpportunityAccounting) : u128 {
        arg0.liquid_assets_micros
    }

    public fun matches_force_exit_policy(arg0: &Position, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : bool {
        if (arg0.leader_may_force_exit) {
            if (matches_managed_policy(arg0, arg1, arg2)) {
                if (0x1::option::is_some<0x2::object::ID>(&arg0.force_exit_policy_id)) {
                    *0x1::option::borrow<0x2::object::ID>(&arg0.force_exit_policy_id) == arg3
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

    public fun matches_managed_policy(arg0: &Position, arg1: vector<u8>, arg2: 0x2::object::ID) : bool {
        if (!0x1::option::is_some<vector<u8>>(&arg0.strategy_id)) {
            return false
        };
        if (!0x1::option::is_some<0x2::object::ID>(&arg0.guardrails_id)) {
            return false
        };
        *0x1::option::borrow<vector<u8>>(&arg0.strategy_id) == arg1 && *0x1::option::borrow<0x2::object::ID>(&arg0.guardrails_id) == arg2
    }

    fun new_accounting<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::option::Option<vector<u8>>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::option::Option<vector<u8>>, arg8: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg9: 0x2::object::ID, arg10: vector<u8>, arg11: 0x1::type_name::TypeName, arg12: u64, arg13: u64, arg14: address, arg15: address, arg16: address, arg17: &mut 0x2::tx_context::TxContext) : OpportunityAccounting {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 8);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 9);
        assert!(!0x1::vector::is_empty<u8>(&arg10), 28);
        assert!(arg16 != @0x0, 20);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg8);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg8) == arg1, 6);
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            assert!(!0x1::vector::is_empty<u8>(0x1::option::borrow<vector<u8>>(&arg2)), 23);
            assert!(arg12 <= 10000 && arg13 <= 10000, 20);
            assert!(arg14 != @0x0 && arg15 != @0x0, 20);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg6), 7);
            assert!(0x1::option::is_some<vector<u8>>(&arg7), 7);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg5), 7);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg3), 7);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg4), 7);
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg7)) == 32, 7);
        } else {
            assert!(arg12 == 0 && arg13 == 0, 20);
            assert!(arg14 == @0x0 && arg15 == @0x0, 20);
            assert!(!0x1::option::is_some<0x2::object::ID>(&arg6), 7);
            assert!(!0x1::option::is_some<vector<u8>>(&arg7), 7);
            assert!(!0x1::option::is_some<0x2::object::ID>(&arg5), 7);
            assert!(!0x1::option::is_some<0x2::object::ID>(&arg3), 7);
            assert!(!0x1::option::is_some<0x2::object::ID>(&arg4), 7);
        };
        OpportunityAccounting{
            id                       : 0x2::object::new(arg17),
            opportunity_id           : arg0,
            spoke_chain              : arg1,
            accounting_asset         : 0x1::type_name::with_original_ids<T0>(),
            native_asset_binding     : arg8,
            strategy_id              : arg2,
            protocol_config_id       : arg3,
            registry_admin_cap_id    : arg4,
            strategy_registry_id     : arg5,
            guardrails_id            : arg6,
            guardrails_hash          : arg7,
            adapter_registry_id      : arg9,
            adapter_id               : arg10,
            adapter_source           : arg11,
            adapter_nonce            : 0,
            liquid_assets_micros     : 0,
            deployed_assets_micros   : 0,
            in_transit_assets_micros : 0,
            total_assets_micros      : 0,
            total_shares             : 0,
            fee_basis_assets_micros  : 0,
            high_water_pps           : 1000000,
            lead_fee_bps             : arg12,
            day_share_bps            : arg13,
            lead_fee_destination     : arg14,
            day_fee_destination      : arg15,
            adapter_destination      : arg16,
        }
    }

    public fun position_shares(arg0: &Position) : u128 {
        arg0.shares
    }

    public fun position_value_micros(arg0: &OpportunityAccounting, arg1: &Position) : u128 {
        assert!(0x2::object::id<OpportunityAccounting>(arg0) == arg1.leg_accounting_id, 5);
        if (arg1.shares == 0) {
            return 0
        };
        convert_to_assets(arg1.shares, arg0.total_assets_micros, arg0.total_shares)
    }

    fun preview_deployed_exit_basis<T0>(arg0: &OpportunityAccounting, arg1: &Position, arg2: u128) : u128 {
        assert!(0x2::object::id<OpportunityAccounting>(arg0) == arg1.leg_accounting_id, 5);
        assert!(0x1::type_name::with_original_ids<T0>() == arg1.origin_asset, 6);
        assert!(arg2 > 0, 2);
        assert!(arg1.shares >= arg2, 4);
        assert!(arg0.total_shares >= arg2, 16);
        let v0 = convert_to_assets(arg2, arg0.total_assets_micros, arg0.total_shares);
        assert!(arg0.deployed_assets_micros >= v0, 22);
        v0
    }

    fun price_per_share_ceil_from_totals(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 1000000
        };
        let v0 = (arg1 as u256) + 1000;
        (((((arg0 as u256) + 1000) * (1000000 as u256) + v0 - 1) / v0) as u128)
    }

    fun price_per_share_from_totals(arg0: u128, arg1: u128) : u128 {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_math::price_per_share(arg0, arg1)
    }

    public fun price_per_share_micros(arg0: &OpportunityAccounting) : u128 {
        price_per_share_from_totals(arg0.total_assets_micros, arg0.total_shares)
    }

    fun record_and_transfer_local_deposit<T0>(arg0: &mut OpportunityAccounting, arg1: vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = record_local_deposit_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<Position>(v0, 0x2::tx_context::sender(arg4));
        0x2::object::id<Position>(&v0)
    }

    public(friend) fun record_local_deposit<T0>(arg0: &mut OpportunityAccounting, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::Coin<T0>) {
        assert_plain_accounting(arg0);
        let v0 = 0x1::vector::empty<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>();
        0x1::vector::push_back<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>(&mut v0, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::deposit_leg<T0>(0x2::object::id<OpportunityAccounting>(arg0), arg0.opportunity_id));
        (record_and_transfer_local_deposit<T0>(arg0, v0, 0x1::option::none<0x2::object::ID>(), (0x2::coin::value<T0>(&arg1) as u128), arg2), arg1)
    }

    fun record_local_deposit_internal<T0>(arg0: &mut OpportunityAccounting, arg1: vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : Position {
        assert!(arg3 > 0, 1);
        assert!(arg0.accounting_asset == 0x1::type_name::with_original_ids<T0>(), 6);
        assert_policy_binding(&arg0.strategy_id, &arg2);
        if (0x1::option::is_some<vector<u8>>(&arg0.strategy_id) && arg0.lead_fee_bps > 0) {
            assert!(arg0.total_assets_micros == arg0.fee_basis_assets_micros, 31);
        };
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::assert_bound_to_accounting<T0>(&arg1, 0x2::object::id<OpportunityAccounting>(arg0), arg0.accounting_asset, arg0.opportunity_id);
        let v0 = convert_to_shares(arg3, arg0.total_assets_micros, arg0.total_shares);
        assert!(v0 > 0, 2);
        arg0.liquid_assets_micros = arg0.liquid_assets_micros + arg3;
        arg0.total_assets_micros = arg0.total_assets_micros + arg3;
        arg0.total_shares = arg0.total_shares + v0;
        arg0.fee_basis_assets_micros = arg0.fee_basis_assets_micros + arg3;
        arg0.high_water_pps = price_per_share_ceil_from_totals(arg0.fee_basis_assets_micros, arg0.total_shares);
        assert_accounting_invariant(arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Position{
            id                    : 0x2::object::new(arg4),
            leg_accounting_id     : 0x2::object::id<OpportunityAccounting>(arg0),
            opportunity_id        : arg0.opportunity_id,
            entry_route_legs      : arg1,
            depositor             : v1,
            payout_destination    : v1,
            origin_chain          : arg0.spoke_chain,
            origin_asset          : arg0.accounting_asset,
            strategy_id           : arg0.strategy_id,
            guardrails_id         : arg0.guardrails_id,
            leader_may_force_exit : 0x1::option::is_some<0x2::object::ID>(&arg2),
            force_exit_policy_id  : arg2,
            shares                : v0,
        };
        let v3 = PositionOpened{
            position_id           : 0x2::object::id<Position>(&v2),
            leg_accounting_id     : v2.leg_accounting_id,
            opportunity_id        : v2.opportunity_id,
            entry_route_legs      : v2.entry_route_legs,
            depositor             : v2.depositor,
            payout_destination    : v2.payout_destination,
            origin_chain          : v2.origin_chain,
            origin_asset          : v2.origin_asset,
            strategy_id           : v2.strategy_id,
            guardrails_id         : v2.guardrails_id,
            leader_may_force_exit : v2.leader_may_force_exit,
            force_exit_policy_id  : v2.force_exit_policy_id,
            assets_micros         : arg3,
            shares_minted         : v0,
        };
        0x2::event::emit<PositionOpened>(v3);
        v2
    }

    public(friend) fun record_local_deposit_with_verified_route<T0>(arg0: &mut OpportunityAccounting, arg1: vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::Coin<T0>) {
        assert_plain_accounting(arg0);
        (record_and_transfer_local_deposit<T0>(arg0, arg1, 0x1::option::none<0x2::object::ID>(), (0x2::coin::value<T0>(&arg2) as u128), arg3), arg2)
    }

    public(friend) fun record_managed_local_deposit<T0>(arg0: &mut OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::Coin<T0>) {
        assert_current_managed_authority<T0>(arg0, arg1, arg2, arg3, arg4, arg6);
        let v0 = validated_force_exit_policy_id(arg0, arg5);
        let v1 = 0x1::vector::empty<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>();
        0x1::vector::push_back<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>(&mut v1, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::deposit_leg<T0>(0x2::object::id<OpportunityAccounting>(arg0), arg0.opportunity_id));
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::assert_managed_entry_route_allowed<T0>(&v1, arg3, arg6, 0x2::object::id<OpportunityAccounting>(arg0), arg0.accounting_asset, arg0.opportunity_id);
        (record_and_transfer_local_deposit<T0>(arg0, v1, v0, (0x2::coin::value<T0>(&arg7) as u128), arg8), arg7)
    }

    public(friend) fun record_managed_local_deposit_with_verified_route<T0>(arg0: &mut OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy, arg6: vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding>, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::Coin<T0>) {
        assert_current_managed_authority<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v0 = validated_force_exit_policy_id(arg0, arg5);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::assert_managed_entry_route_allowed<T0>(&arg6, arg3, arg7, 0x2::object::id<OpportunityAccounting>(arg0), arg0.accounting_asset, arg0.opportunity_id);
        (record_and_transfer_local_deposit<T0>(arg0, arg6, v0, (0x2::coin::value<T0>(&arg8) as u128), arg9), arg8)
    }

    public(friend) fun record_measured_deployment<T0, T1>(arg0: &mut OpportunityAccounting, arg1: AdapterDeploymentReceipt<T0, T1>) : 0x2::coin::Coin<T1> {
        let AdapterDeploymentReceipt {
            accounting_id  : v0,
            adapter_source : v1,
            nonce          : v2,
            in_flight      : v3,
        } = arg1;
        let v4 = v3;
        assert_adapter_receipt<T0, T1>(arg0, v0, v1, v2);
        let v5 = (0x2::coin::value<T1>(&v4) as u128);
        assert!(v5 > 0, 1);
        assert!(arg0.liquid_assets_micros >= v5, 21);
        arg0.liquid_assets_micros = arg0.liquid_assets_micros - v5;
        arg0.deployed_assets_micros = arg0.deployed_assets_micros + v5;
        arg0.adapter_nonce = arg0.adapter_nonce + 1;
        assert_accounting_invariant(arg0);
        v4
    }

    public fun recorded_payout_destination(arg0: &Position) : address {
        arg0.payout_destination
    }

    fun reduce_fee_basis_for_burn(arg0: &mut OpportunityAccounting, arg1: u128, arg2: u128) {
        let v0 = if (arg1 == arg2) {
            arg0.fee_basis_assets_micros
        } else {
            convert_to_assets(arg1, arg0.fee_basis_assets_micros, arg2)
        };
        arg0.fee_basis_assets_micros = arg0.fee_basis_assets_micros - v0;
        arg0.high_water_pps = price_per_share_ceil_from_totals(arg0.fee_basis_assets_micros, arg0.total_shares);
    }

    public(friend) fun reserve_deployed_exit_for_closeout<T0>(arg0: &mut OpportunityAccounting, arg1: &mut Position, arg2: u128, arg3: &0x2::tx_context::TxContext) : u128 {
        assert!(0x2::tx_context::sender(arg3) == arg1.depositor, 3);
        let v0 = preview_deployed_exit_basis<T0>(arg0, arg1, arg2);
        let v1 = arg0.total_shares;
        arg1.shares = arg1.shares - arg2;
        arg0.total_shares = arg0.total_shares - arg2;
        reduce_fee_basis_for_burn(arg0, arg2, v1);
        arg0.deployed_assets_micros = arg0.deployed_assets_micros - v0;
        arg0.total_assets_micros = arg0.total_assets_micros - v0;
        assert_accounting_invariant(arg0);
        v0
    }

    fun resolve_managed_native_asset_binding<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg1: vector<u8>, arg2: vector<u8>) : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding {
        if (arg1 == b"sui") {
            assert!(0x1::vector::is_empty<u8>(&arg2), 6);
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::sui_asset_binding<T0>()
        } else {
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_binding_from_policy(arg0, arg1, arg2)
        }
    }

    public fun route_leg_destination_chain(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding) : vector<u8> {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::destination_chain(arg0)
    }

    public fun route_leg_source_chain(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding) : vector<u8> {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::source_chain(arg0)
    }

    public fun route_leg_target_opportunity(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::RouteLegBinding) : 0x1::option::Option<vector<u8>> {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::target_opportunity(arg0)
    }

    public(friend) fun settle_owner_exit<T0>(arg0: &mut OpportunityAccounting, arg1: &mut Position, arg2: u128, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let OwnerPayout {
            position_id       : _,
            leg_accounting_id : _,
            destination       : v2,
            origin_chain      : _,
            origin_asset      : _,
            shares_burned     : _,
            assets_micros     : _,
        } = authorize_owner_exit<T0>(arg0, arg1, arg2, (0x2::coin::value<T0>(&arg3) as u128), 0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v2);
    }

    public fun strategy_id(arg0: &Position) : 0x1::option::Option<vector<u8>> {
        arg0.strategy_id
    }

    public fun total_assets_micros(arg0: &OpportunityAccounting) : u128 {
        arg0.total_assets_micros
    }

    public fun total_shares(arg0: &OpportunityAccounting) : u128 {
        arg0.total_shares
    }

    fun validated_force_exit_policy_id(arg0: &OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy) : 0x1::option::Option<0x2::object::ID> {
        assert!(0x1::option::is_some<vector<u8>>(&arg0.strategy_id), 7);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.strategy_registry_id), 7);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.strategy_registry_id) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::policy_registry_id(arg1), 7);
        assert!(*0x1::option::borrow<vector<u8>>(&arg0.strategy_id) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::policy_strategy_id(arg1), 23);
        if (0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::leader_may_force_exit(arg1)) {
            0x1::option::some<0x2::object::ID>(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::policy_id(arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun validated_reallocation_route_for_accountings(arg0: &OpportunityAccounting, arg1: &OpportunityAccounting, arg2: &vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::ReallocationRouteLeg>, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: u64) : (vector<u8>, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::validated_accounting_reallocation_route_canonical_v1(arg2, arg3, arg4, 0x2::object::id<OpportunityAccounting>(arg0), arg0.opportunity_id, &arg0.native_asset_binding, 0x2::object::id<OpportunityAccounting>(arg1), arg1.opportunity_id, &arg1.native_asset_binding)
    }

    // decompiled from Move bytecode v7
}

