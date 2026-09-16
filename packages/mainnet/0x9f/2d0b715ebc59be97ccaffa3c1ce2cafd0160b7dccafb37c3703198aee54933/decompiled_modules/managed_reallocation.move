module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_reallocation {
    struct ReallocationReservation<phantom T0> {
        state_id: 0x2::object::ID,
        source_accounting_id: 0x2::object::ID,
        destination_accounting_id: 0x2::object::ID,
        source_opportunity_id: vector<u8>,
        destination_opportunity_id: vector<u8>,
        strategy_id: vector<u8>,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        canonical_route: vector<u8>,
        route_commitment: vector<u8>,
        source_native_asset_binding: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding,
        destination_native_asset_binding: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding,
        allocation_bps: u64,
    }

    struct ReallocationState<phantom T0> has key {
        id: 0x2::object::UID,
        source_accounting_id: 0x2::object::ID,
        destination_accounting_id: 0x2::object::ID,
        source_opportunity_id: vector<u8>,
        destination_opportunity_id: vector<u8>,
        accounting_asset: 0x1::type_name::TypeName,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        route_commitment: vector<u8>,
        frozen_basis_micros: u128,
        remaining_basis_micros: u128,
        destination_deployed_micros: u128,
        measured_return_micros: u128,
        destination_reconciled_micros: u128,
        realized_gain_micros: u128,
        realized_loss_micros: u128,
        closed: bool,
        destination_return_closed: bool,
    }

    struct ReallocationReturnProceeds<phantom T0> {
        source_accounting_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        proceeds: 0x1::option::Option<0x2::coin::Coin<T0>>,
    }

    fun apply_destination_return<T0>(arg0: &mut ReallocationState<T0>, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: u128, arg3: u128) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::apply_measured_spoke_return(arg1, arg2, arg3);
        arg0.destination_deployed_micros = arg0.destination_deployed_micros - arg2;
        arg0.destination_reconciled_micros = arg0.destination_reconciled_micros + arg3;
        if (arg3 > arg2) {
            arg0.realized_gain_micros = arg0.realized_gain_micros + arg3 - arg2;
        } else if (arg2 > arg3) {
            arg0.realized_loss_micros = arg0.realized_loss_micros + arg2 - arg3;
        };
    }

    fun apply_measured<T0>(arg0: &mut ReallocationState<T0>, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::apply_measured_reallocation(arg1, arg3, arg4);
        arg0.destination_deployed_micros = arg0.destination_deployed_micros + arg4;
        arg0.remaining_basis_micros = arg0.remaining_basis_micros - arg3;
        arg0.measured_return_micros = arg0.measured_return_micros + arg4;
        if (arg4 > arg3) {
            arg0.realized_gain_micros = arg0.realized_gain_micros + arg4 - arg3;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::adapter_destination_for_package(arg2));
    }

    fun assert_bound<T0>(arg0: &ReallocationState<T0>, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting) {
        assert!(!arg0.closed, 5);
        assert!(arg0.source_accounting_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg1), 2);
        assert!(arg0.destination_accounting_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg2), 2);
        assert!(arg0.source_opportunity_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg1), 2);
        assert!(arg0.destination_opportunity_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg2), 2);
        assert!(arg0.accounting_asset == 0x1::type_name::with_original_ids<T0>(), 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg1) == arg0.accounting_asset, 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg2) == arg0.accounting_asset, 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_assets_micros(arg2) == 0, 2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_shares(arg2) == 0, 2);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_id(arg1);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_id(arg2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 4);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 4);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == arg0.guardrails_id, 4);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == arg0.guardrails_id, 4);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_hash(arg1);
        let v3 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_hash(arg2);
        assert!(0x1::option::is_some<vector<u8>>(&v2), 4);
        assert!(0x1::option::is_some<vector<u8>>(&v3), 4);
        assert!(*0x1::option::borrow<vector<u8>>(&v2) == arg0.guardrails_hash, 4);
        assert!(*0x1::option::borrow<vector<u8>>(&v3) == arg0.guardrails_hash, 4);
        assert!(0x1::vector::length<u8>(&arg0.route_commitment) == 32, 1);
    }

    fun assert_destination_return_bound<T0>(arg0: &ReallocationState<T0>, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting) {
        assert!(arg0.closed, 7);
        assert!(!arg0.destination_return_closed, 5);
        assert!(arg0.destination_deployed_micros > 0, 5);
        assert!(arg0.source_accounting_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg1), 2);
        assert!(arg0.destination_accounting_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg2), 2);
        assert!(arg0.source_opportunity_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg1), 2);
        assert!(arg0.destination_opportunity_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg2), 2);
        assert!(arg0.accounting_asset == 0x1::type_name::with_original_ids<T0>(), 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg1) == arg0.accounting_asset, 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg2) == arg0.accounting_asset, 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_assets_micros(arg2) == 0, 2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_shares(arg2) == 0, 2);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_id(arg1);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_id(arg2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 4);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 4);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == arg0.guardrails_id, 4);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == arg0.guardrails_id, 4);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_hash(arg1);
        let v3 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_hash(arg2);
        assert!(0x1::option::is_some<vector<u8>>(&v2), 4);
        assert!(0x1::option::is_some<vector<u8>>(&v3), 4);
        assert!(*0x1::option::borrow<vector<u8>>(&v2) == arg0.guardrails_hash, 4);
        assert!(*0x1::option::borrow<vector<u8>>(&v3) == arg0.guardrails_hash, 4);
        assert!(0x1::vector::length<u8>(&arg0.route_commitment) == 32, 1);
    }

    public fun closed<T0>(arg0: &ReallocationState<T0>) : bool {
        arg0.closed
    }

    public(friend) fun consume_reallocation_reservation<T0>(arg0: ReallocationReservation<T0>) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, vector<u8>, vector<u8>, vector<u8>, 0x2::object::ID, vector<u8>, vector<u8>, vector<u8>, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, u64) {
        let ReallocationReservation {
            state_id                         : v0,
            source_accounting_id             : v1,
            destination_accounting_id        : v2,
            source_opportunity_id            : v3,
            destination_opportunity_id       : v4,
            strategy_id                      : v5,
            guardrails_id                    : v6,
            guardrails_hash                  : v7,
            canonical_route                  : v8,
            route_commitment                 : v9,
            source_native_asset_binding      : v10,
            destination_native_asset_binding : v11,
            allocation_bps                   : v12,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    public(friend) fun consume_return_proceeds<T0>(arg0: ReallocationReturnProceeds<T0>) : (0x2::object::ID, 0x2::object::ID, 0x1::option::Option<0x2::coin::Coin<T0>>) {
        let ReallocationReturnProceeds {
            source_accounting_id : v0,
            state_id             : v1,
            proceeds             : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun destination_deployed_micros<T0>(arg0: &ReallocationState<T0>) : u128 {
        arg0.destination_deployed_micros
    }

    public fun destination_reconciled_micros<T0>(arg0: &ReallocationState<T0>) : u128 {
        arg0.destination_reconciled_micros
    }

    public fun destination_return_closed<T0>(arg0: &ReallocationState<T0>) : bool {
        arg0.destination_return_closed
    }

    public(friend) fun finalize_destination_return<T0, T1>(arg0: &mut ReallocationState<T1>, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg3: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::AdapterReturnReceipt<T0, T1>) : ReallocationReturnProceeds<T1> {
        assert_destination_return_bound<T1>(arg0, arg1, arg2);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::consume_adapter_full_return<T0, T1>(arg2, 0x2::object::id<ReallocationState<T1>>(arg0), arg3);
        let v1 = if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v0)) {
            (0x2::coin::value<T1>(0x1::option::borrow<0x2::coin::Coin<T1>>(&v0)) as u128)
        } else {
            0
        };
        let v2 = arg0.destination_deployed_micros;
        apply_destination_return<T1>(arg0, arg1, v2, v1);
        arg0.destination_return_closed = true;
        ReallocationReturnProceeds<T1>{
            source_accounting_id : arg0.source_accounting_id,
            state_id             : 0x2::object::id<ReallocationState<T1>>(arg0),
            proceeds             : v0,
        }
    }

    public(friend) fun finalize_reallocation<T0, T1>(arg0: &mut ReallocationState<T1>, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg3: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::AdapterReturnReceipt<T0, T1>) {
        assert_bound<T1>(arg0, arg1, arg2);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::consume_adapter_full_return<T0, T1>(arg1, 0x2::object::id<ReallocationState<T1>>(arg0), arg3);
        let v1 = if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v0)) {
            (0x2::coin::value<T1>(0x1::option::borrow<0x2::coin::Coin<T1>>(&v0)) as u128)
        } else {
            0
        };
        let v2 = arg0.remaining_basis_micros;
        let v3 = if (v2 > v1) {
            v2 - v1
        } else {
            0
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v0)) {
            apply_measured<T1>(arg0, arg1, arg2, v2, v1, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(v0));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v0);
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::apply_measured_reallocation(arg1, v2, 0);
            arg0.remaining_basis_micros = 0;
        };
        arg0.realized_loss_micros = arg0.realized_loss_micros + v3;
        arg0.closed = true;
    }

    public fun realized_gain_micros<T0>(arg0: &ReallocationState<T0>) : u128 {
        arg0.realized_gain_micros
    }

    public fun realized_loss_micros<T0>(arg0: &ReallocationState<T0>) : u128 {
        arg0.realized_loss_micros
    }

    public fun remaining_basis_micros<T0>(arg0: &ReallocationState<T0>) : u128 {
        arg0.remaining_basis_micros
    }

    public fun route_commitment<T0>(arg0: &ReallocationState<T0>) : vector<u8> {
        arg0.route_commitment
    }

    public(friend) fun settle_destination_return_chunk<T0, T1>(arg0: &mut ReallocationState<T1>, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg3: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::AdapterReturnReceipt<T0, T1>) {
        abort 7
    }

    public(friend) fun settle_reallocation_chunk<T0, T1>(arg0: &mut ReallocationState<T1>, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg3: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::AdapterReturnReceipt<T0, T1>) {
        assert_bound<T1>(arg0, arg1, arg2);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::consume_adapter_full_return<T0, T1>(arg1, 0x2::object::id<ReallocationState<T1>>(arg0), arg3);
        assert!(0x1::option::is_some<0x2::coin::Coin<T1>>(&v0), 6);
        let v1 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(v0);
        let v2 = (0x2::coin::value<T1>(&v1) as u128);
        assert!(v2 > 0, 6);
        let v3 = if (v2 < arg0.remaining_basis_micros) {
            v2
        } else {
            arg0.remaining_basis_micros
        };
        apply_measured<T1>(arg0, arg1, arg2, v3, v2, v1);
        assert!(arg0.remaining_basis_micros > 0, 7);
    }

    public(friend) fun start_reallocation<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : ReallocationReservation<T0> {
        assert!(!0x1::vector::is_empty<u8>(&arg2), 1);
        let v0 = 0x1::hash::sha2_256(arg2);
        assert!(0x1::vector::length<u8>(&v0) == 32, 1);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg0);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg1);
        assert!(v1 != v2, 2);
        let v3 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg0);
        let v4 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg1);
        assert!(v3 != v4, 2);
        let v5 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg0) == v5, 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg1) == v5, 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_assets_micros(arg1) == 0, 2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_shares(arg1) == 0, 2);
        let v6 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_id(arg0);
        let v7 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_id(arg1);
        let v8 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_strategy_id(arg0);
        let v9 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_strategy_id(arg1);
        assert!(0x1::option::is_some<vector<u8>>(&v8), 4);
        assert!(0x1::option::is_some<vector<u8>>(&v9), 4);
        let v10 = *0x1::option::borrow<vector<u8>>(&v8);
        assert!(v10 == *0x1::option::borrow<vector<u8>>(&v9), 4);
        assert!(0x1::option::is_some<0x2::object::ID>(&v6), 4);
        assert!(0x1::option::is_some<0x2::object::ID>(&v7), 4);
        let v11 = *0x1::option::borrow<0x2::object::ID>(&v6);
        assert!(v11 == *0x1::option::borrow<0x2::object::ID>(&v7), 4);
        let v12 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_hash(arg0);
        let v13 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_guardrails_hash(arg1);
        assert!(0x1::option::is_some<vector<u8>>(&v12), 4);
        assert!(0x1::option::is_some<vector<u8>>(&v13), 4);
        let v14 = *0x1::option::borrow<vector<u8>>(&v12);
        assert!(v14 == *0x1::option::borrow<vector<u8>>(&v13), 4);
        let v15 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::begin_measured_reallocation(arg0, arg3);
        let v16 = ReallocationState<T0>{
            id                            : 0x2::object::new(arg4),
            source_accounting_id          : v1,
            destination_accounting_id     : v2,
            source_opportunity_id         : v3,
            destination_opportunity_id    : v4,
            accounting_asset              : v5,
            guardrails_id                 : v11,
            guardrails_hash               : v14,
            route_commitment              : v0,
            frozen_basis_micros           : v15,
            remaining_basis_micros        : v15,
            destination_deployed_micros   : 0,
            measured_return_micros        : 0,
            destination_reconciled_micros : 0,
            realized_gain_micros          : 0,
            realized_loss_micros          : 0,
            closed                        : false,
            destination_return_closed     : false,
        };
        0x2::transfer::share_object<ReallocationState<T0>>(v16);
        ReallocationReservation<T0>{
            state_id                         : 0x2::object::id<ReallocationState<T0>>(&v16),
            source_accounting_id             : v1,
            destination_accounting_id        : v2,
            source_opportunity_id            : v3,
            destination_opportunity_id       : v4,
            strategy_id                      : v10,
            guardrails_id                    : v11,
            guardrails_hash                  : v14,
            canonical_route                  : arg2,
            route_commitment                 : v0,
            source_native_asset_binding      : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_native_asset_binding(arg0),
            destination_native_asset_binding : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_native_asset_binding(arg1),
            allocation_bps                   : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

