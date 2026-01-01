module 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_pool {
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

    struct TimeBasedReward has store {
        reward_balance: 0x2::balance::Balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>,
        start_time: u64,
        end_time: u64,
        reward_per_ms: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_updated_timestamp: u64,
    }

    struct GrowthBasedFees has store {
        fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        all_time_collected: u64,
        pending: 0x2::balance::Balance<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>,
        last_fee_collected_exchange_rate: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        fee_address: address,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        xTokenSupply: 0x2::balance::Supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>,
        tokensInvested: u64,
        growth_based_fees: GrowthBasedFees,
        time_based_rewards_data: TimeBasedReward,
        positions: 0x2::object_table::ObjectTable<0x2::object::ID, Position>,
        fee_collected: 0x2::balance::Balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        fee_address: address,
        paused: bool,
        investor: 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>,
    }

    struct CollectGrowthBasedFeesEvent has copy, drop {
        pending: u64,
        all_time: u64,
        collected: u64,
    }

    struct TimeBasedRewardAddEvent has copy, drop {
        total_balance: u64,
        effective_start_time: u64,
        end_time: u64,
        current_time: u64,
    }

    struct LessTimeBasedRewardsEvent has copy, drop {
        rewards_to_split: u64,
        reward_balance: u64,
        reward_per_ms: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
    }

    struct XtokenRatioChangeEvent has copy, drop {
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

    public fun add_or_remove_coin_type_for_swap(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: 0x1::type_name::TypeName, arg4: bool) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::add_or_remove_coin_type_for_swap(&mut arg2.investor, arg3, arg4);
    }

    public fun admin_borrow(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::admin_borrow(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8);
        update_pool(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    public fun admin_repay(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::admin_repay(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8);
        update_pool(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    public fun collect_reward_and_swap_bluefin<T0, T1>(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg1: &mut Pool, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg0);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::collect_reward_and_swap_bluefin<T0, T1>(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun emergency_repay(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: u256, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::emergency_repay(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8);
        update_pool(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun set_minimum_swap_amount(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: u64) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::set_minimum_swap_amount(&mut arg2.investor, arg3);
    }

    public fun add_time_based_reward(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg1: &mut Pool, arg2: 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg0);
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg5), 1003);
        assert!(arg3 < arg4, 1004);
        assert!(arg4 >= arg1.time_based_rewards_data.end_time, 1005);
        collect_time_based_reward(arg1, arg5);
        0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg1.time_based_rewards_data.reward_balance, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2));
        let v0 = if (arg1.time_based_rewards_data.last_updated_timestamp == arg1.time_based_rewards_data.end_time) {
            arg3
        } else {
            arg1.time_based_rewards_data.last_updated_timestamp
        };
        arg1.time_based_rewards_data.start_time = v0;
        arg1.time_based_rewards_data.end_time = arg4;
        arg1.time_based_rewards_data.reward_per_ms = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg1.time_based_rewards_data.reward_balance)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg4 - arg1.time_based_rewards_data.start_time));
        let v1 = TimeBasedRewardAddEvent{
            total_balance        : 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg1.time_based_rewards_data.reward_balance),
            effective_start_time : arg1.time_based_rewards_data.start_time,
            end_time             : arg4,
            current_time         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TimeBasedRewardAddEvent>(v1);
    }

    entry fun change_fee_address(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: address) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        arg2.fee_address = arg3;
    }

    fun charge_and_increase_pending_growth_based_fees(arg0: &mut Pool) {
        let v0 = exchange_rate(arg0);
        let v1 = &mut arg0.growth_based_fees;
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v0, v1.last_fee_collected_exchange_rate)) {
            let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v1.last_fee_collected_exchange_rate, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v0, v1.last_fee_collected_exchange_rate), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), v1.fee_bps)));
            let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), v2));
            0x2::balance::join<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut v1.pending, 0x2::balance::increase_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.xTokenSupply, v3 - 0x1::u64::min(v3, 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply))));
            v1.last_fee_collected_exchange_rate = v2;
        };
    }

    entry fun collect_fee(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::balance::withdraw_all<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg1.fee_collected), arg2), arg1.fee_address);
    }

    public fun collect_growth_based_fees(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg1: &mut Pool, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg0);
        let v0 = &mut arg1.growth_based_fees;
        let v1 = 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::withdraw_from_alphalend(&mut arg1.investor, arg2, arg3, arg4, 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&v0.pending), 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg1.xTokenSupply), arg5, arg6);
        0x2::balance::decrease_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg1.xTokenSupply, 0x2::balance::withdraw_all<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut v0.pending));
        v0.all_time_collected = v0.all_time_collected + 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1);
        let v2 = CollectGrowthBasedFeesEvent{
            pending   : 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&v0.pending),
            all_time  : v0.all_time_collected,
            collected : 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1),
        };
        0x2::event::emit<CollectGrowthBasedFeesEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v1, arg6), v0.fee_address);
    }

    fun collect_time_based_reward(arg0: &mut Pool, arg1: &0x2::clock::Clock) {
        let v0 = &mut arg0.time_based_rewards_data;
        let v1 = 0x1::u64::max(v0.start_time, v0.last_updated_timestamp);
        let v2 = 0x1::u64::min(v0.end_time, 0x2::clock::timestamp_ms(arg1));
        if (v2 <= v1) {
            return
        };
        let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2 - v1), v0.reward_per_ms));
        let v4 = v3;
        if (v3 > 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0.reward_balance)) {
            let v5 = LessTimeBasedRewardsEvent{
                rewards_to_split : v3,
                reward_balance   : 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0.reward_balance),
                reward_per_ms    : v0.reward_per_ms,
            };
            0x2::event::emit<LessTimeBasedRewardsEvent>(v5);
            v4 = 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0.reward_balance);
        };
        if (v4 == 0) {
            return
        };
        v0.last_updated_timestamp = v2;
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::update_free_rewards<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg0.investor, 0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v0.reward_balance, v4));
    }

    public fun create_pool(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        let v0 = SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>{dummy_field: false};
        let v1 = GrowthBasedFees{
            fee_bps                          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg5),
            all_time_collected               : 0,
            pending                          : 0x2::balance::zero<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(),
            last_fee_collected_exchange_rate : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1),
            fee_address                      : arg6,
        };
        let v2 = TimeBasedReward{
            reward_balance         : 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            start_time             : 0,
            end_time               : 0,
            reward_per_ms          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            last_updated_timestamp : 0,
        };
        let v3 = Pool{
            id                      : 0x2::object::new(arg9),
            xTokenSupply            : 0x2::balance::create_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(v0),
            tokensInvested          : 0,
            growth_based_fees       : v1,
            time_based_rewards_data : v2,
            positions               : 0x2::object_table::new<0x2::object::ID, Position>(arg9),
            fee_collected           : 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            deposit_fee             : 0,
            deposit_fee_max_cap     : 100,
            withdrawal_fee          : 0,
            withdraw_fee_max_cap    : 100,
            fee_address             : arg7,
            paused                  : false,
            investor                : 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::create_investor(arg2, arg8, arg3, arg4, arg9),
        };
        0x2::transfer::public_share_object<Pool>(v3);
    }

    fun create_position(arg0: &mut 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::object_table::contains<0x2::object::ID, Position>(&arg1.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg0)), 1001);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::id<Pool>(arg1);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::insert(arg0, 0x2::object::uid_to_inner(&v0), v1);
        let v2 = Position{
            id              : v0,
            position_cap_id : 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg0),
            pool_id         : v1,
            coin_type       : 0x1::type_name::with_defining_ids<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            principal       : 0,
            xtokens         : 0x2::balance::zero<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(),
        };
        0x2::object_table::add<0x2::object::ID, Position>(&mut arg1.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg0), v2);
    }

    fun exchange_rate(arg0: &Pool) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (arg0.tokensInvested == 0 || 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply) == 0) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply)))
        }
    }

    fun internal_deposit(arg0: &mut Pool, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap, arg2: 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg2) as u128) * (arg0.deposit_fee as u128) / 10000;
        0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg0.fee_collected, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::coin::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg2, (v0 as u64), arg7)));
        let v1 = 0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg2);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::deposit(&mut arg0.investor, arg3, arg4, arg5, arg2, arg6, arg7);
        arg0.tokensInvested = 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::total_supplied_without_debt(&arg0.investor, arg3, arg4, arg6);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested - arg0.tokensInvested), exchange_rate(arg0)));
        assert!(v2 > 0, 1012);
        0x2::balance::join<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)).xtokens, 0x2::balance::increase_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.xTokenSupply, (v2 as u64)));
        let v3 = &mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)).principal;
        *v3 = *v3 + v1;
        let v4 = LiquidityChangeEvent{
            position_cap_id                          : 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg0.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1))),
            event_type                               : 0,
            fee_collected                            : (v0 as u64),
            amount                                   : v1,
            current_total_xtoken_balance_in_position : 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)).xtokens),
            principal                                : *v3,
            x_token_supply                           : 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply),
            tokens_invested                          : arg0.tokensInvested,
            sender                                   : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<LiquidityChangeEvent>(v4);
    }

    fun internal_withdraw(arg0: &mut Pool, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI> {
        let v0 = 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)).xtokens);
        assert!(v0 >= arg2, 1014);
        assert!(arg2 > 0, 1015);
        let v1 = 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::withdraw_from_alphalend(&mut arg0.investor, arg3, arg4, arg5, arg2, 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply), arg6, arg7);
        let v2 = &mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)).principal;
        *v2 = (((*v2 as u256) - (*v2 as u256) * (arg2 as u256) / (v0 as u256)) as u64);
        let v3 = *v2;
        0x2::balance::decrease_supply<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.xTokenSupply, 0x2::balance::split<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)).xtokens, arg2));
        arg0.tokensInvested = 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::total_supplied_without_debt(&arg0.investor, arg3, arg4, arg6);
        let v4 = (0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1) as u128) * (arg0.withdrawal_fee as u128) / 10000;
        0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut arg0.fee_collected, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v1, (v4 as u64)), arg7)));
        let v5 = LiquidityChangeEvent{
            position_cap_id                          : 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg0.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1))),
            event_type                               : 1,
            fee_collected                            : (v4 as u64),
            amount                                   : 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1),
            current_total_xtoken_balance_in_position : 0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)).xtokens),
            principal                                : v3,
            x_token_supply                           : 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg0.xTokenSupply),
            tokens_invested                          : arg0.tokensInvested,
            sender                                   : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<LiquidityChangeEvent>(v5);
        0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v1, arg7)
    }

    entry fun set_deposit_fee(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: u64) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 1002);
        arg2.deposit_fee = arg3;
    }

    entry fun set_pause(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: bool) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        arg2.paused = arg3;
    }

    entry fun set_withdrawal_fee(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: u64) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 1002);
        arg2.withdrawal_fee = arg3;
    }

    public fun update_growth_based_fees_address(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: address) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        arg2.growth_based_fees.fee_address = arg3;
    }

    public fun update_growth_based_fees_bps(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::AdminCap, arg1: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg2: &mut Pool, arg3: u64) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg1);
        arg2.growth_based_fees.fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg3);
    }

    public fun update_pool(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg1: &mut Pool, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg0);
        collect_time_based_reward(arg1, arg5);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::autocompound(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::fix_ratio(&mut arg1.investor, arg2, arg3, arg5);
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::check_price_and_fix_health(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6);
        let v0 = arg1.tokensInvested;
        arg1.tokensInvested = 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphafi_slush_stsui_sui_loop_investor::total_supplied_without_debt(&arg1.investor, arg2, arg3, arg5);
        charge_and_increase_pending_growth_based_fees(arg1);
        let v1 = XtokenRatioChangeEvent{
            x_token_supply      : 0x2::balance::supply_value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg1.xTokenSupply),
            old_tokens_invested : v0,
            new_tokens_invested : arg1.tokensInvested,
        };
        0x2::event::emit<XtokenRatioChangeEvent>(v1);
    }

    public fun user_deposit(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg1: &mut 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap, arg2: &mut Pool, arg3: 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg0);
        assert!(arg2.paused == false, 1011);
        if (!0x2::object_table::contains<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1))) {
            create_position(arg1, arg2, arg8);
        };
        assert!(0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg3) > 0, 1012);
        update_pool(arg0, arg2, arg4, arg5, arg6, arg7, arg8);
        internal_deposit(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun user_withdraw(arg0: &0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::Version, arg1: &mut 0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap, arg2: &mut Pool, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI> {
        0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::version::assert_current_version(arg0);
        assert!(arg2.paused == false, 1011);
        update_pool(arg0, arg2, arg4, arg5, arg6, arg7, arg8);
        assert!(0x2::object_table::contains<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)), 1013);
        let v0 = internal_withdraw(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
        if (0x2::balance::value<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&0x2::object_table::borrow<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1)).xtokens) == 0) {
            let Position {
                id              : v1,
                position_cap_id : _,
                pool_id         : _,
                coin_type       : _,
                principal       : _,
                xtokens         : v6,
            } = 0x2::object_table::remove<0x2::object::ID, Position>(&mut arg2.positions, 0x2::object::id<0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::PositionCap>(arg1));
            let v7 = v1;
            0xd1b9ef397179f39002deeb7165674626bc81884025d15fc3efb612c5bc2caaa0::alphalend_slush_pool::remove(arg1, 0x2::object::uid_to_inner(&v7));
            0x2::object::delete(v7);
            0x2::balance::destroy_zero<SupplyToken<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(v6);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

