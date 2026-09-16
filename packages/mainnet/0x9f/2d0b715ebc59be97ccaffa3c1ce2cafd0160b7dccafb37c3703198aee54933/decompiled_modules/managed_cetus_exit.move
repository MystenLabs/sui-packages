module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_cetus_exit {
    struct CetusTop30Adapter has drop {
        dummy_field: bool,
    }

    struct ManagedCetusClaim<phantom T0, T1: store + key> has key {
        id: 0x2::object::UID,
        accounting_id: 0x2::object::ID,
        day_position_id: 0x2::object::ID,
        day_position_shares: u128,
        opportunity_id: vector<u8>,
        strategy_id: vector<u8>,
        pool_id: 0x2::object::ID,
        cost_basis_micros: u128,
        adapter_nonce: u64,
        tick_lower: u32,
        tick_upper: u32,
        measured_liquidity: u128,
        cetus_position_id: 0x2::object::ID,
        residual: T1,
    }

    struct ManagedCetusClaimCreated has copy, drop {
        claim_id: 0x2::object::ID,
        accounting_id: 0x2::object::ID,
        day_position_id: 0x2::object::ID,
        day_position_shares: u128,
        pool_id: 0x2::object::ID,
        cetus_position_id: 0x2::object::ID,
        cost_basis_micros: u128,
        adapter_nonce: u64,
        measured_liquidity: u128,
        owner: address,
    }

    struct OwnerInKindExitRecorded has copy, drop {
        accounting_id: 0x2::object::ID,
        day_position_id: 0x2::object::ID,
        claim_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        cetus_position_id: 0x2::object::ID,
        cost_basis_micros: u128,
        primary_type: 0x1::type_name::TypeName,
        primary_amount: u64,
        secondary_type: 0x1::type_name::TypeName,
        secondary_amount: u64,
        residual_type: 0x1::type_name::TypeName,
        payout_destination: address,
        residual_nft_transferred: bool,
        residual_may_hold_rewards_or_principal: bool,
        emergency: bool,
        deployment_adapter_nonce: u64,
        terminal_adapter_nonce: u64,
    }

    fun assert_claim<T0, T1: store + key>(arg0: &ManagedCetusClaim<T0, T1>, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position) {
        assert!(arg0.accounting_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg1), 8);
        assert!(arg0.day_position_id == 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position>(arg2), 9);
        assert!(arg0.day_position_shares == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::position_shares(arg2), 9);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::leg_accounting_id(arg2) == arg0.accounting_id, 8);
        assert!(arg0.opportunity_id == b"dayope3465f1716", 6);
        assert!(arg0.strategy_id == b"day-autopilot-top-30d-monthly", 7);
        assert!(arg0.pool_id == 0x2::object::id_from_address(@0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab), 1);
        assert!(arg0.cetus_position_id == 0x2::object::id<T1>(&arg0.residual), 13);
        assert!(arg0.tick_lower == 72070 && arg0.tick_upper == 72570, 3);
    }

    fun assert_config(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg0) == 0x2::object::id_from_address(@0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f), 14);
    }

    fun assert_pool<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg0) == 0x2::object::id_from_address(@0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab), 1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, 0x2::sui::SUI>(arg0) == 500, 2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, 0x2::sui::SUI>(arg0) == 10, 3);
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, 0x2::sui::SUI>(arg0), 4);
    }

    fun assert_usdc<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", 5);
    }

    fun bind_claim_internal<T0, T1: store + key>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: u32, arg5: u32, arg6: u128, arg7: 0x2::object::ID, arg8: T1, arg9: &mut 0x2::tx_context::TxContext) : ManagedCetusClaim<T0, T1> {
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg0) == b"dayope3465f1716", 6);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_strategy_id(arg0) == 0x1::option::some<vector<u8>>(b"day-autopilot-top-30d-monthly"), 7);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::deployed_assets_micros(arg0) >= arg3, 8);
        let v0 = ManagedCetusClaim<T0, T1>{
            id                  : 0x2::object::new(arg9),
            accounting_id       : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg0),
            day_position_id     : arg1,
            day_position_shares : arg2,
            opportunity_id      : b"dayope3465f1716",
            strategy_id         : b"day-autopilot-top-30d-monthly",
            pool_id             : 0x2::object::id_from_address(@0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab),
            cost_basis_micros   : arg3,
            adapter_nonce       : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::adapter_nonce_for_package(arg0),
            tick_lower          : arg4,
            tick_upper          : arg5,
            measured_liquidity  : arg6,
            cetus_position_id   : arg7,
            residual            : arg8,
        };
        let v1 = ManagedCetusClaimCreated{
            claim_id            : 0x2::object::id<ManagedCetusClaim<T0, T1>>(&v0),
            accounting_id       : v0.accounting_id,
            day_position_id     : arg1,
            day_position_shares : arg2,
            pool_id             : v0.pool_id,
            cetus_position_id   : arg7,
            cost_basis_micros   : arg3,
            adapter_nonce       : v0.adapter_nonce,
            measured_liquidity  : arg6,
            owner               : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<ManagedCetusClaimCreated>(v1);
        v0
    }

    public fun create_top30_accounting<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_usdc<T0>();
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::create_managed_accounting<CetusTop30Adapter, T0>(arg0, arg1, arg2, arg3, arg4, b"day-autopilot-top-30d-monthly", b"dayope3465f1716", b"sui", b"", b"cetus-usdc-sui-5bps", 0, 0, @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, arg5)
    }

    public fun deposit_top30_usdc<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: u64, arg10: 0x2::coin::Coin<T0>, arg11: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert_usdc<T0>();
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::assert_exact_adapter_binding<CetusTop30Adapter, T0>(arg0, b"cetus-usdc-sui-5bps");
        assert_config(arg6);
        assert_pool<T0>(arg7);
        let v0 = 0x2::coin::value<T0>(&arg10);
        let (v1, v2) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::record_managed_local_deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg10, arg11);
        let v3 = CetusTop30Adapter{dummy_field: false};
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, 0x2::sui::SUI>(arg6, arg7, 72070, 72570, arg11);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, 0x2::sui::SUI>(arg6, arg7, &mut v4, v0, true, arg8);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, 0x2::sui::SUI>(&v5);
        assert!(v6 == v0 && v7 == 0, 10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, 0x2::sui::SUI>(arg6, arg7, 0x2::coin::into_balance<T0>(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::record_measured_deployment<CetusTop30Adapter, T0>(arg0, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::attest_adapter_deployment<CetusTop30Adapter, T0>(arg0, arg1, arg2, arg3, arg4, &v3, arg9, v2))), 0x2::balance::zero<0x2::sui::SUI>(), v5);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        assert!(v8 > 0, 11);
        let v9 = bind_claim_internal<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, v1, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_shares(arg0) - 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::total_shares(arg0), (v0 as u128), 72070, 72570, v8, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4), v4, arg11);
        0x2::transfer::transfer<ManagedCetusClaim<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v9, 0x2::tx_context::sender(arg11));
        (v1, 0x2::object::id<ManagedCetusClaim<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&v9))
    }

    public fun emergency_exit<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg2: ManagedCetusClaim<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_claim<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2, arg0, arg1);
        let ManagedCetusClaim {
            id                  : v0,
            accounting_id       : _,
            day_position_id     : _,
            day_position_shares : _,
            opportunity_id      : _,
            strategy_id         : _,
            pool_id             : _,
            cost_basis_micros   : v7,
            adapter_nonce       : v8,
            tick_lower          : _,
            tick_upper          : _,
            measured_liquidity  : _,
            cetus_position_id   : v12,
            residual            : v13,
        } = arg2;
        let v14 = v0;
        0x2::object::delete(v14);
        settle_residual_only<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, 0x2::object::uid_to_inner(&v14), v12, v7, v8, v13, arg3);
    }

    public fun normal_full_exit<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg2: ManagedCetusClaim<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_config(arg3);
        assert_pool<T0>(arg4);
        assert_claim<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2, arg0, arg1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2.residual) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2.residual) == arg2.measured_liquidity, 13);
        let ManagedCetusClaim {
            id                  : v0,
            accounting_id       : _,
            day_position_id     : _,
            day_position_shares : _,
            opportunity_id      : _,
            strategy_id         : _,
            pool_id             : _,
            cost_basis_micros   : v7,
            adapter_nonce       : v8,
            tick_lower          : _,
            tick_upper          : _,
            measured_liquidity  : v11,
            cetus_position_id   : v12,
            residual            : v13,
        } = arg2;
        let v14 = v13;
        let v15 = v0;
        let (v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg3, arg4, &mut v14, v11, arg5);
        let v18 = v17;
        let v19 = v16;
        let (v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, 0x2::sui::SUI>(arg3, arg4, &v14, false);
        0x2::balance::join<T0>(&mut v19, v20);
        0x2::balance::join<0x2::sui::SUI>(&mut v18, v21);
        assert!(0x2::balance::value<T0>(&v19) >= arg6 && 0x2::balance::value<0x2::sui::SUI>(&v18) >= arg7, 12);
        0x2::object::delete(v15);
        settle_with_assets<T0, 0x2::sui::SUI, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, 0x2::object::uid_to_inner(&v15), v12, v7, v8, 0x2::coin::from_balance<T0>(v19, arg8), 0x2::coin::from_balance<0x2::sui::SUI>(v18, arg8), v14, true, false, arg8);
    }

    public fun register_top30_adapter(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::RegistryAdminCap, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::register_authenticated(arg0, arg1, b"cetus-usdc-sui-5bps", b"sui", b"DAY top-30d Cetus USDC/SUI 5bps");
    }

    fun settle_residual_only<T0, T1: store + key>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u128, arg5: u64, arg6: T1, arg7: &0x2::tx_context::TxContext) {
        let v0 = CetusTop30Adapter{dummy_field: false};
        let (v1, v2, v3, _, v5, v6) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::consume_in_kind_owner_payout<T0>(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::authorize_full_owner_in_kind_exit<CetusTop30Adapter, T0>(arg0, arg1, &v0, arg4, arg7));
        let v7 = OwnerInKindExitRecorded{
            accounting_id                          : v2,
            day_position_id                        : v1,
            claim_id                               : arg2,
            pool_id                                : 0x2::object::id_from_address(@0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab),
            cetus_position_id                      : arg3,
            cost_basis_micros                      : v5,
            primary_type                           : 0x1::type_name::with_original_ids<T0>(),
            primary_amount                         : 0,
            secondary_type                         : 0x1::type_name::with_original_ids<0x2::sui::SUI>(),
            secondary_amount                       : 0,
            residual_type                          : 0x1::type_name::with_original_ids<T1>(),
            payout_destination                     : v3,
            residual_nft_transferred               : true,
            residual_may_hold_rewards_or_principal : true,
            emergency                              : true,
            deployment_adapter_nonce               : arg5,
            terminal_adapter_nonce                 : v6,
        };
        0x2::event::emit<OwnerInKindExitRecorded>(v7);
        0x2::transfer::public_transfer<T1>(arg6, v3);
    }

    fun settle_with_assets<T0, T1, T2: store + key>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u128, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: T2, arg9: bool, arg10: bool, arg11: &0x2::tx_context::TxContext) {
        let v0 = CetusTop30Adapter{dummy_field: false};
        let (v1, v2, v3, _, v5, v6) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::consume_in_kind_owner_payout<T0>(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::authorize_full_owner_in_kind_exit<CetusTop30Adapter, T0>(arg0, arg1, &v0, arg4, arg11));
        let v7 = OwnerInKindExitRecorded{
            accounting_id                          : v2,
            day_position_id                        : v1,
            claim_id                               : arg2,
            pool_id                                : 0x2::object::id_from_address(@0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab),
            cetus_position_id                      : arg3,
            cost_basis_micros                      : v5,
            primary_type                           : 0x1::type_name::with_original_ids<T0>(),
            primary_amount                         : 0x2::coin::value<T0>(&arg6),
            secondary_type                         : 0x1::type_name::with_original_ids<T1>(),
            secondary_amount                       : 0x2::coin::value<T1>(&arg7),
            residual_type                          : 0x1::type_name::with_original_ids<T2>(),
            payout_destination                     : v3,
            residual_nft_transferred               : true,
            residual_may_hold_rewards_or_principal : arg9,
            emergency                              : arg10,
            deployment_adapter_nonce               : arg5,
            terminal_adapter_nonce                 : v6,
        };
        0x2::event::emit<OwnerInKindExitRecorded>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, v3);
        0x2::transfer::public_transfer<T2>(arg8, v3);
    }

    // decompiled from Move bytecode v7
}

