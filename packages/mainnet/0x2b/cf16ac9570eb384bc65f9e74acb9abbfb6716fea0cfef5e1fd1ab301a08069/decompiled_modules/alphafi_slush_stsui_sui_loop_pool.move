module 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_pool {
    struct SupplyToken<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        principal: u64,
        xtokens: 0x2::balance::Balance<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>,
    }

    struct ExternalRewardsInfo has store {
        reward_balance: 0x2::balance::Balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>,
        reward_per_ms: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        start_time: u64,
        end_time: u64,
        last_updated_timestamp: u64,
        fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        slush_fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        fee_balance: 0x2::balance::Balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>,
    }

    struct GrowthBasedFees has store {
        fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        all_time_collected: u64,
        pending: 0x2::balance::Balance<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>,
        last_fee_collected_exchange_rate: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        slush_fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        fee_address: address,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        xTokenSupply: 0x2::balance::Supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>,
        tokensInvested: u64,
        deposit_limit: u64,
        growth_based_fees: GrowthBasedFees,
        external_rewards_info: ExternalRewardsInfo,
        positions: 0x2::object_table::ObjectTable<0x2::object::ID, Position>,
        fee_collected: 0x2::balance::Balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        fee_address: address,
        slush_fee_address: address,
        paused: bool,
        investor: 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>,
    }

    struct CollectGrowthBasedFeesEvent has copy, drop {
        pool_id: 0x2::object::ID,
        collected_amount: u64,
        slush_collected: u64,
        all_time_collected: u64,
    }

    struct PoolRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct ExternalRewardAddEvent has copy, drop {
        pool_id: 0x2::object::ID,
        total_balance: u64,
        effective_start_time: u64,
        end_time: u64,
        current_time: u64,
    }

    struct XtokenRatioChangeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        x_token_supply: u64,
        old_tokens_invested: u64,
        new_tokens_invested: u64,
    }

    struct LiquidityChangeEvent has copy, drop {
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        event_type: u8,
        fee_collected: u64,
        amount: u64,
        current_total_xtoken_balance_in_position: u64,
        principal: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        sender: address,
    }

    public fun admin_borrow(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::admin_borrow(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8);
        update_pool(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    public fun admin_repay(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::admin_repay(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8);
        update_pool(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    public fun collect_reward_and_swap_bluefin<T0, T1>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool, arg2: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: bool, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::collect_reward_and_swap_bluefin<T0, T1>(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::none<u64>(), false, arg9, arg10);
    }

    public fun emergency_repay(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::emergency_repay(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6);
        update_pool(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_safe_borrow_percentage_bps(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg3 <= 10000, 1035);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::set_safe_borrow_percentage_bps(&mut arg2.investor, arg3);
    }

    public fun add_external_rewards(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: u64, arg5: u64, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg9), 1003);
        assert!(arg4 < arg5, 1004);
        assert!(arg5 >= arg2.external_rewards_info.end_time, 1005);
        update_pool(arg1, arg2, arg6, arg7, arg8, arg9, arg10);
        0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg2.external_rewards_info.reward_balance, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3));
        let v0 = if (arg2.external_rewards_info.last_updated_timestamp == arg2.external_rewards_info.end_time) {
            arg4
        } else {
            arg2.external_rewards_info.last_updated_timestamp
        };
        arg2.external_rewards_info.start_time = v0;
        arg2.external_rewards_info.end_time = arg5;
        arg2.external_rewards_info.reward_per_ms = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg2.external_rewards_info.reward_balance)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg5 - arg2.external_rewards_info.start_time));
        let v1 = ExternalRewardAddEvent{
            pool_id              : 0x2::object::id<Pool>(arg2),
            total_balance        : 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg2.external_rewards_info.reward_balance),
            effective_start_time : arg2.external_rewards_info.start_time,
            end_time             : arg5,
            current_time         : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<ExternalRewardAddEvent>(v1);
    }

    public fun admin_add_allowed_bluefin_pool<T0, T1>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::add_allowed_pool(&mut arg2.investor, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), arg4);
    }

    public fun admin_collect_reward_and_swap_bluefin<T0, T1>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: bool, arg8: bool, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::collect_reward_and_swap_bluefin<T0, T1>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun admin_remove_allowed_bluefin_pool<T0, T1>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::remove_allowed_pool(&mut arg2.investor, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3));
    }

    public fun admin_remove_coin_swap_info(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: 0x1::type_name::TypeName) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::remove_coin_swap_info(&mut arg2.investor, arg3);
    }

    public fun admin_set_coin_swap_info(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: 0x1::type_name::TypeName, arg4: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::set_coin_swap_info(&mut arg2.investor, arg3, arg4);
    }

    public fun admin_set_max_price_age_secs(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::set_max_price_age_secs(&mut arg2.investor, arg3);
    }

    entry fun change_fee_address(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.fee_address = arg3;
    }

    fun charge_and_increase_pending_growth_based_fees(arg0: &mut Pool, arg1: u64) {
        let v0 = 0x1::u64::min(arg1, arg0.tokensInvested);
        arg0.tokensInvested = arg0.tokensInvested - v0;
        let v1 = exchange_rate(arg0);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v1, arg0.growth_based_fees.last_fee_collected_exchange_rate)) {
            let v2 = &mut arg0.growth_based_fees;
            let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v2.last_fee_collected_exchange_rate, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v1, v2.last_fee_collected_exchange_rate), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), v2.fee_bps)))));
            let v4 = v3 - 0x1::u64::min(v3, 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply));
            if (v4 > 0) {
                0x2::balance::join<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut v2.pending, 0x2::balance::increase_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.xTokenSupply, v4));
            };
        };
        arg0.tokensInvested = arg0.tokensInvested + v0;
        let v5 = exchange_rate(arg0);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v5, arg0.growth_based_fees.last_fee_collected_exchange_rate)) {
            arg0.growth_based_fees.last_fee_collected_exchange_rate = v5;
        };
    }

    entry fun collect_fee(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::balance::withdraw_all<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg1.fee_collected), arg2), arg1.fee_address);
    }

    public fun collect_growth_based_fees(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        update_pool(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>();
        let v1 = 0;
        let v2 = v1;
        let v3 = 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg1.growth_based_fees.pending);
        if (v3 > 0) {
            let v4 = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::withdraw_from_alphalend(&mut arg1.investor, arg2, arg3, arg4, v3, 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg1.xTokenSupply), arg5, arg6);
            0x2::balance::decrease_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg1.xTokenSupply, 0x2::balance::withdraw_all<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg1.growth_based_fees.pending));
            v2 = v1 + 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v4)), arg1.growth_based_fees.slush_fee_bps));
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v0, v4);
        };
        let v5 = 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg1.external_rewards_info.fee_balance);
        if (v5 > 0) {
            v2 = v2 + 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v5), arg1.external_rewards_info.slush_fee_bps));
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v0, 0x2::balance::withdraw_all<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg1.external_rewards_info.fee_balance));
        };
        if (0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v0);
            return
        };
        arg1.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::total_supplied_without_debt(&arg1.investor, arg2, arg3, arg5);
        let v6 = 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0);
        arg1.growth_based_fees.all_time_collected = arg1.growth_based_fees.all_time_collected + v6;
        let v7 = 0x1::u64::min(v2, 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0));
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v0, v7), arg6), arg1.slush_fee_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v0, arg6), arg1.growth_based_fees.fee_address);
        let v8 = CollectGrowthBasedFeesEvent{
            pool_id            : 0x2::object::id<Pool>(arg1),
            collected_amount   : v6,
            slush_collected    : v7,
            all_time_collected : arg1.growth_based_fees.all_time_collected,
        };
        0x2::event::emit<CollectGrowthBasedFeesEvent>(v8);
    }

    public fun create_pool(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: address, arg11: address, arg12: u64, arg13: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg14: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        let v0 = SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>{dummy_field: false};
        let v1 = GrowthBasedFees{
            fee_bps                          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg7),
            all_time_collected               : 0,
            pending                          : 0x2::balance::zero<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(),
            last_fee_collected_exchange_rate : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1),
            slush_fee_bps                    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg8),
            fee_address                      : arg9,
        };
        let v2 = ExternalRewardsInfo{
            reward_balance         : 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            reward_per_ms          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            start_time             : 0,
            end_time               : 0,
            last_updated_timestamp : 0,
            fee_bps                : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg5),
            slush_fee_bps          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg6),
            fee_balance            : 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
        };
        let v3 = Pool{
            id                    : 0x2::object::new(arg14),
            xTokenSupply          : 0x2::balance::create_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(v0),
            tokensInvested        : 0,
            deposit_limit         : arg12,
            growth_based_fees     : v1,
            external_rewards_info : v2,
            positions             : 0x2::object_table::new<0x2::object::ID, Position>(arg14),
            fee_collected         : 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            deposit_fee           : 0,
            deposit_fee_max_cap   : 100,
            withdrawal_fee        : 0,
            withdraw_fee_max_cap  : 100,
            fee_address           : arg11,
            slush_fee_address     : arg10,
            paused                : false,
            investor              : 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::create_investor(arg2, arg13, arg3, arg4, arg14),
        };
        0x2::transfer::public_share_object<Pool>(v3);
    }

    fun create_position(arg0: &mut 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::object_table::contains<0x2::object::ID, Position>(&arg1.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg0)), 1001);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::id<Pool>(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::insert(arg0, 0x2::object::uid_to_inner(&v0), v1);
        let v2 = Position{
            id              : v0,
            position_cap_id : 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg0),
            pool_id         : v1,
            coin_type       : 0x1::type_name::with_defining_ids<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            principal       : 0,
            xtokens         : 0x2::balance::zero<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(),
        };
        0x2::object_table::add<0x2::object::ID, Position>(&mut arg1.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg0), v2);
    }

    fun distribute_external_rewards(arg0: &mut Pool, arg1: &0x2::clock::Clock) : u64 {
        let v0 = &mut arg0.external_rewards_info;
        if (0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0.reward_balance) == 0) {
            return 0
        };
        let v1 = 0x1::u64::max(v0.start_time, v0.last_updated_timestamp);
        let v2 = 0x1::u64::min(v0.end_time, 0x2::clock::timestamp_ms(arg1));
        if (v2 <= v1) {
            return 0
        };
        let v3 = 0x1::u64::min(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2 - v1), v0.reward_per_ms)), 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0.reward_balance));
        if (v3 == 0) {
            return 0
        };
        v0.last_updated_timestamp = v2;
        let v4 = 0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v0.reward_balance, v3);
        let v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v3), v0.fee_bps));
        if (v5 > 0) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v0.fee_balance, 0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v4, v5));
        };
        let v6 = PoolRewardEvent{
            pool_id   : 0x2::object::id<Pool>(arg0),
            amount    : v3,
            coin_type : 0x1::type_name::with_defining_ids<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
        };
        0x2::event::emit<PoolRewardEvent>(v6);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::update_free_rewards<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg0.investor, v4);
        0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v4)
    }

    fun exchange_rate(arg0: &Pool) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (arg0.tokensInvested == 0 || 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply) == 0) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply)))
        }
    }

    fun internal_deposit(arg0: &mut Pool, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg2: 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg2) as u128) * (arg0.deposit_fee as u128) / 10000;
        0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg0.fee_collected, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::coin::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg2, (v0 as u64), arg7)));
        let v1 = 0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg2);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::deposit(&mut arg0.investor, arg3, arg4, arg5, arg2, arg6, arg7);
        arg0.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::total_supplied_without_debt(&arg0.investor, arg3, arg4, arg6);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested)))), exchange_rate(arg0)));
        assert!(v2 > 0, 1012);
        0x2::balance::join<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)).xtokens, 0x2::balance::increase_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.xTokenSupply, (v2 as u64)));
        let v3 = &mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)).principal;
        *v3 = *v3 + v1;
        let v4 = LiquidityChangeEvent{
            position_cap_id                          : 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg0.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1))),
            event_type                               : 0,
            fee_collected                            : (v0 as u64),
            amount                                   : v1,
            current_total_xtoken_balance_in_position : 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)).xtokens),
            principal                                : *v3,
            x_token_supply                           : 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply),
            tokens_invested                          : arg0.tokensInvested,
            sender                                   : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<LiquidityChangeEvent>(v4);
    }

    fun internal_withdraw(arg0: &mut Pool, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI> {
        let v0 = 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)).xtokens);
        assert!(v0 >= arg2, 1014);
        assert!(arg2 > 0, 1015);
        let v1 = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::withdraw_from_alphalend(&mut arg0.investor, arg3, arg4, arg5, arg2, 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply), arg6, arg7);
        let v2 = &mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)).principal;
        *v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg2)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0))));
        let v3 = *v2;
        0x2::balance::decrease_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.xTokenSupply, 0x2::balance::split<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)).xtokens, arg2));
        arg0.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::total_supplied_without_debt(&arg0.investor, arg3, arg4, arg6);
        let v4 = (0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1) as u128) * (arg0.withdrawal_fee as u128) / 10000;
        0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg0.fee_collected, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v1, (v4 as u64)), arg7)));
        let v5 = LiquidityChangeEvent{
            position_cap_id                          : 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg0.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1))),
            event_type                               : 1,
            fee_collected                            : (v4 as u64),
            amount                                   : 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1),
            current_total_xtoken_balance_in_position : 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)).xtokens),
            principal                                : v3,
            x_token_supply                           : 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply),
            tokens_invested                          : arg0.tokensInvested,
            sender                                   : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<LiquidityChangeEvent>(v5);
        0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v1, arg7)
    }

    entry fun set_deposit_fee(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 1002);
        arg2.deposit_fee = arg3;
    }

    public fun set_external_reward_fees(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        update_pool(arg1, arg2, arg3, arg4, arg5, arg8, arg9);
        assert!(arg7 <= 10000 && arg6 <= 10000, 1034);
        arg2.external_rewards_info.fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg6);
        arg2.external_rewards_info.slush_fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg7);
    }

    public fun set_growth_fee_address(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.growth_based_fees.fee_address = arg3;
    }

    public fun set_growth_fee_bps(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        update_pool(arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        assert!(arg6 <= 10000, 1034);
        arg2.growth_based_fees.fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg6);
    }

    public fun set_growth_slush_fee_bps(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        update_pool(arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        assert!(arg6 <= 10000, 1034);
        arg2.growth_based_fees.slush_fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg6);
    }

    entry fun set_pause(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: bool) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.paused = arg3;
    }

    public fun set_slush_fee_address(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.slush_fee_address = arg3;
    }

    entry fun set_withdrawal_fee(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 1002);
        arg2.withdrawal_fee = arg3;
    }

    public fun update_deposit_limit(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.deposit_limit = arg3;
    }

    public fun update_pool(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        let v0 = distribute_external_rewards(arg1, arg5);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::autocompound(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::fix_ratio(&mut arg1.investor, arg2, arg3, arg5);
        let v1 = arg1.tokensInvested;
        arg1.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::total_supplied_without_debt(&arg1.investor, arg2, arg3, arg5);
        charge_and_increase_pending_growth_based_fees(arg1, v0);
        let v2 = XtokenRatioChangeEvent{
            pool_id             : 0x2::object::id<Pool>(arg1),
            x_token_supply      : 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg1.xTokenSupply),
            old_tokens_invested : 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::convert_stsui_amount_to_sui(arg3, v1),
            new_tokens_invested : 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphafi_slush_stsui_sui_loop_investor::convert_stsui_amount_to_sui(arg3, arg1.tokensInvested),
        };
        0x2::event::emit<XtokenRatioChangeEvent>(v2);
    }

    public fun user_deposit(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg2: &mut Pool, arg3: 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(arg2.paused == false, 1011);
        if (!0x2::object_table::contains<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1))) {
            create_position(arg1, arg2, arg8);
        };
        assert!(0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg3) > 0, 1012);
        update_pool(arg0, arg2, arg4, arg5, arg6, arg7, arg8);
        assert!(arg2.tokensInvested + 0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg3) <= arg2.deposit_limit, 1032);
        internal_deposit(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun user_withdraw(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg2: &mut Pool, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI> {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(arg2.paused == false, 1011);
        update_pool(arg0, arg2, arg4, arg5, arg6, arg7, arg8);
        assert!(0x2::object_table::contains<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)), 1013);
        let v0 = internal_withdraw(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
        if (0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&0x2::object_table::borrow<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1)).xtokens) == 0) {
            let Position {
                id              : v1,
                position_cap_id : _,
                pool_id         : _,
                coin_type       : _,
                principal       : _,
                xtokens         : v6,
            } = 0x2::object_table::remove<0x2::object::ID, Position>(&mut arg2.positions, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1));
            let v7 = v1;
            let (_, _) = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::remove(arg1, 0x2::object::uid_to_inner(&v7));
            0x2::object::delete(v7);
            0x2::balance::destroy_zero<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(v6);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

