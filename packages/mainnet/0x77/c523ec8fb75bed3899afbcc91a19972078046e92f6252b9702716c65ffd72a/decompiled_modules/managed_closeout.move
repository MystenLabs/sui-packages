module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_closeout {
    struct FeeAssessment has copy, drop {
        gross_assets_micros: u128,
        profit_above_high_water_micros: u128,
        lead_fee_pool_micros: u128,
        lead_fee_micros: u128,
        day_fee_micros: u128,
        net_assets_micros: u128,
        previous_high_water_pps: u128,
        new_high_water_pps: u128,
    }

    struct FrozenExitPot<phantom T0> has store, key {
        id: 0x2::object::UID,
        ledger_id: 0x2::object::ID,
        accounting_asset: 0x1::type_name::TypeName,
        exit_pps: u128,
        total_reserved_shares: u128,
        remaining_reserved_shares: u128,
        total_reserved_assets_micros: u128,
        remaining_reserved_assets_micros: u128,
        measured_total_micros: u128,
        active_claims: u64,
        self_settle_deadline_ms: u64,
        funded: bool,
        proceeds: 0x2::balance::Balance<T0>,
    }

    struct FrozenExitClaim has store, key {
        id: 0x2::object::UID,
        ledger_id: 0x2::object::ID,
        accounting_asset: 0x1::type_name::TypeName,
        payout_destination: address,
        position_id: 0x2::object::ID,
        shares: u128,
        share_start: u128,
        share_end: u128,
        reserved_assets_micros: u128,
    }

    struct AdapterReconciled has copy, drop {
        leg_accounting_id: 0x2::object::ID,
        measured_gross_assets_micros: u128,
        previous_deployed_assets_micros: u128,
        derived_profit_above_high_water_micros: u128,
        lead_fee_pool_micros: u128,
        lead_fee_micros: u128,
        day_fee_micros: u128,
        net_assets_micros: u128,
        high_water_pps: u128,
    }

    fun assert_package_frozen_exit_deadline(arg0: u64, arg1: u64) {
        assert!(arg0 <= 18446744073709551615 - 300000, 3);
        assert!(arg1 == arg0 + 300000, 3);
    }

    fun assets_at_exit_pps(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (1000000 as u256)) as u128)
    }

    public(friend) fun crystallize_and_settle_reallocation_exit<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg2: u128, arg3: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_reallocation::ReallocationReturnProceeds<T0>, arg4: &mut 0x2::tx_context::TxContext) : FeeAssessment {
        let (v0, v1) = crystallize_authenticated_reallocation_return<T0>(arg0, arg3, arg4);
        let v2 = v0;
        let v3 = if (arg2 == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_shares(arg0)) {
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_assets_micros(arg0)
        } else {
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::convert_to_assets(arg2, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_assets_micros(arg0), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_shares(arg0))
        };
        assert!(v3 <= (0x2::coin::value<T0>(&v2) as u128), 11);
        assert!(v3 <= 18446744073709551615, 10);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::settle_owner_exit<T0>(arg0, arg1, arg2, 0x2::coin::split<T0>(&mut v2, (v3 as u64), arg4), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::adapter_destination_for_package(arg0));
        v1
    }

    fun crystallize_authenticated_reallocation_return<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_reallocation::ReallocationReturnProceeds<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FeeAssessment) {
        let (v0, _, v2) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_reallocation::consume_return_proceeds<T0>(arg1);
        let v3 = v2;
        assert!(v0 == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg0), 12);
        assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&v3), 9);
        let v4 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(v3);
        let v5 = (0x2::coin::value<T0>(&v4) as u128);
        let v6 = profit_above_fee_basis(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_assets_micros(arg0), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::fee_basis_assets_micros_for_package(arg0));
        let (v7, v8, v9, v10) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::fee_policy_for_package(arg0);
        let v11 = mul_bps_floor(v6, v7);
        let v12 = if (v11 > v5) {
            v5
        } else {
            v11
        };
        let v13 = mul_bps_floor(v12, v8);
        let v14 = v12 - v13;
        assert!(v14 <= 18446744073709551615 && v13 <= 18446744073709551615, 10);
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, (v14 as u64), arg2), v9);
        };
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, (v13 as u64), arg2), v10);
        };
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::apply_fee_crystallization(arg0, v12);
        let v15 = FeeAssessment{
            gross_assets_micros            : v5,
            profit_above_high_water_micros : v6,
            lead_fee_pool_micros           : v12,
            lead_fee_micros                : v14,
            day_fee_micros                 : v13,
            net_assets_micros              : v5 - v12,
            previous_high_water_pps        : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::high_water_pps(arg0),
            new_high_water_pps             : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::high_water_pps(arg0),
        };
        (v4, v15)
    }

    public(friend) fun crystallize_reallocation_fees<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_reallocation::ReallocationReturnProceeds<T0>, arg2: &mut 0x2::tx_context::TxContext) : FeeAssessment {
        let (v0, v1) = crystallize_authenticated_reallocation_return<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::adapter_destination_for_package(arg0));
        v1
    }

    fun div_ceil(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        (arg0 - 1) / arg1 + 1
    }

    public fun fee_day_micros(arg0: &FeeAssessment) : u128 {
        arg0.day_fee_micros
    }

    public fun fee_lead_micros(arg0: &FeeAssessment) : u128 {
        arg0.lead_fee_micros
    }

    public fun fee_lead_pool_micros(arg0: &FeeAssessment) : u128 {
        arg0.lead_fee_pool_micros
    }

    public fun fee_net_micros(arg0: &FeeAssessment) : u128 {
        arg0.net_assets_micros
    }

    public fun fee_profit_micros(arg0: &FeeAssessment) : u128 {
        arg0.profit_above_high_water_micros
    }

    fun initialize_claim_payouts<T0>(arg0: &mut FrozenExitPot<T0>, arg1: u128) {
        arg0.exit_pps = (((arg1 as u256) * (1000000 as u256) / (arg0.total_reserved_shares as u256)) as u128);
        arg0.measured_total_micros = arg1;
    }

    fun interval_payout(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        (((arg1 as u256) * (arg3 as u256) / (arg2 as u256)) as u128) - (((arg0 as u256) * (arg3 as u256) / (arg2 as u256)) as u128)
    }

    fun mul_bps_floor(arg0: u128, arg1: u64) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (10000 as u256)) as u128)
    }

    fun new_frozen_exit_pot<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : FrozenExitPot<T0> {
        assert!(arg2 > arg3, 3);
        assert!(arg1 == 0x1::type_name::with_original_ids<T0>(), 8);
        FrozenExitPot<T0>{
            id                               : 0x2::object::new(arg4),
            ledger_id                        : arg0,
            accounting_asset                 : arg1,
            exit_pps                         : 0,
            total_reserved_shares            : 0,
            remaining_reserved_shares        : 0,
            total_reserved_assets_micros     : 0,
            remaining_reserved_assets_micros : 0,
            measured_total_micros            : 0,
            active_claims                    : 0,
            self_settle_deadline_ms          : arg2,
            funded                           : false,
            proceeds                         : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun prepare_frozen_exit_pot<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : FrozenExitPot<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert_package_frozen_exit_deadline(v0, arg1);
        new_frozen_exit_pot<T0>(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg0), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg0), arg1, v0, arg3)
    }

    fun price_per_share_ceil(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 1000000
        };
        (div_ceil(((arg0 as u256) + (1000 as u256)) * (1000000 as u256), (arg1 as u256) + (1000 as u256)) as u128)
    }

    fun price_per_share_floor(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 1000000
        };
        ((((arg0 as u256) + (1000 as u256)) * (1000000 as u256) / ((arg1 as u256) + (1000 as u256))) as u128)
    }

    fun profit_above_fee_basis(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun reconcile_full_adapter_return<T0, T1>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::AdapterReturnReceipt<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T1>>, FeeAssessment) {
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::consume_adapter_full_return<T0, T1>(arg0, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg0), arg1);
        reconcile_measured_return<T1>(arg0, v0, arg2)
    }

    fun reconcile_measured_return<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, FeeAssessment) {
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg0) == 0x1::type_name::with_original_ids<T0>(), 8);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::deployed_assets_micros(arg0);
        assert!(v0 > 0, 9);
        let v1 = if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1)) {
            (0x2::coin::value<T0>(0x1::option::borrow<0x2::coin::Coin<T0>>(&arg1)) as u128)
        } else {
            0
        };
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::high_water_pps(arg0);
        let v3 = profit_above_fee_basis(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::liquid_assets_micros(arg0) + v1, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::fee_basis_assets_micros_for_package(arg0));
        let (v4, v5, v6, v7) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::fee_policy_for_package(arg0);
        let v8 = mul_bps_floor(v3, v4);
        let v9 = if (v8 > v1) {
            v1
        } else {
            v8
        };
        let v10 = mul_bps_floor(v9, v5);
        let v11 = v9 - v10;
        assert!(v11 <= 18446744073709551615 && v10 <= 18446744073709551615, 10);
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1), (v11 as u64), arg2), v6);
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1), (v10 as u64), arg2), v7);
        };
        let v12 = v1 - v9;
        let v13 = price_per_share_ceil(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::liquid_assets_micros(arg0) + v12, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_shares(arg0));
        let v14 = if (v13 > v2) {
            v13
        } else {
            v2
        };
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::apply_full_reconciliation(arg0, v12, v14);
        let v15 = FeeAssessment{
            gross_assets_micros            : v1,
            profit_above_high_water_micros : v3,
            lead_fee_pool_micros           : v9,
            lead_fee_micros                : v11,
            day_fee_micros                 : v10,
            net_assets_micros              : v12,
            previous_high_water_pps        : v2,
            new_high_water_pps             : v14,
        };
        let v16 = AdapterReconciled{
            leg_accounting_id                      : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg0),
            measured_gross_assets_micros           : v1,
            previous_deployed_assets_micros        : v0,
            derived_profit_above_high_water_micros : v3,
            lead_fee_pool_micros                   : v9,
            lead_fee_micros                        : v11,
            day_fee_micros                         : v10,
            net_assets_micros                      : v12,
            high_water_pps                         : v14,
        };
        0x2::event::emit<AdapterReconciled>(v16);
        (arg1, v15)
    }

    public(friend) fun reserve_and_fund_frozen_exit_pot<T0, T1>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: FrozenExitPot<T1>, arg2: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg3: u128, arg4: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::AdapterCloseoutReturnReceipt<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert!(arg1.ledger_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg0), 12);
        assert!(arg1.accounting_asset == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_asset(arg0), 8);
        assert!(!arg1.funded && arg1.active_claims == 0, 13);
        let (v0, v1, v2) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::consume_adapter_closeout_return<T0, T1>(arg0, 0x2::object::id<FrozenExitPot<T1>>(&arg1), 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position>(arg2), arg3, arg4);
        let v3 = v2;
        let v4 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::reserve_deployed_exit_for_closeout<T1>(arg0, arg2, arg3, arg5);
        assert!(v0 == v4, 12);
        let v5 = if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            (0x2::coin::value<T1>(0x1::option::borrow<0x2::coin::Coin<T1>>(&v3)) as u128)
        } else {
            0
        };
        let v6 = if (v5 > v1) {
            v5 - v1
        } else {
            0
        };
        let (v7, v8, v9, v10) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::fee_policy_for_package(arg0);
        let v11 = mul_bps_floor(v6, v7);
        let v12 = mul_bps_floor(v11, v8);
        let v13 = v11 - v12;
        assert!(v5 >= v11, 11);
        assert!(v13 <= 18446744073709551615 && v12 <= 18446744073709551615, 10);
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(0x1::option::borrow_mut<0x2::coin::Coin<T1>>(&mut v3), (v13 as u64), arg5), v9);
        };
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(0x1::option::borrow_mut<0x2::coin::Coin<T1>>(&mut v3), (v12 as u64), arg5), v10);
        };
        let v14 = v5 - v11;
        let v15 = FrozenExitClaim{
            id                     : 0x2::object::new(arg5),
            ledger_id              : arg1.ledger_id,
            accounting_asset       : arg1.accounting_asset,
            payout_destination     : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::recorded_payout_destination(arg2),
            position_id            : 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position>(arg2),
            shares                 : arg3,
            share_start            : 0,
            share_end              : arg3,
            reserved_assets_micros : v4,
        };
        let v16 = 0x2::object::id<FrozenExitClaim>(&v15);
        0x2::dynamic_object_field::add<0x2::object::ID, FrozenExitClaim>(&mut arg1.id, v16, v15);
        arg1.total_reserved_shares = arg3;
        arg1.remaining_reserved_shares = arg3;
        arg1.total_reserved_assets_micros = v4;
        arg1.remaining_reserved_assets_micros = v4;
        arg1.measured_total_micros = v14;
        let v17 = if (arg3 == 0) {
            0
        } else {
            (((v14 as u256) * (1000000 as u256) / (arg3 as u256)) as u128)
        };
        arg1.exit_pps = v17;
        arg1.active_claims = 1;
        arg1.funded = true;
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            0x2::balance::join<T1>(&mut arg1.proceeds, 0x2::coin::into_balance<T1>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v3)));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
        };
        0x2::transfer::share_object<FrozenExitPot<T1>>(arg1);
        (0x2::object::id<FrozenExitPot<T1>>(&arg1), v16)
    }

    public fun settle_frozen_exit_claim<T0>(arg0: &mut FrozenExitPot<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u128 {
        assert!(arg0.funded, 15);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.self_settle_deadline_ms, 7);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 14);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, FrozenExitClaim>(&mut arg0.id, arg1);
        assert!(v0.ledger_id == arg0.ledger_id, 12);
        assert!(v0.accounting_asset == arg0.accounting_asset, 8);
        let v1 = interval_payout(v0.share_start, v0.share_end, arg0.total_reserved_shares, arg0.measured_total_micros);
        assert!(v1 <= 18446744073709551615, 10);
        assert!(v1 <= (0x2::balance::value<T0>(&arg0.proceeds) as u128), 11);
        arg0.remaining_reserved_shares = arg0.remaining_reserved_shares - v0.shares;
        arg0.remaining_reserved_assets_micros = arg0.remaining_reserved_assets_micros - v0.reserved_assets_micros;
        arg0.active_claims = arg0.active_claims - 1;
        let FrozenExitClaim {
            id                     : v2,
            ledger_id              : _,
            accounting_asset       : _,
            payout_destination     : v5,
            position_id            : _,
            shares                 : _,
            share_start            : _,
            share_end              : _,
            reserved_assets_micros : _,
        } = v0;
        0x2::object::delete(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.proceeds, (v1 as u64), arg3), v5);
        v1
    }

    // decompiled from Move bytecode v7
}

