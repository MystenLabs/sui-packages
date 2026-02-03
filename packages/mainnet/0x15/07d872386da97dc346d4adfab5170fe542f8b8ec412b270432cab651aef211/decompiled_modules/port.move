module 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port {
    struct PORT has drop {
        dummy_field: bool,
    }

    struct PortRegistry has store, key {
        id: 0x2::object::UID,
        index: u64,
        ports: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Port has key {
        id: 0x2::object::UID,
        is_pause: bool,
        vault: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::ClmmVault,
        buffer_assets: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::BalanceBag,
        protocol_fees: 0x2::bag::Bag,
        hard_cap: u128,
        quote_type: 0x1::option::Option<0x1::type_name::TypeName>,
        status: Status,
        protocol_fee_rate: u64,
        total_volume: u64,
        reward_growth: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        last_update_growth_time_ms: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        osail_reward_balances: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::BalanceBag,
        osail_growth_global: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u128>,
        last_update_osail_growth_time_ms: u64,
        pool_token_reward_balance: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::BalanceBag,
        managers: 0x2::linked_table::LinkedTable<address, bool>,
        rewarder: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::RewarderManager,
        bag: 0x2::bag::Bag,
    }

    struct PortEntry has store, key {
        id: 0x2::object::UID,
        port_id: 0x2::object::ID,
        volume: u64,
        entry_reward_growth: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        incentive_reward_growth: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
    }

    struct Status has store {
        last_aum: u128,
        last_calculate_aum_tx: vector<u8>,
        last_deposit_tx: vector<u8>,
        last_withdraw_tx: vector<u8>,
    }

    struct CreateEvent has copy, drop {
        id: 0x2::object::ID,
        pool: 0x2::object::ID,
        vault_position_id: 0x2::object::ID,
        lower_offset: u32,
        upper_offset: u32,
        rebalance_threshold: u32,
        quote_type: 0x1::option::Option<0x1::type_name::TypeName>,
        hard_cap: u128,
        start_volume: u64,
    }

    struct InitEvent has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct PauseEvent has copy, drop {
        port_id: 0x2::object::ID,
    }

    struct UnpauseEvent has copy, drop {
        port_id: 0x2::object::ID,
    }

    struct UpdateHardCapEvent has copy, drop {
        port_id: 0x2::object::ID,
        old_hard_cap: u128,
        new_hard_cap: u128,
    }

    struct PortEntryCreatedEvent has copy, drop {
        port_id: 0x2::object::ID,
        port_entry_id: 0x2::object::ID,
        volume: u64,
        entry_reward_growth: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
    }

    struct IncreaseLiquidityEvent has copy, drop {
        port_id: 0x2::object::ID,
        before_aum: u128,
        user_tvl: u128,
        before_total_volume: u64,
        volume: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct PortEntryIncreasedLiquidityEvent has copy, drop {
        port_id: 0x2::object::ID,
        port_entry_id: 0x2::object::ID,
        volume: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct WithdrawEvent has copy, drop {
        port_id: 0x2::object::ID,
        port_entry_id: 0x2::object::ID,
        volume_withdraw: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
        remained_a: u64,
        remained_b: u64,
    }

    struct PortEntryDestroyedEvent has copy, drop {
        port_id: 0x2::object::ID,
        port_entry_id: 0x2::object::ID,
    }

    struct FlashLoanEvent has copy, drop {
        port_id: 0x2::object::ID,
        loan_type: 0x1::type_name::TypeName,
        repay_type: 0x1::type_name::TypeName,
        loan_amount: u64,
        repay_amount: u64,
        base_to_quote_price: u64,
        base_price: u64,
        quote_price: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        port_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct OsailRewardUpdatedEvent has copy, drop {
        port_id: 0x2::object::ID,
        osail_coin_type: 0x1::type_name::TypeName,
        amount_osail: u64,
        new_growth: u128,
        update_time: u64,
    }

    struct OsailRewardClaimedEvent has copy, drop {
        port_id: 0x2::object::ID,
        port_entry_id: 0x2::object::ID,
        osail_coin_type: 0x1::type_name::TypeName,
        amount_osail: u64,
        new_growth: u128,
        update_time: u64,
    }

    struct ClaimProtocolFeeEvent has copy, drop {
        port_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct UpdatePoolRewardEvent has copy, drop {
        port_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        new_growth: u128,
        update_time: u64,
    }

    struct PoolRewardClaimedEvent has copy, drop {
        port_id: 0x2::object::ID,
        port_entry_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        new_growth: u128,
        update_time: u64,
    }

    struct IncentiveRewardClaimedEvent has copy, drop {
        port_id: 0x2::object::ID,
        port_entry_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        new_growth: u128,
        update_time: u64,
    }

    struct AddLiquidityEvent has copy, drop {
        port_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
        total_volume: u64,
        remained_a: u64,
        remained_b: u64,
    }

    struct RebalanceEvent has copy, drop {
        port_id: 0x2::object::ID,
        data: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::MigrateLiquidity,
        remained_a: u64,
        remained_b: u64,
    }

    struct NewVaultPositionEvent has copy, drop {
        port_id: 0x2::object::ID,
        vault_position_id: 0x2::object::ID,
    }

    struct UpdateLiquidityOffsetEvent has copy, drop {
        port_id: 0x2::object::ID,
        old_lower_offset: u32,
        old_upper_offset: u32,
        new_lower_offset: u32,
        new_upper_offset: u32,
    }

    struct UpdateRebalanceThresholdEvent has copy, drop {
        port_id: 0x2::object::ID,
        old_rebalance_threshold: u32,
        new_rebalance_threshold: u32,
    }

    struct UpdateProtocolFeeEvent has copy, drop {
        port_id: 0x2::object::ID,
        old_protocol_fee_rate: u64,
        new_protocol_fee_rate: u64,
    }

    struct StartVaultEvent has copy, drop {
        port_id: 0x2::object::ID,
        buffer_balance_a: u64,
        buffer_balance_b: u64,
    }

    struct StopVaultEvent has copy, drop {
        port_id: 0x2::object::ID,
        buffer_balance_a: u64,
        buffer_balance_b: u64,
    }

    struct FlashLoanCert {
        port_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::PortOracle, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_operation_manager_role(arg1, 0x2::tx_context::sender(arg11)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg11)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_operation_manager_permission());
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(!0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::vault_is_stopped());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let v0 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price<T0>(arg7, arg10);
        let v1 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price<T1>(arg7, arg10);
        let (v2, v3) = add_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_value(&v0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_coin_decimal(&v0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_value(&v1), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_coin_decimal(&v1), arg10, arg11);
        assert!(v2 <= arg8 && v3 <= arg9, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_not_enough());
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: u64, arg8: u8, arg9: u64, arg10: u8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(arg7, 0x1::u64::pow(10, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_multiplier_decimal()), arg9);
        if ((0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_protocol_fee_denominator() as u128) * 0x1::u128::diff((v0 as u128), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_utils::sqrt_price_to_price(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_sqrt_price<T0, T1>(arg6), arg8, arg10, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_multiplier_decimal())) / (v0 as u128) > (0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_max_price_deviation_bps(arg1) as u128)) {
            return (0, 0)
        };
        let v1 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::withdraw_all<T0>(&mut arg0.buffer_assets);
        let v2 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::withdraw_all<T1>(&mut arg0.buffer_assets);
        let (v3, v4, v5) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::increase_liquidity<T0, T1>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, &mut v1, &mut v2, arg11, arg12);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T0>(&mut arg0.buffer_assets, v1);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T1>(&mut arg0.buffer_assets, v2);
        let v6 = AddLiquidityEvent{
            port_id            : 0x2::object::id<Port>(arg0),
            amount_a           : v3,
            amount_b           : v4,
            delta_liquidity    : v5,
            current_sqrt_price : 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_sqrt_price<T0, T1>(arg6),
            total_volume       : arg0.total_volume,
            remained_a         : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.buffer_assets),
            remained_b         : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T1>(&arg0.buffer_assets),
        };
        0x2::event::emit<AddLiquidityEvent>(v6);
        (v3, v4)
    }

    public fun add_manager(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        if (!0x2::linked_table::contains<address, bool>(&arg0.managers, arg2)) {
            0x2::linked_table::push_back<address, bool>(&mut arg0.managers, arg2, true);
        };
    }

    fun before_increase_liquidity<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u64 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 > 0 || v1 > 0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_is_zero());
        let v2 = *0x2::tx_context::digest(arg7);
        assert!(v2 == arg0.status.last_calculate_aum_tx, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::aum_done_err());
        assert!(v2 != arg0.status.last_deposit_tx, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::operation_not_allowed());
        assert!(v2 != arg0.status.last_withdraw_tx, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::operation_not_allowed());
        check_updated_rewards<T0, T1>(arg0, arg2, arg6);
        arg0.status.last_deposit_tx = v2;
        let v3 = arg0.total_volume;
        assert!(arg0.hard_cap == 0 || arg0.status.last_aum + arg5 <= arg0.hard_cap, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::hard_cap_reached());
        let v4 = get_volume_by_tvl(v3, arg5, arg0.status.last_aum);
        assert!(v4 > 0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_is_zero());
        assert!(v4 < 18446744073709551615 - (v3 as u128), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_overflow());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T0>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T0>(arg3));
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(arg4));
        let v5 = IncreaseLiquidityEvent{
            port_id             : 0x2::object::id<Port>(arg0),
            before_aum          : arg0.status.last_aum,
            user_tvl            : arg5,
            before_total_volume : v3,
            volume              : (v4 as u64),
            amount_a            : v0,
            amount_b            : v1,
        };
        0x2::event::emit<IncreaseLiquidityEvent>(v5);
        arg0.status.last_aum = arg0.status.last_aum + arg5;
        arg0.total_volume = arg0.total_volume + (v4 as u64);
        (v4 as u64)
    }

    public fun calculate_aum<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::PortOracle, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg4) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let (v2, v3) = if (!0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault)) {
            0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::liquidity_value<T0, T1>(&arg0.vault, arg3, arg4)
        } else {
            (0, 0)
        };
        let v4 = 0;
        let v5 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v6 = *0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::balances(&arg0.buffer_assets);
        while (v4 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(&v6)) {
            let (v7, v8) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v6, v4);
            let v9 = *v7;
            if (v9 != v0 && v9 != v1) {
                v4 = v4 + 1;
                continue
            };
            let v10 = *v8;
            let v11 = v10;
            if (v0 == v9) {
                v11 = v10 + v2;
            } else if (v1 == v9) {
                v11 = v10 + v3;
            };
            if (!0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::contain_oracle_info(arg2, v9) || v11 == 0) {
                v4 = v4 + 1;
                continue
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v5, v9, v11);
            v4 = v4 + 1;
        };
        arg0.status.last_aum = calculate_tvl_base_on_quote(arg2, &v5, arg0.quote_type, arg5);
        let v12 = *0x2::tx_context::digest(arg6);
        assert!(v12 != arg0.status.last_calculate_aum_tx, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::operation_not_allowed());
        arg0.status.last_calculate_aum_tx = v12;
    }

    fun calculate_tvl_base_on_quote(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::PortOracle, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg2: 0x1::option::Option<0x1::type_name::TypeName>, arg3: &0x2::clock::Clock) : u128 {
        let v0 = if (0x1::option::is_none<0x1::type_name::TypeName>(&arg2)) {
            0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::new_price(1 * 0x1::u64::pow(10, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_multiplier_decimal()), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_multiplier_decimal())
        } else {
            0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price_by_type(arg0, *0x1::option::borrow<0x1::type_name::TypeName>(&arg2), arg3)
        };
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(arg1)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(arg1, v3);
            let v6 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price_by_type(arg0, *v4, arg3);
            let (v7, _) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::calculate_prices(&v6, &v1);
            v2 = v2 + 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((v7 as u128), (*v5 as u128), (0x1::u64::pow(10, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_multiplier_decimal()) as u128));
            v3 = v3 + 1;
        };
        v2
    }

    fun check_claimed_rewards<T0, T1>(arg0: &Port, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &PortEntry, arg3: &0x2::clock::Clock) {
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        check_updated_rewards<T0, T1>(arg0, arg1, arg3);
        let v0 = 0x2::linked_table::back<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global);
        if (0x1::option::is_some<0x1::type_name::TypeName>(v0)) {
            let v1 = 0x1::option::borrow<0x1::type_name::TypeName>(v0);
            assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, v1) && *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, v1) == *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *v1), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::osail_reward_not_claimed());
        };
        let v2 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::rewarders(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::rewarder_manager<T0, T1>(arg1));
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::Rewarder>(&v2)) {
            let v4 = *0x1::vector::borrow<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::Rewarder>(&v2, v3);
            let v5 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::reward_coin(&v4);
            let v6 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, &v5)) {
                if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.reward_growth, &v5)) {
                    *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, &v5) == *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg0.reward_growth, &v5)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::reward_growth_not_match());
            v3 = v3 + 1;
        };
        let (v7, _, v9) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::get_rewards_info(&arg0.rewarder);
        let v10 = v9;
        let v11 = v7;
        v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v11)) {
            let v12 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v11, v3);
            assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.incentive_reward_growth, &v12) && *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg2.incentive_reward_growth, &v12) == *0x1::vector::borrow<u128>(&v10, v3), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::incentive_reward_not_claimed());
            v3 = v3 + 1;
        };
    }

    public fun check_manager(arg0: &Port, arg1: address) : bool {
        0x2::linked_table::contains<address, bool>(&arg0.managers, arg1)
    }

    fun check_need_rebalance<T0, T1>(arg0: &Port, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg2: u32, arg3: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg4: u32) : (bool, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) {
        let (v0, v1, _) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::get_liquidity_range(&arg0.vault);
        let (v3, v4) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::next_position_range(v0, v1, arg2, arg3);
        if (0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault)) {
            return (false, v3, v4)
        };
        let (v5, v6) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::get_position_tick_range<T0, T1>(&arg0.vault, arg1);
        if (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::lte(v4, v5) || 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::gte(v3, v6)) {
            return (true, v3, v4)
        };
        let v7 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::abs_u32(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::sub(v3, v5)) >= arg4 || 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::abs_u32(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::sub(v4, v6)) >= arg4;
        (v7, v3, v4)
    }

    public fun check_need_rebalance_port<T0, T1>(arg0: &Port, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>) : (bool, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) {
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg2) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        check_need_rebalance<T0, T1>(arg0, arg1, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::tick_spacing<T0, T1>(arg2), 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_tick_index<T0, T1>(arg2), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::rebalance_threshold(&arg0.vault))
    }

    public fun check_updated_rewards<T0, T1>(arg0: &Port, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.last_update_osail_growth_time_ms == v0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::not_updated_osail_growth_time());
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::last_update_growth_time(&arg0.rewarder) == v0 / 1000, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::not_updated_incentive_reward_growth_time());
        let v1 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::rewarders(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::rewarder_manager<T0, T1>(arg1));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::Rewarder>(&v1)) {
            let v3 = *0x1::vector::borrow<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::Rewarder>(&v1, v2);
            let v4 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::reward_coin(&v3);
            assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.last_update_growth_time_ms, &v4), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::reward_types_not_match());
            let v5 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::reward_coin(&v3);
            assert!(*0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.last_update_growth_time_ms, &v5) == v0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::not_updated_reward_growth_time());
            v2 = v2 + 1;
        };
        let v6 = 0;
        while (v6 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(&arg0.last_update_growth_time_ms)) {
            let (_, v8) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&arg0.last_update_growth_time_ms, v6);
            assert!(v8 == &v0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::not_updated_reward_growth_time());
            v6 = v6 + 1;
        };
    }

    public fun claim_incentive_reward<T0>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut Port, arg2: &mut PortEntry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(arg2.port_id == 0x2::object::id<Port>(arg1), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (v1, v2) = get_incentive_reward_amount_to_claim<T0>(arg0, arg1, arg2, arg3);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.incentive_reward_growth, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u128>(&mut arg2.incentive_reward_growth, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg2.incentive_reward_growth, v0, v2);
        let v5 = IncentiveRewardClaimedEvent{
            port_id       : 0x2::object::id<Port>(arg1),
            port_entry_id : 0x2::object::id<PortEntry>(arg2),
            reward_type   : 0x1::type_name::with_defining_ids<T0>(),
            amount        : v1,
            new_growth    : v2,
            update_time   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<IncentiveRewardClaimedEvent>(v5);
        if (v1 > 0) {
            0x2::coin::from_balance<T0>(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::withdraw_reward<T0>(&mut arg1.rewarder, 0x2::object::id<Port>(arg1), v1), arg4)
        } else {
            0x2::coin::zero<T0>(arg4)
        }
    }

    public fun claim_pool_reward<T0, T1, T2>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut Port, arg2: &mut PortEntry, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg7: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg7) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg1.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        assert!(arg2.port_id == 0x2::object::id<Port>(arg1), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let (v1, v2) = get_pool_reward_amount_to_claim<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u128>(&mut arg2.entry_reward_growth, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg2.entry_reward_growth, v0, v2);
        let v5 = PoolRewardClaimedEvent{
            port_id       : 0x2::object::id<Port>(arg1),
            port_entry_id : 0x2::object::id<PortEntry>(arg2),
            reward_type   : 0x1::type_name::with_defining_ids<T2>(),
            amount        : v1,
            new_growth    : v2,
            update_time   : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<PoolRewardClaimedEvent>(v5);
        if (v1 > 0) {
            let v7 = if (v0 == 0x1::type_name::with_defining_ids<T0>() || v0 == 0x1::type_name::with_defining_ids<T1>()) {
                0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::split<T2>(&mut arg1.pool_token_reward_balance, v1)
            } else {
                0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::split<T2>(&mut arg1.buffer_assets, v1)
            };
            0x2::coin::from_balance<T2>(v7, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        }
    }

    public fun claim_position_reward<T0, T1, T2, T3, T4>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut Port, arg2: &mut PortEntry, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T2>, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg1.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        assert!(arg2.port_id == 0x2::object::id<Port>(arg1), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T4>();
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg1.osail_growth_global, v0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::osail_growth_not_match());
        let v1 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg1.osail_growth_global, v0);
        if (0x1::option::is_some<0x1::type_name::TypeName>(v1)) {
            let v2 = 0x1::option::borrow<0x1::type_name::TypeName>(v1);
            let v3 = 0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg1.osail_growth_global, *0x1::option::borrow<0x1::type_name::TypeName>(v1));
            assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, v2) || 0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, v2) == v3, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::not_claimed_previous_osail_reward());
        };
        let (v4, v5) = get_osail_amount_to_claim<T0, T1, T2, T3, T4>(arg1, arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T4>(&arg1.osail_reward_balances) >= v4, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::osail_reward_not_enough());
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u128>(&mut arg2.entry_reward_growth, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg2.entry_reward_growth, v0, v5);
        let v8 = OsailRewardClaimedEvent{
            port_id         : 0x2::object::id<Port>(arg1),
            port_entry_id   : 0x2::object::id<PortEntry>(arg2),
            osail_coin_type : v0,
            amount_osail    : v4,
            new_growth      : v5,
            update_time     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<OsailRewardClaimedEvent>(v8);
        if (v4 > 0) {
            0x2::coin::from_balance<T4>(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::split<T4>(&mut arg1.osail_reward_balances, v4), arg8)
        } else {
            0x2::coin::zero<T4>(arg8)
        }
    }

    public fun claim_protocol_fee<T0>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_protocol_fee_claim_role(arg1, 0x2::tx_context::sender(arg2)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_protocol_fee_claim_permission());
        let v0 = take_protocol_asset<T0>(arg0);
        let v1 = ClaimProtocolFeeEvent{
            port_id   : 0x2::object::id<Port>(arg0),
            amount    : 0x2::balance::value<T0>(&v0),
            type_name : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun create_port<T0, T1>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut PortRegistry, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::PortOracle, arg3: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg6: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg7: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg8: u32, arg9: u32, arg10: u32, arg11: bool, arg12: u128, arg13: 0x2::balance::Balance<T0>, arg14: 0x2::balance::Balance<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), 0x2::balance::value<T0>(&arg13));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::with_defining_ids<T1>(), 0x2::balance::value<T1>(&arg14));
        let v1 = if (arg11) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>())
        } else {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>())
        };
        create_port_internal<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, calculate_tvl_base_on_quote(arg2, &v0, v1, arg15), arg13, arg14, arg15, arg16);
    }

    fun create_port_internal<T0, T1>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut PortRegistry, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: u32, arg8: u32, arg9: u32, arg10: bool, arg11: u128, arg12: u128, arg13: 0x2::balance::Balance<T0>, arg14: 0x2::balance::Balance<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        let v0 = if (arg10) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>())
        } else {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>())
        };
        let v1 = 0x2::clock::timestamp_ms(arg15);
        let v2 = Port{
            id                               : 0x2::object::new(arg16),
            is_pause                         : false,
            vault                            : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::new<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg13, arg14, arg15, arg16),
            buffer_assets                    : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::new_balance_bag(arg16),
            protocol_fees                    : 0x2::bag::new(arg16),
            hard_cap                         : arg11,
            quote_type                       : v0,
            status                           : new_status(),
            protocol_fee_rate                : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_protocol_fee_rate(arg0),
            total_volume                     : 0,
            reward_growth                    : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
            last_update_growth_time_ms       : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            osail_reward_balances            : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::new_balance_bag(arg16),
            osail_growth_global              : 0x2::linked_table::new<0x1::type_name::TypeName, u128>(arg16),
            last_update_osail_growth_time_ms : v1,
            pool_token_reward_balance        : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::new_balance_bag(arg16),
            managers                         : 0x2::linked_table::new<address, bool>(arg16),
            rewarder                         : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::new(arg16),
            bag                              : 0x2::bag::new(arg16),
        };
        0x2::linked_table::push_back<address, bool>(&mut v2.managers, 0x2::tx_context::sender(arg16), true);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T0>(&mut v2.buffer_assets, 0x2::balance::zero<T0>());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T1>(&mut v2.buffer_assets, 0x2::balance::zero<T1>());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T0>(&mut v2.pool_token_reward_balance, 0x2::balance::zero<T0>());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T1>(&mut v2.pool_token_reward_balance, 0x2::balance::zero<T1>());
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.ports, 0x2::object::id<Port>(&v2), 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6));
        let v3 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::rewarders(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::rewarder_manager<T0, T1>(arg6));
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::Rewarder>(&v3)) {
            let v5 = 0x1::vector::borrow<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::Rewarder>(&v3, v4);
            let v6 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::reward_coin(v5);
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v2.reward_growth, v6, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::growth_global(v5) << 64);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.last_update_growth_time_ms, v6, v1);
            v4 = v4 + 1;
        };
        let v7 = get_volume_by_tvl(v2.total_volume, arg12, v2.status.last_aum);
        v2.total_volume = (v7 as u64);
        let v8 = CreateEvent{
            id                  : 0x2::object::id<Port>(&v2),
            pool                : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6),
            vault_position_id   : 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::position_id(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::borrow_staked_position(&v2.vault)),
            lower_offset        : arg7,
            upper_offset        : arg8,
            rebalance_threshold : arg9,
            quote_type          : v0,
            hard_cap            : arg11,
            start_volume        : (v7 as u64),
        };
        0x2::event::emit<CreateEvent>(v8);
        0x2::transfer::share_object<Port>(v2);
    }

    public fun deposit<T0, T1>(arg0: &mut Port, arg1: &mut 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::PortOracle, arg3: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg6: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg7: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : PortEntry {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg7) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::value<T0>(&arg8));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::with_defining_ids<T1>(), 0x2::coin::value<T1>(&arg9));
        let v1 = calculate_tvl_base_on_quote(arg2, &v0, arg0.quote_type, arg10);
        deposit_internal<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v1, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price<T0>(arg2, arg10), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price<T1>(arg2, arg10), arg10, arg11)
    }

    fun deposit_internal<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u128, arg10: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::Price, arg11: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::Price, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : PortEntry {
        let v0 = before_increase_liquidity<T0, T1>(arg0, arg1, arg6, arg7, arg8, arg9, arg12, arg13);
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u128>();
        let v2 = 0;
        while (v2 < 0x2::vec_map::length<0x1::type_name::TypeName, u128>(&arg0.reward_growth)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(&arg0.reward_growth, v2);
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v1, *v3, *v4);
            v2 = v2 + 1;
        };
        let v5 = 0x2::linked_table::back<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global);
        if (!0x1::option::is_some<0x1::type_name::TypeName>(v5)) {
            abort 13906839285354463231
        };
        let v6 = 0x1::option::borrow<0x1::type_name::TypeName>(v5);
        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v1, *v6, *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *v6));
        let v7 = 0x2::vec_map::empty<0x1::type_name::TypeName, u128>();
        let (v8, _, v10) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::get_rewards_info(&arg0.rewarder);
        let v11 = v10;
        let v12 = v8;
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x1::type_name::TypeName>(&v12)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v7, *0x1::vector::borrow<0x1::type_name::TypeName>(&v12, v13), *0x1::vector::borrow<u128>(&v11, v13));
            v13 = v13 + 1;
        };
        let v14 = PortEntry{
            id                      : 0x2::object::new(arg13),
            port_id                 : 0x2::object::id<Port>(arg0),
            volume                  : v0,
            entry_reward_growth     : v1,
            incentive_reward_growth : v7,
        };
        let v15 = PortEntryCreatedEvent{
            port_id             : 0x2::object::id<Port>(arg0),
            port_entry_id       : 0x2::object::id<PortEntry>(&v14),
            volume              : v14.volume,
            entry_reward_growth : v1,
        };
        0x2::event::emit<PortEntryCreatedEvent>(v15);
        if (!0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault)) {
            let (_, _) = add_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_value(&arg10), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_coin_decimal(&arg10), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_value(&arg11), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_coin_decimal(&arg11), arg12, arg13);
        };
        v14
    }

    public fun destory_port_entry(arg0: &Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: PortEntry) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(arg2.port_id == 0x2::object::id<Port>(arg0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        assert!(arg2.volume == 0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_volume_not_empty());
        let PortEntry {
            id                      : v0,
            port_id                 : _,
            volume                  : _,
            entry_reward_growth     : _,
            incentive_reward_growth : _,
        } = arg2;
        let v5 = v0;
        let v6 = PortEntryDestroyedEvent{
            port_id       : 0x2::object::id<Port>(arg0),
            port_entry_id : *0x2::object::uid_as_inner(&v5),
        };
        0x2::event::emit<PortEntryDestroyedEvent>(v6);
        0x2::object::delete(v5);
    }

    public fun emissions_per_second<T0>(arg0: &Port) : u128 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::emissions_per_second<T0>(&arg0.rewarder)
    }

    public fun flash_loan<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::PortOracle, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanCert) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_operation_manager_role(arg1, 0x2::tx_context::sender(arg5)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg5)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_operation_manager_permission());
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        arg0.is_pause = true;
        assert!(arg3 > 0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_is_zero());
        flash_loan_internal<T0, T1>(arg0, arg1, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price<T1>(arg2, arg4), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price<T0>(arg2, arg4), arg3, arg5)
    }

    fun flash_loan_internal<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::Price, arg3: 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::Price, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanCert) {
        let (v0, _) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::calculate_prices(&arg3, &arg2);
        let v2 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_ceil(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_ceil(v0, arg4, 0x1::u64::pow(10, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_multiplier_decimal())), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_swap_slippage_denominator() - (0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_swap_slippage<T0>(arg1) + 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_swap_slippage<T1>(arg1)) / 2, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_swap_slippage_denominator());
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let (v5, v6) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::coin_types(&arg0.vault);
        assert!(v3 == v5 || v3 == v6, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::incorrect_repay_type());
        assert!(v4 != v3 && (v4 == v5 || v4 == v6), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::incorrect_loan_type());
        assert!(arg4 <= 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.buffer_assets), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_not_enough());
        let v7 = FlashLoanCert{
            port_id      : 0x2::object::id<Port>(arg0),
            repay_type   : v3,
            repay_amount : v2,
        };
        let v8 = FlashLoanEvent{
            port_id             : 0x2::object::id<Port>(arg0),
            loan_type           : v4,
            repay_type          : v3,
            loan_amount         : arg4,
            repay_amount        : v2,
            base_to_quote_price : v0,
            base_price          : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_value(&arg3),
            quote_price         : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_value(&arg2),
        };
        0x2::event::emit<FlashLoanEvent>(v8);
        (0x2::coin::from_balance<T0>(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::split<T0>(&mut arg0.buffer_assets, arg4), arg5), v7)
    }

    public fun get_buffer_asset_value<T0>(arg0: &Port) : u64 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.buffer_assets)
    }

    public fun get_entry_reward_growth<T0>(arg0: &PortEntry) : u128 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.entry_reward_growth, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg0.entry_reward_growth, &v0)
        } else {
            0
        }
    }

    public fun get_hard_cap(arg0: &Port) : u128 {
        arg0.hard_cap
    }

    public fun get_incentive_reward_amount_to_claim<T0>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut Port, arg2: &mut PortEntry, arg3: &0x2::clock::Clock) : (u64, u128) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(arg2.port_id == 0x2::object::id<Port>(arg1), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::settle(&mut arg1.rewarder, 0x2::object::id<Port>(arg1), arg1.total_volume, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v1 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::growth_global<T0>(&arg1.rewarder);
        if (arg2.volume == 0) {
            return (0, v1)
        };
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.incentive_reward_growth, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg2.incentive_reward_growth, &v0)
        } else {
            0
        };
        if (v1 <= v2) {
            return (0, v1)
        };
        ((0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg2.volume as u128), v1 - v2, 18446744073709551616) as u64), v1)
    }

    public fun get_managers(arg0: &Port) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x2::linked_table::front<address, bool>(&arg0.managers);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            0x1::vector::push_back<address>(&mut v0, v2);
            v1 = 0x2::linked_table::next<address, bool>(&arg0.managers, v2);
        };
        v0
    }

    public fun get_osail_amount_to_claim<T0, T1, T2, T3, T4>(arg0: &mut Port, arg1: &PortEntry, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T2>, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u128) {
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(arg1.port_id == 0x2::object::id<Port>(arg0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T4>();
        if (arg0.last_update_osail_growth_time_ms != 0x2::clock::timestamp_ms(arg7)) {
            update_position_reward<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        };
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0)) {
            return (0, 0)
        };
        let v1 = *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0);
        if (arg1.volume == 0) {
            return (0, v1)
        };
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg1.entry_reward_growth, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg1.entry_reward_growth, &v0)
        } else {
            let v3 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0);
            while (0x1::option::is_some<0x1::type_name::TypeName>(v3)) {
                if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg1.entry_reward_growth, 0x1::option::borrow<0x1::type_name::TypeName>(v3))) {
                    break
                };
                let v4 = *0x1::option::borrow<0x1::type_name::TypeName>(v3);
                v3 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v4);
            };
            if (0x1::option::is_none<0x1::type_name::TypeName>(v3)) {
                return (0, 0)
            };
            0
        };
        let v5 = v2;
        let v6 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0);
        if (0x1::option::is_some<0x1::type_name::TypeName>(v6)) {
            let v7 = *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *0x1::option::borrow<0x1::type_name::TypeName>(v6));
            if (v7 > v2) {
                v5 = v7;
            };
        };
        if (v5 >= v1) {
            return (0, v1)
        };
        ((0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg1.volume as u128), v1 - v5, 18446744073709551616) as u64), v1)
    }

    public fun get_osail_reward_balances_value<T0>(arg0: &Port) : u64 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.osail_reward_balances)
    }

    public fun get_osail_type_to_claim<T0, T1, T2, T3>(arg0: &mut Port, arg1: &PortEntry, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T2>, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::type_name::TypeName {
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(arg1.port_id == 0x2::object::id<Port>(arg0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        assert!(arg1.volume > 0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_volume_empty());
        if (arg0.last_update_osail_growth_time_ms != 0x2::clock::timestamp_ms(arg7)) {
            update_position_reward<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        };
        let v0 = 0x2::linked_table::back<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global);
        while (0x1::option::is_some<0x1::type_name::TypeName>(v0)) {
            let v1 = 0x1::option::borrow<0x1::type_name::TypeName>(v0);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg1.entry_reward_growth, v1)) {
                if (0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *v1) == 0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg1.entry_reward_growth, v1)) {
                    let v2 = 0x2::linked_table::next<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *v1);
                    if (0x1::option::is_some<0x1::type_name::TypeName>(v2)) {
                        return *0x1::option::borrow<0x1::type_name::TypeName>(v2)
                    };
                    return *v1
                };
                return *v1
            };
            v0 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *v1);
        };
        abort 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_available_osail_reward()
    }

    public fun get_osail_types_to_claim<T0, T1, T2, T3>(arg0: &mut Port, arg1: &PortEntry, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T2>, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x1::type_name::TypeName> {
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(arg1.port_id == 0x2::object::id<Port>(arg0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        if (arg0.last_update_osail_growth_time_ms != 0x2::clock::timestamp_ms(arg7)) {
            update_position_reward<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        };
        if (arg1.volume == 0) {
            return 0x1::vector::empty<0x1::type_name::TypeName>()
        };
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x2::linked_table::back<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global);
        while (0x1::option::is_some<0x1::type_name::TypeName>(v1)) {
            let v2 = 0x1::option::borrow<0x1::type_name::TypeName>(v1);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg1.entry_reward_growth, v2)) {
                if (0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *v2) == 0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg1.entry_reward_growth, v2)) {
                    break
                } else {
                    0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, *v2);
                    break
                };
            };
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, *v2);
            v1 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *v2);
        };
        v0
    }

    public fun get_pool_reward_amount_to_claim<T0, T1, T2>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut Port, arg2: &mut PortEntry, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg7: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock) : (u64, u128) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(arg2.port_id == 0x2::object::id<Port>(arg1), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.last_update_growth_time_ms, &v0) || *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg1.last_update_growth_time_ms, &v0) != 0x2::clock::timestamp_ms(arg8)) {
            update_pool_reward<T0, T1, T2>(arg1, arg0, arg3, arg4, arg5, arg6, arg7, arg8);
        };
        if (arg2.volume == 0) {
            let v1 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg1.reward_growth, &v0)) {
                *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg1.reward_growth, &v0)
            } else {
                0
            };
            return (0, v1)
        };
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg2.entry_reward_growth, &v0)
        } else {
            0
        };
        let v3 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg1.reward_growth, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg1.reward_growth, &v0)
        } else {
            0
        };
        if (v3 <= v2) {
            return (0, v3)
        };
        ((0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg2.volume as u128), v3 - v2, 18446744073709551616) as u64), v3)
    }

    public fun get_pool_token_reward_balance_value<T0>(arg0: &Port) : u64 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.pool_token_reward_balance)
    }

    public fun get_port_id(arg0: &PortEntry) : 0x2::object::ID {
        arg0.port_id
    }

    public fun get_port_last_update_growth_time_ms<T0>(arg0: &Port) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.last_update_growth_time_ms, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.last_update_growth_time_ms, &v0)
        } else {
            0
        }
    }

    public fun get_port_last_update_osail_growth_time_ms(arg0: &Port) : u64 {
        arg0.last_update_osail_growth_time_ms
    }

    public fun get_port_osail_growth_global<T0>(arg0: &Port) : u128 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0)) {
            *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0)
        } else {
            0
        }
    }

    public fun get_port_pause_status(arg0: &Port) : bool {
        arg0.is_pause
    }

    public fun get_port_quote_type(arg0: &Port) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.quote_type
    }

    public fun get_port_reward_growth<T0>(arg0: &Port) : u128 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.reward_growth, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg0.reward_growth, &v0)
        } else {
            0
        }
    }

    public fun get_port_status_last_aum(arg0: &Port) : u128 {
        arg0.status.last_aum
    }

    public fun get_port_status_last_calculate_aum_tx(arg0: &Port) : vector<u8> {
        arg0.status.last_calculate_aum_tx
    }

    public fun get_port_status_last_deposit_tx(arg0: &Port) : vector<u8> {
        arg0.status.last_deposit_tx
    }

    public fun get_port_status_last_withdraw_tx(arg0: &Port) : vector<u8> {
        arg0.status.last_withdraw_tx
    }

    public fun get_position_amounts<T0, T1>(arg0: &Port, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>) : (u64, u64) {
        assert!(!0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::vault_is_stopped());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        if (is_stopped(arg0)) {
            return (0, 0)
        };
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_position_amounts<T0, T1>(arg1, 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::position_id(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::borrow_staked_position(&arg0.vault)))
    }

    public fun get_position_liquidity<T0, T1>(arg0: &Port, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>) : u128 {
        if (!is_stopped(arg0)) {
            0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::get_position_liquidity<T0, T1>(&arg0.vault, arg1)
        } else {
            0
        }
    }

    public fun get_position_tick_range<T0, T1>(arg0: &Port, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>) : (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) {
        if (!is_stopped(arg0)) {
            0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::get_position_tick_range<T0, T1>(&arg0.vault, arg1)
        } else {
            (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::zero(), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::zero())
        }
    }

    public fun get_protocol_fee_rate(arg0: &Port) : u64 {
        arg0.protocol_fee_rate
    }

    public fun get_protocol_fees_value<T0>(arg0: &Port) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.protocol_fees, 0x1::type_name::with_defining_ids<T0>()))
    }

    public fun get_repay_amount(arg0: &FlashLoanCert) : u64 {
        arg0.repay_amount
    }

    public fun get_repay_type(arg0: &FlashLoanCert) : 0x1::type_name::TypeName {
        arg0.repay_type
    }

    fun get_user_share_by_volume(arg0: u64, arg1: u64, arg2: u128) : u128 {
        0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg1 as u128), arg2, (arg0 as u128))
    }

    public fun get_volume(arg0: &PortEntry) : u64 {
        arg0.volume
    }

    fun get_volume_by_tvl(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg0 == 0) {
            return arg1
        };
        if (arg2 == 0) {
            abort 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::invalid_last_aum()
        };
        0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg0 as u128), arg1, arg2)
    }

    public fun increase_liquidity<T0, T1>(arg0: &mut Port, arg1: &mut 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::PortOracle, arg3: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg6: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg7: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg8: &mut PortEntry, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg7) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        assert!(arg8.port_id == 0x2::object::id<Port>(arg0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_entry_port_id_not_match());
        let v0 = 0x2::coin::value<T0>(&arg9);
        let v1 = 0x2::coin::value<T1>(&arg10);
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::with_defining_ids<T0>(), v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::with_defining_ids<T1>(), v1);
        let v3 = calculate_tvl_base_on_quote(arg2, &v2, arg0.quote_type, arg11);
        let v4 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price<T0>(arg2, arg11);
        let v5 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::get_price<T1>(arg2, arg11);
        let v6 = before_increase_liquidity<T0, T1>(arg0, arg1, arg7, arg9, arg10, v3, arg11, arg12);
        check_claimed_rewards<T0, T1>(arg0, arg7, arg8, arg11);
        arg8.volume = arg8.volume + v6;
        let v7 = PortEntryIncreasedLiquidityEvent{
            port_id       : 0x2::object::id<Port>(arg0),
            port_entry_id : 0x2::object::id<PortEntry>(arg8),
            volume        : arg8.volume,
            amount_a      : v0,
            amount_b      : v1,
        };
        0x2::event::emit<PortEntryIncreasedLiquidityEvent>(v7);
        if (!is_stopped(arg0)) {
            let (_, _) = add_liquidity_internal<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_value(&v4), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_coin_decimal(&v4), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_value(&v5), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::port_oracle::price_coin_decimal(&v5), arg11, arg12);
        };
    }

    fun init(arg0: PORT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PORT>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = PortRegistry{
            id    : 0x2::object::new(arg1),
            index : 0,
            ports : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        };
        let v1 = InitEvent{registry_id: 0x2::object::id<PortRegistry>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<PortRegistry>(v0);
    }

    public fun is_stopped(arg0: &Port) : bool {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault)
    }

    fun merge_protocol_asset<T0>(arg0: &mut Port, arg1: &mut 0x2::balance::Balance<T0>) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_utils::add_balance_to_bag<T0>(&mut arg0.protocol_fees, 0x2::balance::split<T0>(arg1, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(0x2::balance::value<T0>(arg1), arg0.protocol_fee_rate, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_protocol_fee_denominator())));
    }

    fun new_status() : Status {
        Status{
            last_aum              : 0,
            last_calculate_aum_tx : 0x1::vector::empty<u8>(),
            last_deposit_tx       : 0x1::vector::empty<u8>(),
            last_withdraw_tx      : 0x1::vector::empty<u8>(),
        }
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun pause(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_pool_manager_role(arg1, 0x2::tx_context::sender(arg2)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg2)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_pool_manager_permission());
        arg0.is_pause = true;
        let v0 = PauseEvent{port_id: 0x2::object::id<Port>(arg0)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun rebalance<T0, T1>(arg0: &mut Port, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg3);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_rebalance_role(arg3, 0x2::tx_context::sender(arg8)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg8)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_operation_manager_permission());
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(!0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::vault_is_stopped());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let (v0, v1, v2) = check_need_rebalance<T0, T1>(arg0, arg2, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::tick_spacing<T0, T1>(arg6), 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_tick_index<T0, T1>(arg6), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::rebalance_threshold(&arg0.vault));
        assert!(v0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::pool_not_need_rebalance());
        rebalance_internal<T0, T1>(arg0, arg1, arg2, arg5, arg4, arg6, v1, v2, arg7, arg8);
    }

    fun rebalance_internal<T0, T1>(arg0: &mut Port, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg7: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        check_updated_rewards<T0, T1>(arg0, arg5, arg8);
        let (v0, v1, v2) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::rebalance<T0, T1>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::withdraw_all<T0>(&mut arg0.buffer_assets), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::withdraw_all<T1>(&mut arg0.buffer_assets), arg6, arg7, arg8, arg9);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T0>(&mut arg0.buffer_assets, v0);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T1>(&mut arg0.buffer_assets, v1);
        let v3 = RebalanceEvent{
            port_id    : 0x2::object::id<Port>(arg0),
            data       : v2,
            remained_a : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.buffer_assets),
            remained_b : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T1>(&arg0.buffer_assets),
        };
        0x2::event::emit<RebalanceEvent>(v3);
        let v4 = NewVaultPositionEvent{
            port_id           : 0x2::object::id<Port>(arg0),
            vault_position_id : 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::position_id(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::borrow_staked_position(&arg0.vault)),
        };
        0x2::event::emit<NewVaultPositionEvent>(v4);
    }

    public fun rebalance_threshold(arg0: &Port) : u32 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::rebalance_threshold(&arg0.vault)
    }

    public fun remove_manager(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        if (0x2::linked_table::contains<address, bool>(&arg0.managers, arg2)) {
            0x2::linked_table::remove<address, bool>(&mut arg0.managers, arg2);
        };
    }

    public fun repay_flash_loan<T0>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: FlashLoanCert, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_operation_manager_role(arg1, 0x2::tx_context::sender(arg4)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg4)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_operation_manager_permission());
        assert!(arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        arg0.is_pause = false;
        assert!(0x1::type_name::with_defining_ids<T0>() == arg2.repay_type, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::incorrect_repay_type());
        assert!(0x2::coin::value<T0>(&arg3) >= arg2.repay_amount, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::incorrect_repay_amount());
        assert!(0x2::object::id<Port>(arg0) == arg2.port_id, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::incorrect_repay_port_id());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T0>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T0>(arg3));
        let FlashLoanCert {
            port_id      : _,
            repay_type   : _,
            repay_amount : _,
        } = arg2;
        let v3 = RepayFlashLoanEvent{
            port_id      : 0x2::object::id<Port>(arg0),
            repay_type   : 0x1::type_name::with_defining_ids<T0>(),
            repay_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v3);
    }

    public fun rewarder_available_balance_of<T0>(arg0: &Port) : u128 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::available_balance_of<T0>(&arg0.rewarder)
    }

    public fun rewarder_balance_of<T0>(arg0: &Port) : u64 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::balance_of<T0>(&arg0.rewarder)
    }

    public fun rewarder_deposit_reward<T0>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut Port, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::deposit_reward<T0>(&mut arg1.rewarder, 0x2::object::id<Port>(arg1), arg2);
    }

    public fun rewarder_emergent_withdraw<T0>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut Port, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg4));
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::emergent_withdraw<T0>(&mut arg1.rewarder, 0x2::object::id<Port>(arg1), arg2, arg1.total_volume, 0x2::clock::timestamp_ms(arg3) / 1000)
    }

    public fun rewarder_growth_global<T0>(arg0: &Port) : u128 {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::growth_global<T0>(&arg0.rewarder)
    }

    public fun rewarder_update_emission<T0>(arg0: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg1: &mut Port, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::object::id<Port>(arg1);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::settle(&mut arg1.rewarder, v0, arg1.total_volume, 0x2::clock::timestamp_ms(arg3) / 1000);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::update_emission<T0>(&mut arg1.rewarder, v0, arg1.total_volume, arg2, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public fun set_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<PORT>(arg0), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::not_owner());
        let v0 = update_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::display::Display<PortEntry>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun start_vault<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_operation_manager_role(arg1, 0x2::tx_context::sender(arg8)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg8)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_operation_manager_permission());
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::vault_not_stopped());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let (v0, v1) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::start_vault<T0, T1>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::withdraw_all<T0>(&mut arg0.buffer_assets), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::withdraw_all<T1>(&mut arg0.buffer_assets), arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T0>(&mut arg0.buffer_assets, v3);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T1>(&mut arg0.buffer_assets, v2);
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
        let v4 = StartVaultEvent{
            port_id          : 0x2::object::id<Port>(arg0),
            buffer_balance_a : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.buffer_assets),
            buffer_balance_b : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T1>(&arg0.buffer_assets),
        };
        0x2::event::emit<StartVaultEvent>(v4);
        let v5 = NewVaultPositionEvent{
            port_id           : 0x2::object::id<Port>(arg0),
            vault_position_id : 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::position_id(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::borrow_staked_position(&arg0.vault)),
        };
        0x2::event::emit<NewVaultPositionEvent>(v5);
    }

    public fun stop_vault<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_operation_manager_role(arg1, 0x2::tx_context::sender(arg8)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg8)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_operation_manager_permission());
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(!0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::vault_is_stopped());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let (v0, v1) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::stop_vault<T0, T1>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T0>(&mut arg0.buffer_assets, v0);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T1>(&mut arg0.buffer_assets, v1);
        let v2 = StopVaultEvent{
            port_id          : 0x2::object::id<Port>(arg0),
            buffer_balance_a : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.buffer_assets),
            buffer_balance_b : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T1>(&arg0.buffer_assets),
        };
        0x2::event::emit<StopVaultEvent>(v2);
    }

    fun take_protocol_asset<T0>(arg0: &mut Port) : 0x2::balance::Balance<T0> {
        let (v0, _) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_utils::remove_balance_from_bag<T0>(&mut arg0.protocol_fees, 0, true);
        v0
    }

    public fun total_volume(arg0: &Port) : u64 {
        arg0.total_volume
    }

    public fun unpause(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_pool_manager_role(arg1, 0x2::tx_context::sender(arg2)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg2)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_pool_manager_permission());
        arg0.is_pause = false;
        let v0 = UnpauseEvent{port_id: 0x2::object::id<Port>(arg0)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    fun update_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<PortEntry> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg1);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg5);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg6);
        let v2 = 0x2::display::new_with_fields<PortEntry>(arg0, v0, v1, arg7);
        0x2::display::update_version<PortEntry>(&mut v2);
        v2
    }

    public fun update_hard_cap(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_pool_manager_role(arg1, 0x2::tx_context::sender(arg3)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg3)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_pool_manager_permission());
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        arg0.hard_cap = arg2;
        let v0 = UpdateHardCapEvent{
            port_id      : 0x2::object::id<Port>(arg0),
            old_hard_cap : arg0.hard_cap,
            new_hard_cap : arg2,
        };
        0x2::event::emit<UpdateHardCapEvent>(v0);
    }

    public fun update_liquidity_offset<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: u32, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_pool_manager_role(arg1, 0x2::tx_context::sender(arg10)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg10)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_pool_manager_permission());
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let (v0, v1, _) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::get_liquidity_range(&arg0.vault);
        assert!(arg7 != v0 || arg8 != v1, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::liquidity_range_not_change());
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::update_liquidity_offset(&mut arg0.vault, arg7, arg8);
        let (v3, v4, v5) = check_need_rebalance<T0, T1>(arg0, arg3, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::tick_spacing<T0, T1>(arg6), 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_tick_index<T0, T1>(arg6), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::rebalance_threshold(&arg0.vault));
        if (v3 && !0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::is_stopped(&arg0.vault)) {
            rebalance_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, v4, v5, arg9, arg10);
        };
        let v6 = UpdateLiquidityOffsetEvent{
            port_id          : 0x2::object::id<Port>(arg0),
            old_lower_offset : v0,
            old_upper_offset : v1,
            new_lower_offset : arg7,
            new_upper_offset : arg8,
        };
        0x2::event::emit<UpdateLiquidityOffsetEvent>(v6);
    }

    public fun update_pool_reward<T0, T1, T2>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::rewarders(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::rewarder_manager<T0, T1>(arg6));
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::Rewarder>(&v1)) {
            let v4 = *0x1::vector::borrow<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::Rewarder>(&v1, v3);
            if (0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::reward_coin(&v4) == v0) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::reward_types_not_match());
        let (v5, v6) = if (!is_stopped(arg0)) {
            let v7 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::collect_pool_reward<T0, T1, T2>(&arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7);
            if (0x2::balance::value<T2>(&v7) > 0) {
                let v8 = &mut v7;
                merge_protocol_asset<T2>(arg0, v8);
                let v9 = 0x2::balance::value<T2>(&v7);
                if (v0 == 0x1::type_name::with_defining_ids<T0>() || v0 == 0x1::type_name::with_defining_ids<T1>()) {
                    0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T2>(&mut arg0.pool_token_reward_balance, v7);
                } else {
                    0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T2>(&mut arg0.buffer_assets, v7);
                };
                let v10 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.reward_growth, &v0)) {
                    let (_, v12) = 0x2::vec_map::remove<0x1::type_name::TypeName, u128>(&mut arg0.reward_growth, &v0);
                    v12
                } else {
                    0
                };
                let (v13, v14) = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::overflowing_add(v10, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((v9 as u128), 18446744073709551616, (arg0.total_volume as u128)));
                assert!(!v14, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::growth_overflow());
                (v9, v13)
            } else {
                0x2::balance::destroy_zero<T2>(v7);
                let v15 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.reward_growth, &v0)) {
                    let (_, v17) = 0x2::vec_map::remove<0x1::type_name::TypeName, u128>(&mut arg0.reward_growth, &v0);
                    v17
                } else {
                    0
                };
                (0, v15)
            }
        } else {
            let v18 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.reward_growth, &v0)) {
                let (_, v20) = 0x2::vec_map::remove<0x1::type_name::TypeName, u128>(&mut arg0.reward_growth, &v0);
                v20
            } else {
                0
            };
            (0, v18)
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.reward_growth, v0, v6);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.last_update_growth_time_ms, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.last_update_growth_time_ms, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.last_update_growth_time_ms, v0, 0x2::clock::timestamp_ms(arg7));
        let v23 = UpdatePoolRewardEvent{
            port_id     : 0x2::object::id<Port>(arg0),
            reward_type : 0x1::type_name::with_defining_ids<T2>(),
            amount      : v5,
            new_growth  : v6,
            update_time : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<UpdatePoolRewardEvent>(v23);
    }

    public fun update_position_reward<T0, T1, T2, T3>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T2>, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg5) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        let v0 = 0x1::type_name::with_defining_ids<T3>();
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::reward_manager::settle(&mut arg0.rewarder, 0x2::object::id<Port>(arg0), arg0.total_volume, 0x2::clock::timestamp_ms(arg6) / 1000);
        let (v1, v2) = if (!is_stopped(arg0)) {
            let v3 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::collect_position_reward<T0, T1, T2, T3>(&arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7);
            let v4 = &mut v3;
            merge_protocol_asset<T3>(arg0, v4);
            let v5 = 0x2::balance::value<T3>(&v3);
            0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::join<T3>(&mut arg0.osail_reward_balances, v3);
            let v6 = if (0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0)) {
                0x2::linked_table::remove<0x1::type_name::TypeName, u128>(&mut arg0.osail_growth_global, v0)
            } else {
                let v7 = 0x2::linked_table::back<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global);
                if (0x1::option::is_some<0x1::type_name::TypeName>(v7)) {
                    *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, *0x1::option::borrow<0x1::type_name::TypeName>(v7))
                } else {
                    0
                }
            };
            let (v8, v9) = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::overflowing_add(v6, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((v5 as u128), 18446744073709551616, (arg0.total_volume as u128)));
            assert!(!v9, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::growth_overflow());
            0x2::linked_table::push_back<0x1::type_name::TypeName, u128>(&mut arg0.osail_growth_global, v0, v8);
            (v5, v8)
        } else {
            let v10 = if (0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0)) {
                *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.osail_growth_global, v0)
            } else {
                0
            };
            (0, v10)
        };
        arg0.last_update_osail_growth_time_ms = 0x2::clock::timestamp_ms(arg6);
        let v11 = OsailRewardUpdatedEvent{
            port_id         : 0x2::object::id<Port>(arg0),
            osail_coin_type : v0,
            amount_osail    : v1,
            new_growth      : v2,
            update_time     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<OsailRewardUpdatedEvent>(v11);
    }

    public fun update_protocol_fee(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 13906848210296504319
    }

    public fun update_protocol_fee_v2<T0, T1>(arg0: &mut Port, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg2);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::check_pool_manager_role(arg2, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        assert!(arg3 <= 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::get_max_protocol_fee_rate(), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::invalid_protocol_fee_rate());
        check_updated_rewards<T0, T1>(arg0, arg1, arg4);
        arg0.protocol_fee_rate = arg3;
        let v0 = UpdateProtocolFeeEvent{
            port_id               : 0x2::object::id<Port>(arg0),
            old_protocol_fee_rate : arg0.protocol_fee_rate,
            new_protocol_fee_rate : arg3,
        };
        0x2::event::emit<UpdateProtocolFeeEvent>(v0);
    }

    public fun update_rebalance_threshold(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::is_pool_manager_role(arg1, 0x2::tx_context::sender(arg3)) || 0x2::linked_table::contains<address, bool>(&arg0.managers, 0x2::tx_context::sender(arg3)), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::no_pool_manager_permission());
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        let (_, _, v2) = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::get_liquidity_range(&arg0.vault);
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::update_rebalance_threshold(&mut arg0.vault, arg2);
        let v3 = UpdateRebalanceThresholdEvent{
            port_id                 : 0x2::object::id<Port>(arg0),
            old_rebalance_threshold : v2,
            new_rebalance_threshold : arg2,
        };
        0x2::event::emit<UpdateRebalanceThresholdEvent>(v3);
    }

    public fun withdraw<T0, T1>(arg0: &mut Port, arg1: &0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::GlobalConfig, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: &mut PortEntry, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault_config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::port_is_pause());
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6) == 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::pool_id(&arg0.vault), 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::clmm_pool_not_match());
        assert!(arg8 > 0, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_is_zero());
        assert!(arg8 <= arg7.volume, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_not_enough());
        let v0 = *0x2::tx_context::digest(arg12);
        assert!(v0 != arg0.status.last_deposit_tx, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::operation_not_allowed());
        assert!(v0 != arg0.status.last_withdraw_tx, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::operation_not_allowed());
        arg0.status.last_withdraw_tx = v0;
        check_claimed_rewards<T0, T1>(arg0, arg6, arg7, arg11);
        arg7.volume = arg7.volume - arg8;
        let v1 = arg0.total_volume;
        let v2 = *0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::balances(&arg0.buffer_assets);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let (_, v5) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v2, &v3);
        let v6 = 0x1::type_name::with_defining_ids<T1>();
        let (_, v8) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v2, &v6);
        let v9 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::split<T0>(&mut arg0.buffer_assets, (get_user_share_by_volume(v1, arg8, (v5 as u128)) as u64));
        let v10 = 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::split<T1>(&mut arg0.buffer_assets, (get_user_share_by_volume(v1, arg8, (v8 as u128)) as u64));
        let v11 = if (!is_stopped(arg0)) {
            let v12 = get_user_share_by_volume(v1, arg8, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::get_position_liquidity<T0, T1>(&arg0.vault, arg3));
            let (v13, v14) = if (v12 > 0) {
                0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::vault::decrease_liquidity<T0, T1>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, v12, arg11, arg12)
            } else {
                (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
            };
            let v15 = v14;
            let v16 = v13;
            assert!(0x2::balance::value<T0>(&v16) >= arg9, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_not_enough());
            assert!(0x2::balance::value<T1>(&v15) >= arg10, 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::error::token_amount_not_enough());
            0x2::balance::join<T0>(&mut v9, v16);
            0x2::balance::join<T1>(&mut v10, v15);
            v12
        } else {
            0
        };
        let v17 = WithdrawEvent{
            port_id         : 0x2::object::id<Port>(arg0),
            port_entry_id   : 0x2::object::id<PortEntry>(arg7),
            volume_withdraw : arg8,
            liquidity       : v11,
            amount_a        : 0x2::balance::value<T0>(&v9),
            amount_b        : 0x2::balance::value<T1>(&v10),
            remained_a      : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T0>(&arg0.buffer_assets),
            remained_b      : 0x1507d872386da97dc346d4adfab5170fe542f8b8ec412b270432cab651aef211::balance_bag::value<T1>(&arg0.buffer_assets),
        };
        0x2::event::emit<WithdrawEvent>(v17);
        arg0.total_volume = arg0.total_volume - arg8;
        (0x2::coin::from_balance<T0>(v9, arg12), 0x2::coin::from_balance<T1>(v10, arg12))
    }

    // decompiled from Move bytecode v6
}

