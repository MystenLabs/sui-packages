module 0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::bluefin {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        protocol: 0x1::string::String,
        logo: 0x1::ascii::String,
        pool: 0x2::object::ID,
        liquidity: u128,
        protocol_fee_rate: u64,
        withdraw_fee_rate: u64,
        is_pause: bool,
        positions: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
        lp_token_treasury: 0x2::coin::TreasuryCap<T0>,
        free_assets: 0x2::bag::Bag,
        protocol_fees: 0x2::bag::Bag,
        max_limit: u128,
        status: u8,
        limit_based_type: 0x1::type_name::TypeName,
        flash_loan_count: u8,
        slippage: u64,
        extension_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct FlashLoanReceipt {
        vault_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct CreateEvent has copy, drop {
        id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        clmm_position: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        lp_token_treasury: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        before_liquidity: u128,
        delta_liquidity: u128,
        before_supply: u64,
        lp_amount: u64,
    }

    struct RemoveEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lp_amount: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
        protocol_fee_a_amount: u64,
        protocol_fee_b_amount: u64,
    }

    struct CompoundEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        remaining_amount_a: u64,
        remaining_amount_b: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
    }

    struct MigrateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_position: 0x2::object::ID,
        new_position: 0x2::object::ID,
        remaining_amount: u64,
        old_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_liquidity: u128,
        new_liquidity: u128,
        current_sqrt_price: u128,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        remaining_amount_a: u64,
        remaining_amount_b: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
    }

    struct FeeClaimedEvent has copy, drop {
        amount_a: u64,
        amount_b: u64,
        vault_id: 0x2::object::ID,
    }

    struct RewarderClaimedEvent has copy, drop {
        amount: u64,
        rewarder_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
    }

    struct PauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct UnpauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct UpdateProtocolFeeRateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct UpdateWithdrawRateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct ClaimProtocolFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct UpdateMaxQuotaEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_limit: u128,
        new_limit: u128,
    }

    struct UpdateSlippageEvent has copy, drop {
        old_slippage: u64,
        new_slippage: u64,
    }

    struct FlashLoanEvent has copy, drop {
        vault_id: 0x2::object::ID,
        loan_type: 0x1::type_name::TypeName,
        repay_type: 0x1::type_name::TypeName,
        amount: u64,
        repay_amount: u64,
        oracle_pool: 0x2::object::ID,
        current_sqrt_price: u128,
    }

    struct RepayFlashLoanEvent has copy, drop {
        vault_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct AddExtensionConfigEvent has copy, drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct UpdateExtensionConfigEvent has copy, drop, store {
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
    }

    struct RemoveExtensionConfigEvent has copy, drop, store {
        key: 0x1::string::String,
    }

    public fun remove<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 2001);
        assert!(arg0.status == 1, 2002);
        assert!(arg5 > 0, 2004);
        assert!(0x2::coin::value<T0>(arg4) >= arg5, 2007);
        assert!(0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions) == 1, 2003);
        let (_, _) = collect_clmm_fee<T0, T1, T2>(arg0, arg2, arg3, arg8);
        let v2 = 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, 0);
        let v3 = 0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::utils::get_share_liquidity_by_amount(arg5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v2), total_token_amount<T0>(arg0));
        arg0.liquidity = arg0.liquidity - v3;
        let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T1, T2>(arg2, arg3, v2, v3, arg8);
        let v8 = v7;
        let v9 = v6;
        let (v10, v11) = if (arg0.withdraw_fee_rate == 0) {
            (0, 0)
        } else {
            let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v4, arg0.withdraw_fee_rate, 10000);
            let v13 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v5, arg0.withdraw_fee_rate, 10000);
            merge_protocol_asset<T0, T1>(arg0, 0x2::balance::split<T1>(&mut v9, v12));
            merge_protocol_asset<T0, T2>(arg0, 0x2::balance::split<T2>(&mut v8, v12));
            (v12, v13)
        };
        assert!(v4 - v10 >= arg6, 2015);
        assert!(v5 - v11 >= arg7, 2015);
        let v14 = RemoveEvent{
            vault_id              : 0x2::object::id<Vault<T0>>(arg0),
            lp_amount             : arg5,
            liquidity             : v3,
            amount_a              : v4,
            amount_b              : v5,
            protocol_fee_a_amount : v10,
            protocol_fee_b_amount : v11,
        };
        0x2::event::emit<RemoveEvent>(v14);
        0x2::coin::burn<T0>(&mut arg0.lp_token_treasury, 0x2::coin::split<T0>(arg4, arg5, arg9));
        (0x2::coin::from_balance<T1>(v9, arg9), 0x2::coin::from_balance<T2>(v8, arg9))
    }

    public fun collect_fee<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 2001);
        assert!(arg0.status == 1, 2002);
        let v0 = 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions);
        let v1 = 1;
        assert!(&v0 == &v1, 2003);
        let (_, _) = collect_clmm_fee<T0, T1, T2>(arg0, arg2, arg3, arg4);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 2001);
        assert!(arg0.status == 1, 2002);
        assert!(0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions) == 1, 2003);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T2, T3>(arg4, arg2, arg3, 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, 0));
        let v1 = &mut v0;
        merge_protocol_fee<T0, T3>(arg0, v1);
        merge_free_asset<T0, T3>(arg0, v0);
        let v2 = RewarderClaimedEvent{
            amount        : 0x2::balance::value<T3>(&v0),
            rewarder_type : 0x1::type_name::get<T0>(),
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::event::emit<RewarderClaimedEvent>(v2);
    }

    fun add_liquidity_fix_coin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (arg7) {
            arg5
        } else {
            arg6
        };
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg8, arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), v0, arg7);
        (v3, v4)
    }

    public fun add_or_update_extension_config<T0>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg4));
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.extension_fields, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.extension_fields, &arg2);
            *v0 = arg3;
            let v1 = UpdateExtensionConfigEvent{
                old_value : *v0,
                new_value : arg3,
            };
            0x2::event::emit<UpdateExtensionConfigEvent>(v1);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.extension_fields, arg2, arg3);
            let v2 = AddExtensionConfigEvent{
                key   : arg2,
                value : arg3,
            };
            0x2::event::emit<AddExtensionConfigEvent>(v2);
        };
    }

    fun calculate_updated_limit<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: u128, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let (v1, v2) = 0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::utils::get_amount_by_liquidity(arg3, arg4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), v0, arg2, true);
        assert!(0x1::type_name::get<T0>() == arg1 || 0x1::type_name::get<T1>() == arg1, 2020);
        get_tvl_of_based_coin(v0, v1, v2, 0x1::type_name::get<T0>() == arg1)
    }

    fun check_is_fix_coin_a(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u64, arg5: u64) : (bool, u64, u64) {
        let (_, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(arg0, arg1, arg2, arg3, arg4, true);
        assert!(v1 == arg4, 2019);
        if (v2 <= arg5) {
            return (true, v1, v2)
        };
        let (_, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(arg0, arg1, arg2, arg3, arg5, false);
        assert!(v5 == arg5, 2019);
        (false, v4, v5)
    }

    public fun claim_protocol_fee<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_protocol_fee_claim_role(arg1, 0x2::tx_context::sender(arg2));
        let v0 = take_protocol_asset<T0, T1>(arg0);
        let v1 = ClaimProtocolFeeEvent{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            amount    : 0x2::balance::value<T1>(&v0),
            type_name : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v1);
        0x2::coin::from_balance<T1>(v0, arg2)
    }

    fun collect_clmm_fee<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T2>(arg3, arg1, arg2, 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, 0));
        let v4 = v3;
        let v5 = v2;
        let v6 = &mut v5;
        merge_protocol_fee<T0, T1>(arg0, v6);
        let v7 = &mut v4;
        merge_protocol_fee<T0, T2>(arg0, v7);
        merge_free_asset<T0, T1>(arg0, v5);
        merge_free_asset<T0, T2>(arg0, v4);
        let v8 = FeeClaimedEvent{
            amount_a : v0,
            amount_b : v1,
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::event::emit<FeeClaimedEvent>(v8);
        (v0, v1)
    }

    public fun compound<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_compound_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 2001);
        assert!(arg0.status == 1, 2002);
        assert!(0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions) == 1, 2003);
        let (v0, v1, v2, v3, v4) = compound_assets<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5);
        let v5 = CompoundEvent{
            vault_id           : 0x2::object::id<Vault<T0>>(arg0),
            amount_a           : v0,
            amount_b           : v1,
            remaining_amount_a : v2,
            remaining_amount_b : v3,
            delta_liquidity    : v4,
            current_sqrt_price : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg3),
        };
        0x2::event::emit<CompoundEvent>(v5);
    }

    fun compound_assets<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u128) {
        let v0 = take_free_asset<T0, T1>(arg0);
        let v1 = 0x2::coin::from_balance<T1>(v0, arg4);
        let v2 = take_free_asset<T0, T2>(arg0);
        let v3 = 0x2::coin::from_balance<T2>(v2, arg4);
        let v4 = 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, 0);
        let v5 = 0x2::coin::value<T1>(&v1);
        let v6 = 0x2::coin::value<T2>(&v3);
        let (v7, v8, v9) = check_is_fix_coin_a(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T1, T2>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg2), v5, v6);
        let (v10, v11) = if (v7) {
            (v5, v9 + v9 * arg0.slippage / 10000)
        } else {
            (v8 + v8 * arg0.slippage / 10000, v6)
        };
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v4);
        let (v13, v14) = add_liquidity_fix_coin<T1, T2>(arg1, arg2, v4, v1, v3, v10, v11, v7, arg3, arg4);
        let v15 = v14;
        let v16 = v13;
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v4) - v12;
        assert!(v17 > 0, 2013);
        arg0.liquidity = arg0.liquidity + v17;
        merge_free_asset<T0, T1>(arg0, v16);
        merge_free_asset<T0, T2>(arg0, v15);
        (v5, v6, 0x2::balance::value<T1>(&v16), 0x2::balance::value<T2>(&v15), v17)
    }

    public fun create_vault<T0, T1, T2>(arg0: &mut 0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x2::coin::TreasuryCap<T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: u32, arg8: u32, arg9: bool, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg0);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg12));
        assert!(0x2::coin::total_supply<T2>(&arg4) == 0, 2006);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg5, arg6, arg7, arg8, arg12);
        let v2 = if (arg9) {
            0x1::type_name::get<T0>()
        } else {
            0x1::type_name::get<T1>()
        };
        let v3 = 0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>();
        0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut v3, v1);
        let v4 = Vault<T2>{
            id                : 0x2::object::new(arg12),
            name              : arg1,
            protocol          : arg2,
            logo              : arg3,
            pool              : v0,
            liquidity         : 0,
            protocol_fee_rate : 0,
            withdraw_fee_rate : 0,
            is_pause          : false,
            positions         : v3,
            lp_token_treasury : arg4,
            free_assets       : 0x2::bag::new(arg12),
            protocol_fees     : 0x2::bag::new(arg12),
            max_limit         : arg10,
            status            : 1,
            limit_based_type  : v2,
            flash_loan_count  : 0,
            slippage          : arg11,
            extension_fields  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::transfer::share_object<Vault<T2>>(v4);
        let v5 = CreateEvent{
            id                : 0x2::object::id<Vault<T2>>(&v4),
            clmm_pool         : v0,
            clmm_position     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v1),
            tick_lower        : arg7,
            tick_upper        : arg8,
            lp_token_treasury : 0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg4),
        };
        0x2::event::emit<CreateEvent>(v5);
    }

    public fun deposit<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 2001);
        assert!(arg0.status == 1, 2002);
        assert!(0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions) == 1, 2003);
        let (_, _) = collect_clmm_fee<T0, T1, T2>(arg0, arg2, arg3, arg9);
        let v2 = total_token_amount<T0>(arg0);
        let v3 = 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, 0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v3);
        let (v5, v6) = add_liquidity_fix_coin<T1, T2>(arg2, arg3, v3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v3) - v4;
        arg0.liquidity = arg0.liquidity + v7;
        if (arg0.max_limit != 0) {
            assert!(calculate_updated_limit<T1, T2>(arg3, arg0.limit_based_type, arg0.liquidity, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v3)) <= arg0.max_limit, 2014);
        };
        let v8 = 0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::utils::get_lp_amount_by_liquidity(v2, v7, v4);
        assert!(v8 > 0, 2005);
        assert!(v8 < ((18446744073709551616 - 1) as u128) - (v2 as u128), 2005);
        let v9 = DepositEvent{
            vault_id         : 0x2::object::id<Vault<T0>>(arg0),
            before_liquidity : v4,
            delta_liquidity  : v7,
            before_supply    : v2,
            lp_amount        : (v8 as u64),
        };
        0x2::event::emit<DepositEvent>(v9);
        (0x2::coin::mint<T0>(&mut arg0.lp_token_treasury, (v8 as u64), arg10), 0x2::coin::from_balance<T1>(v5, arg10), 0x2::coin::from_balance<T2>(v6, arg10))
    }

    public fun flash_loan<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, FlashLoanReceipt) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 2001);
        assert!(arg3 > 0, 2010);
        assert!(arg0.flash_loan_count == 0, 2009);
        let v0 = 0x2::object::id<Vault<T0>>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg2);
        arg0.flash_loan_count = arg0.flash_loan_count + 1;
        assert!(arg0.pool == v1, 2011);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg2);
        let v3 = (v2 as u256) * 100000000000000000000 / 18446744073709551616;
        let (v4, v5, v6) = if (arg4) {
            let v7 = take_free_asset_by_amount<T0, T1>(arg0, arg3);
            (0x2::coin::from_balance<T1>(v7, arg5), 0x2::coin::zero<T2>(arg5), (((arg3 as u256) * v3 * v3 / 100000000000000000000 / 100000000000000000000) as u64))
        } else {
            let v8 = take_free_asset_by_amount<T0, T2>(arg0, arg3);
            (0x2::coin::zero<T1>(arg5), 0x2::coin::from_balance<T2>(v8, arg5), (((arg3 as u256) * 100000000000000000000 / v3 * v3 / 100000000000000000000) as u64))
        };
        let v9 = v6 - v6 * arg0.slippage / 10000;
        let (v10, v11) = if (arg4) {
            (0x1::type_name::get<T1>(), 0x1::type_name::get<T2>())
        } else {
            (0x1::type_name::get<T2>(), 0x1::type_name::get<T1>())
        };
        let v12 = FlashLoanReceipt{
            vault_id     : v0,
            repay_type   : v11,
            repay_amount : v9,
        };
        let v13 = FlashLoanEvent{
            vault_id           : v0,
            loan_type          : v10,
            repay_type         : v11,
            amount             : arg3,
            repay_amount       : v9,
            oracle_pool        : v1,
            current_sqrt_price : v2,
        };
        0x2::event::emit<FlashLoanEvent>(v13);
        (v4, v5, v12)
    }

    fun free_assets_amount<T0, T1>(arg0: &Vault<T0>) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.free_assets, v0)) {
            return 0
        };
        0x2::balance::value<T1>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T1>>(&arg0.free_assets, v0))
    }

    public fun get_position_amounts<T0, T1, T2>(arg0: &Vault<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: u64) : (u64, u64) {
        assert!(0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions) == 1, 2003);
        let v0 = 0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, 0);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::utils::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T1, T2>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg1), 0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::utils::get_share_liquidity_by_amount(arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0), total_token_amount<T0>(arg0)), false)
    }

    fun get_tvl_of_based_coin(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : u128 {
        let v0 = (arg0 as u256) * 100000000000000000000 / 18446744073709551616;
        if (arg3) {
            (arg1 as u128) + (((arg2 as u256) * 100000000000000000000 / v0 * v0 / 100000000000000000000) as u128)
        } else {
            (arg2 as u128) + (((arg1 as u256) * v0 * v0 / 100000000000000000000 / 100000000000000000000) as u128)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun merge_free_asset<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return
        };
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.free_assets, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut arg0.free_assets, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T1>>(&mut arg0.free_assets, v0, arg1);
        };
    }

    fun merge_protocol_asset<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return
        };
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut arg0.protocol_fees, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T1>>(&mut arg0.protocol_fees, v0, arg1);
        };
    }

    fun merge_protocol_fee<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0x2::balance::Balance<T1>) {
        if (arg0.withdraw_fee_rate > 0 && 0x2::balance::value<T1>(arg1) > 0) {
            let v0 = 0x2::balance::split<T1>(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x2::balance::value<T1>(arg1), arg0.protocol_fee_rate, 10000));
            merge_protocol_asset<T0, T1>(arg0, v0);
        };
    }

    public fun migrate<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: u32, arg5: u32, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_rebalance_role(arg1, 0x2::tx_context::sender(arg7));
        assert!(!arg0.is_pause, 2001);
        assert!(arg0.status == 1, 2002);
        assert!(0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions) == 1, 2003);
        arg0.status = 2;
        let v0 = 0x1::vector::pop_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions);
        let (_, _) = collect_clmm_fee<T0, T1, T2>(arg0, arg2, arg3, arg6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T1, T2>(arg6, arg2, arg3, v0);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T1, T2>(arg2, arg3, arg4, arg5, arg7);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&v3);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&v3);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg3);
        let v7 = free_assets_amount<T0, T1>(arg0);
        let v8 = free_assets_amount<T0, T2>(arg0);
        let (v9, v10, v11) = check_is_fix_coin_a(v4, v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T1, T2>(arg3), v6, v7, v8);
        let (v12, v13) = if (v9) {
            let v13 = v11 + v11 * arg0.slippage / 10000;
            (v7, v13)
        } else {
            let v12 = v10 + v10 * arg0.slippage / 10000;
            (v12, v8)
        };
        let v14 = take_free_asset<T0, T1>(arg0);
        let v15 = take_free_asset<T0, T2>(arg0);
        let v16 = &mut v3;
        let v17 = 0x2::coin::from_balance<T1>(v14, arg7);
        let v18 = 0x2::coin::from_balance<T2>(v15, arg7);
        let (v19, v20) = add_liquidity_fix_coin<T1, T2>(arg2, arg3, v16, v17, v18, v12, v13, v9, arg6, arg7);
        let v21 = v20;
        let v22 = v19;
        let v23 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v3);
        assert!(v23 > 0, 2013);
        arg0.liquidity = v23;
        let v24 = if (v9) {
            assert!(0x2::balance::value<T1>(&v22) == 0, 2018);
            0x2::balance::value<T2>(&v21)
        } else {
            assert!(0x2::balance::value<T2>(&v21) == 0, 2018);
            0x2::balance::value<T1>(&v22)
        };
        let v25 = MigrateEvent{
            vault_id           : 0x2::object::id<Vault<T0>>(arg0),
            old_position       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0),
            new_position       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v3),
            remaining_amount   : v24,
            old_tick_lower     : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&v0),
            old_tick_upper     : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&v0),
            old_liquidity      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0),
            new_liquidity      : v23,
            current_sqrt_price : v6,
            tick_lower         : v4,
            tick_upper         : v5,
        };
        0x2::event::emit<MigrateEvent>(v25);
        merge_free_asset<T0, T1>(arg0, v22);
        merge_free_asset<T0, T2>(arg0, v21);
        0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, v3);
    }

    public fun pause<T0>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        arg0.is_pause = true;
        let v0 = PauseEvent{vault_id: 0x2::object::id<Vault<T0>>(arg0)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_rebalance_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 2001);
        assert!(arg0.status == 2, 2002);
        assert!(0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions) == 1, 2003);
        assert!(arg0.flash_loan_count == 0, 2009);
        let (v0, v1, v2, v3, v4) = compound_assets<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5);
        let v5 = RebalanceEvent{
            vault_id           : 0x2::object::id<Vault<T0>>(arg0),
            amount_a           : v0,
            amount_b           : v1,
            remaining_amount_a : v2,
            remaining_amount_b : v3,
            delta_liquidity    : v4,
            current_sqrt_price : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg3),
        };
        0x2::event::emit<RebalanceEvent>(v5);
        arg0.status = 1;
    }

    public fun remove_extension_config<T0>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.extension_fields, &arg2), 2022);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.extension_fields, &arg2);
        let v2 = RemoveExtensionConfigEvent{key: arg2};
        0x2::event::emit<RemoveExtensionConfigEvent>(v2);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: FlashLoanReceipt, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg4));
        assert!(!arg0.is_pause, 2001);
        arg0.flash_loan_count = arg0.flash_loan_count - 1;
        let FlashLoanReceipt {
            vault_id     : v0,
            repay_type   : v1,
            repay_amount : v2,
        } = arg2;
        let v3 = 0x2::coin::value<T1>(&arg3);
        assert!(0x1::type_name::get<T1>() == v1, 2020);
        assert!(v3 >= v2, 2012);
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 2021);
        merge_free_asset<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg3));
        let v4 = RepayFlashLoanEvent{
            vault_id     : v0,
            repay_type   : v1,
            repay_amount : v3,
        };
        0x2::event::emit<RepayFlashLoanEvent>(v4);
    }

    fun take_free_asset<T0, T1>(arg0: &mut Vault<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.free_assets, v0)) {
            return 0x2::balance::zero<T1>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T1>>(&mut arg0.free_assets, v0)
    }

    fun take_free_asset_by_amount<T0, T1>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.free_assets, v0), 2016);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut arg0.free_assets, v0);
        assert!(0x2::balance::value<T1>(v1) >= arg1, 2017);
        0x2::balance::split<T1>(v1, arg1)
    }

    fun take_protocol_asset<T0, T1>(arg0: &mut Vault<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0)) {
            return 0x2::balance::zero<T1>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T1>>(&mut arg0.protocol_fees, v0)
    }

    public fun total_token_amount<T0>(arg0: &Vault<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_token_treasury)
    }

    public fun unpause<T0>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        arg0.is_pause = false;
        let v0 = UnpauseEvent{vault_id: 0x2::object::id<Vault<T0>>(arg0)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public fun update_max_limit<T0>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(!arg0.is_pause, 2001);
        arg0.max_limit = arg2;
        let v0 = UpdateMaxQuotaEvent{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            old_limit : arg0.max_limit,
            new_limit : arg2,
        };
        0x2::event::emit<UpdateMaxQuotaEvent>(v0);
    }

    public fun update_protocol_fee_rate<T0>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 2008);
        assert!(!arg0.is_pause, 2001);
        arg0.protocol_fee_rate = arg2;
        let v0 = UpdateProtocolFeeRateEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateProtocolFeeRateEvent>(v0);
    }

    public fun update_slippage<T0>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 1000, 2008);
        arg0.slippage = arg2;
        let v0 = UpdateSlippageEvent{
            old_slippage : arg0.slippage,
            new_slippage : arg2,
        };
        0x2::event::emit<UpdateSlippageEvent>(v0);
    }

    public fun update_withdraw_fee_rate<T0>(arg0: &mut Vault<T0>, arg1: &0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::VaultsManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::checked_package_version(arg1);
        0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 2008);
        assert!(!arg0.is_pause, 2001);
        arg0.withdraw_fee_rate = arg2;
        let v0 = UpdateWithdrawRateEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            old_fee_rate : arg0.withdraw_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateWithdrawRateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

