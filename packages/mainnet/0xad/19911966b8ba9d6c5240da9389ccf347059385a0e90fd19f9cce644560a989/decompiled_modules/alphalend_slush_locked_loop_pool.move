module 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_pool {
    struct SupplyToken<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        principal: u64,
        xtokens: 0x2::balance::Balance<SupplyToken<T0>>,
        withdraw_requests: 0x2::vec_map::VecMap<0x2::object::ID, UserWithdrawRequest>,
        all_withdrawals: 0x2::object_table::ObjectTable<0x2::object::ID, UserWithdrawRequest>,
    }

    struct UserWithdrawRequest has store, key {
        id: 0x2::object::UID,
        time_of_request: u64,
        time_of_claim: u64,
        time_of_unlock: u64,
        status: u8,
        token_amount: u64,
        x_token_amount: u64,
    }

    struct GrowthBasedFees<phantom T0> has store {
        fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        all_time_collected: u64,
        pending: 0x2::balance::Balance<SupplyToken<T0>>,
        last_fee_collected_exchange_rate: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        slush_fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
    }

    struct ExternalRewardsInfo<phantom T0> has store {
        reward_balance: 0x2::balance::Balance<T0>,
        reward_per_ms: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        start_time: u64,
        end_time: u64,
        last_updated_timestamp: u64,
        fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        slush_fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        fee_balance: 0x2::balance::Balance<T0>,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        xTokenSupply: 0x2::balance::Supply<SupplyToken<T0>>,
        tokensInvested: u64,
        treasury_balance: 0x2::balance::Balance<SupplyToken<T0>>,
        locking_period: u64,
        deposit_limit: u64,
        positions: 0x2::object_table::ObjectTable<0x2::object::ID, Position<T0>>,
        growth_based_fees: GrowthBasedFees<T0>,
        external_rewards_info: ExternalRewardsInfo<T0>,
        is_deposit_paused: bool,
        is_withdraw_paused: bool,
        investor: 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::Investor<T0>,
        slush_fee_address: address,
        fee_address: address,
    }

    struct DepositEvent has copy, drop {
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        user_xtoken_balance: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        sender: address,
    }

    struct WithdrawRequestEvent has copy, drop {
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        requested_xtokens: u64,
        requested_token_amount: u64,
        current_user_xtoken_balance: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        time_of_request: u64,
        time_of_unlock: u64,
        sender: address,
    }

    struct WithdrawClaimEvent has copy, drop {
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        amount: u64,
        current_user_xtoken_balance: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        sender: address,
    }

    struct WithdrawCancelEvent has copy, drop {
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        xtokens_returned: u64,
        xtokens_to_fees: u64,
        token_amount: u64,
        sender: address,
    }

    struct GrowthBasedFeesCollectedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        collected_amount: u64,
        all_time_collected: u64,
    }

    struct PoolRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct XtokenRatioChangeEvent has copy, drop {
        x_token_supply: u64,
        old_tokens_invested: u64,
        new_tokens_invested: u64,
    }

    struct XtokenRatioChangeEventV2 has copy, drop {
        pool_id: 0x2::object::ID,
        x_token_supply: u64,
        old_tokens_invested: u64,
        new_tokens_invested: u64,
    }

    public fun add_or_remove_coin_type_for_swap<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: 0x1::type_name::TypeName, arg4: u8) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::add_or_remove_coin_type_for_swap<T0>(&mut arg2.investor, arg3, arg4);
    }

    public fun admin_borrow<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::admin_borrow<T0>(&mut arg2.investor, arg3, arg4, arg5, arg6);
        update_pool<T0>(arg1, arg2, arg4, arg5, arg6);
    }

    public fun admin_repay<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::admin_repay<T0>(&mut arg2.investor, arg3, arg4, arg5, arg6);
        update_pool<T0>(arg1, arg2, arg4, arg5, arg6);
    }

    public fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: bool, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::collect_reward_and_swap_bluefin<T0, T1, T2>(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun set_safe_borrow_percentage_bps<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg3 <= 10000, 1029);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::set_safe_borrow_percentage_bps<T0>(&mut arg2.investor, arg3);
    }

    public fun add_external_rewards<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg7), 1003);
        assert!(arg4 < arg5, 1004);
        assert!(arg5 >= arg2.external_rewards_info.end_time, 1005);
        update_pool<T0>(arg1, arg2, arg6, arg7, arg8);
        0x2::balance::join<T0>(&mut arg2.external_rewards_info.reward_balance, 0x2::coin::into_balance<T0>(arg3));
        let v0 = if (arg2.external_rewards_info.last_updated_timestamp == arg2.external_rewards_info.end_time) {
            arg4
        } else {
            arg2.external_rewards_info.last_updated_timestamp
        };
        arg2.external_rewards_info.start_time = v0;
        arg2.external_rewards_info.end_time = arg5;
        arg2.external_rewards_info.reward_per_ms = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T0>(&arg2.external_rewards_info.reward_balance)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg5 - arg2.external_rewards_info.start_time));
    }

    fun add_or_remove_pending_position_cap_id<T0>(arg0: &mut Pool<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, get_pending_position_cap_ids_key())) {
            0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.id, get_pending_position_cap_ids_key(), 0x2::table::new<0x2::object::ID, bool>(arg3));
        };
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.id, get_pending_position_cap_ids_key());
        if (arg2 && !0x2::table::contains<0x2::object::ID, bool>(v0, arg1)) {
            0x2::table::add<0x2::object::ID, bool>(v0, arg1, true);
        } else if (!arg2 && 0x2::table::contains<0x2::object::ID, bool>(v0, arg1)) {
            0x2::table::remove<0x2::object::ID, bool>(v0, arg1);
        };
    }

    public fun admin_emergency_repay<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::emergency_repay<T0>(&mut arg2.investor, arg3, arg4, arg5, arg6);
        update_pool<T0>(arg1, arg2, arg4, arg5, arg6);
    }

    fun charge_and_increase_pending_growth_based_fees<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        arg0.tokensInvested = arg0.tokensInvested - arg1;
        let v0 = exchange_rate<T0>(arg0);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v0, arg0.growth_based_fees.last_fee_collected_exchange_rate)) {
            let v1 = &mut arg0.growth_based_fees;
            let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v1.last_fee_collected_exchange_rate, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v0, v1.last_fee_collected_exchange_rate), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), v1.fee_bps)))));
            let v3 = v2 - 0x1::u64::min(v2, 0x2::balance::supply_value<SupplyToken<T0>>(&arg0.xTokenSupply));
            if (v3 > 0) {
                0x2::balance::join<SupplyToken<T0>>(&mut v1.pending, 0x2::balance::increase_supply<SupplyToken<T0>>(&mut arg0.xTokenSupply, v3));
            };
        };
        arg0.tokensInvested = arg0.tokensInvested + arg1;
        let v4 = exchange_rate<T0>(arg0);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v4, arg0.growth_based_fees.last_fee_collected_exchange_rate)) {
            arg0.growth_based_fees.last_fee_collected_exchange_rate = v4;
        };
    }

    public fun collect_growth_based_fees<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        update_pool<T0>(arg0, arg1, arg2, arg3, arg4);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        let v3 = 0x2::balance::value<SupplyToken<T0>>(&arg1.growth_based_fees.pending);
        if (v3 > 0) {
            let v4 = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::withdraw_from_alphalend<T0>(&mut arg1.investor, arg2, v3, 0x2::balance::supply_value<SupplyToken<T0>>(&arg1.xTokenSupply), arg3, arg4);
            0x2::balance::decrease_supply<SupplyToken<T0>>(&mut arg1.xTokenSupply, 0x2::balance::withdraw_all<SupplyToken<T0>>(&mut arg1.growth_based_fees.pending));
            v2 = v1 + 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T0>(&v4)), arg1.growth_based_fees.slush_fee_bps));
            0x2::balance::join<T0>(&mut v0, v4);
        };
        let v5 = 0x2::balance::value<T0>(&arg1.external_rewards_info.fee_balance);
        if (v5 > 0) {
            v2 = v2 + 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v5), arg1.external_rewards_info.slush_fee_bps));
            0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg1.external_rewards_info.fee_balance));
        };
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        arg1.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::total_supplied_without_debt<T0>(&mut arg1.investor, arg2, arg3);
        let v6 = 0x2::balance::value<T0>(&v0);
        arg1.growth_based_fees.all_time_collected = arg1.growth_based_fees.all_time_collected + v6;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, v2), arg4), arg1.slush_fee_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), arg1.fee_address);
        let v7 = GrowthBasedFeesCollectedEvent{
            pool_id            : 0x2::object::id<Pool<T0>>(arg1),
            collected_amount   : v6,
            all_time_collected : arg1.growth_based_fees.all_time_collected,
        };
        0x2::event::emit<GrowthBasedFeesCollectedEvent>(v7);
    }

    public fun create_pool<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: address, arg11: u64, arg12: u64, arg13: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg14: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg11 <= 15552000000, 1028);
        let v0 = SupplyToken<T0>{dummy_field: false};
        let v1 = GrowthBasedFees<T0>{
            fee_bps                          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg7),
            all_time_collected               : 0,
            pending                          : 0x2::balance::zero<SupplyToken<T0>>(),
            last_fee_collected_exchange_rate : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1),
            slush_fee_bps                    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg8),
        };
        let v2 = ExternalRewardsInfo<T0>{
            reward_balance         : 0x2::balance::zero<T0>(),
            reward_per_ms          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            start_time             : 0,
            end_time               : 0,
            last_updated_timestamp : 0,
            fee_bps                : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg5),
            slush_fee_bps          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg6),
            fee_balance            : 0x2::balance::zero<T0>(),
        };
        let v3 = Pool<T0>{
            id                    : 0x2::object::new(arg14),
            xTokenSupply          : 0x2::balance::create_supply<SupplyToken<T0>>(v0),
            tokensInvested        : 0,
            treasury_balance      : 0x2::balance::zero<SupplyToken<T0>>(),
            locking_period        : arg11,
            deposit_limit         : arg12,
            positions             : 0x2::object_table::new<0x2::object::ID, Position<T0>>(arg14),
            growth_based_fees     : v1,
            external_rewards_info : v2,
            is_deposit_paused     : false,
            is_withdraw_paused    : false,
            investor              : 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::create_investor<T0>(arg2, arg3, arg4, arg13, arg14),
            slush_fee_address     : arg9,
            fee_address           : arg10,
        };
        0x2::transfer::public_share_object<Pool<T0>>(v3);
    }

    fun create_position<T0>(arg0: &mut 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg0);
        assert!(!0x2::object_table::contains<0x2::object::ID, Position<T0>>(&arg1.positions, v0), 1001);
        let v1 = 0x2::object::new(arg2);
        let v2 = 0x2::object::id<Pool<T0>>(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::insert(arg0, 0x2::object::uid_to_inner(&v1), v2);
        let v3 = Position<T0>{
            id                : v1,
            position_cap_id   : v0,
            pool_id           : v2,
            coin_type         : 0x1::type_name::with_defining_ids<T0>(),
            principal         : 0,
            xtokens           : 0x2::balance::zero<SupplyToken<T0>>(),
            withdraw_requests : 0x2::vec_map::empty<0x2::object::ID, UserWithdrawRequest>(),
            all_withdrawals   : 0x2::object_table::new<0x2::object::ID, UserWithdrawRequest>(arg2),
        };
        0x2::object_table::add<0x2::object::ID, Position<T0>>(&mut arg1.positions, v0, v3);
    }

    fun distribute_external_rewards<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = &mut arg0.external_rewards_info;
        if (0x2::balance::value<T0>(&v0.reward_balance) == 0) {
            return 0
        };
        let v1 = 0x1::u64::max(v0.start_time, v0.last_updated_timestamp);
        let v2 = 0x1::u64::min(v0.end_time, 0x2::clock::timestamp_ms(arg1));
        if (v2 <= v1) {
            return 0
        };
        let v3 = 0x1::u64::min(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2 - v1), v0.reward_per_ms)), 0x2::balance::value<T0>(&v0.reward_balance));
        if (v3 == 0) {
            return 0
        };
        v0.last_updated_timestamp = v2;
        let v4 = 0x2::balance::split<T0>(&mut v0.reward_balance, v3);
        let v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v3), v0.fee_bps));
        if (v5 > 0) {
            0x2::balance::join<T0>(&mut v0.fee_balance, 0x2::balance::split<T0>(&mut v4, v5));
        };
        let v6 = PoolRewardEvent{
            pool_id   : 0x2::object::id<Pool<T0>>(arg0),
            amount    : v3,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<PoolRewardEvent>(v6);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::update_free_rewards<T0, T0>(&mut arg0.investor, v4);
        0x2::balance::value<T0>(&v4)
    }

    fun exchange_rate<T0>(arg0: &Pool<T0>) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (arg0.tokensInvested == 0 || 0x2::balance::supply_value<SupplyToken<T0>>(&arg0.xTokenSupply) == 0) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::supply_value<SupplyToken<T0>>(&arg0.xTokenSupply)))
        }
    }

    fun get_pending_position_cap_ids_key() : vector<u8> {
        b"pending_position_cap_ids"
    }

    public fun set_external_reward_fees<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        update_pool<T0>(arg1, arg2, arg3, arg6, arg7);
        arg2.external_rewards_info.fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg4);
        arg2.external_rewards_info.slush_fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg5);
    }

    public fun set_fee_address<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.fee_address = arg3;
    }

    public fun set_growth_fee_bps<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        update_pool<T0>(arg1, arg2, arg3, arg5, arg6);
        arg2.growth_based_fees.fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg4);
    }

    public fun set_locking_period<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg3 <= 15552000000, 1028);
        arg2.locking_period = arg3;
    }

    entry fun set_pause<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: bool, arg4: bool) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        if (arg3) {
            assert!(arg2.is_withdraw_paused != arg4, 1030);
            arg2.is_withdraw_paused = arg4;
            if (arg4) {
                arg2.is_deposit_paused = arg4;
            };
        } else {
            assert!(arg2.is_deposit_paused != arg4, 1030);
            assert!(arg2.is_withdraw_paused == false, 1034);
            arg2.is_deposit_paused = arg4;
        };
    }

    public fun set_slush_fee_address<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.slush_fee_address = arg3;
    }

    public fun set_slush_fee_bps<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        update_pool<T0>(arg1, arg2, arg3, arg5, arg6);
        arg2.growth_based_fees.slush_fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg4);
    }

    public fun update_deposit_limit<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.deposit_limit = arg3;
    }

    public fun update_pool<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        let v0 = distribute_external_rewards<T0>(arg1, arg3);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::autocompound<T0>(&mut arg1.investor, arg2, arg3, arg4);
        let v1 = arg1.tokensInvested;
        arg1.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::total_supplied_without_debt<T0>(&mut arg1.investor, arg2, arg3);
        charge_and_increase_pending_growth_based_fees<T0>(arg1, v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v3 = 0x1::ascii::string(b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL");
        if (0x1::ascii::index_of(&v2, &v3) == 0) {
            let v4 = XtokenRatioChangeEvent{
                x_token_supply      : 0x2::balance::supply_value<SupplyToken<T0>>(&arg1.xTokenSupply),
                old_tokens_invested : v1,
                new_tokens_invested : arg1.tokensInvested,
            };
            0x2::event::emit<XtokenRatioChangeEvent>(v4);
        };
        let v5 = XtokenRatioChangeEventV2{
            pool_id             : 0x2::object::id<Pool<T0>>(arg1),
            x_token_supply      : 0x2::balance::supply_value<SupplyToken<T0>>(&arg1.xTokenSupply),
            old_tokens_invested : v1,
            new_tokens_invested : arg1.tokensInvested,
        };
        0x2::event::emit<XtokenRatioChangeEventV2>(v5);
    }

    public fun user_cancel_withdraw<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg2: &mut Pool<T0>, arg3: 0x2::object::ID, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        let v0 = 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, Position<T0>>(&arg2.positions, v0), 1013);
        update_pool<T0>(arg0, arg2, arg4, arg5, arg6);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Position<T0>>(&mut arg2.positions, v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, UserWithdrawRequest>(&v1.withdraw_requests, &arg3), 1020);
        let (_, v3) = 0x2::vec_map::remove<0x2::object::ID, UserWithdrawRequest>(&mut v1.withdraw_requests, &arg3);
        let v4 = v3;
        assert!(v4.status == 1, 1025);
        let v5 = 0x1::u64::min(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v4.token_amount), exchange_rate<T0>(arg2))), 0x2::balance::value<SupplyToken<T0>>(&arg2.treasury_balance));
        let v6 = 0x1::u64::max(v4.x_token_amount, v5) - v5;
        0x2::balance::join<SupplyToken<T0>>(&mut v1.xtokens, 0x2::balance::split<SupplyToken<T0>>(&mut arg2.treasury_balance, v5));
        if (v6 > 0) {
            0x2::balance::join<SupplyToken<T0>>(&mut arg2.growth_based_fees.pending, 0x2::balance::split<SupplyToken<T0>>(&mut arg2.treasury_balance, v6));
        };
        v1.principal = v1.principal + v4.token_amount;
        if (0x2::vec_map::length<0x2::object::ID, UserWithdrawRequest>(&v1.withdraw_requests) == 0) {
            add_or_remove_pending_position_cap_id<T0>(arg2, v0, false, arg6);
        };
        let v7 = WithdrawCancelEvent{
            position_cap_id  : v0,
            pool_id          : 0x2::object::id<Pool<T0>>(arg2),
            request_id       : arg3,
            xtokens_returned : v5,
            xtokens_to_fees  : v6,
            token_amount     : v4.token_amount,
            sender           : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<WithdrawCancelEvent>(v7);
        let UserWithdrawRequest {
            id              : v8,
            time_of_request : _,
            time_of_claim   : _,
            time_of_unlock  : _,
            status          : _,
            token_amount    : _,
            x_token_amount  : _,
        } = v4;
        0x2::object::delete(v8);
    }

    public fun user_claim_withdraw<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg2: &mut Pool<T0>, arg3: 0x2::object::ID, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, _) = user_claim_withdraw_inner<T0>(arg0, 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1), arg2, arg3, arg4, arg5, arg6);
        v0
    }

    fun user_claim_withdraw_inner<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: 0x2::object::ID, arg2: &mut Pool<T0>, arg3: 0x2::object::ID, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(!arg2.is_withdraw_paused, 1011);
        assert!(0x2::object_table::contains<0x2::object::ID, Position<T0>>(&arg2.positions, arg1), 1013);
        update_pool<T0>(arg0, arg2, arg4, arg5, arg6);
        let v0 = 0x2::object::id<Pool<T0>>(arg2);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Position<T0>>(&mut arg2.positions, arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, UserWithdrawRequest>(&v1.withdraw_requests, &arg3), 1020);
        let (_, v3) = 0x2::vec_map::remove<0x2::object::ID, UserWithdrawRequest>(&mut v1.withdraw_requests, &arg3);
        let v4 = v3;
        let v5 = @0x0;
        if (0x2::dynamic_field::exists_<vector<u8>>(&v4.id, b"sender")) {
            v5 = *0x2::dynamic_field::borrow<vector<u8>, address>(&v4.id, b"sender");
        };
        assert!(v4.status == 1, 1025);
        assert!(0x2::clock::timestamp_ms(arg5) >= v4.time_of_unlock, 1023);
        v4.status = 2;
        v4.time_of_claim = 0x2::clock::timestamp_ms(arg5);
        let v6 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v4.token_amount), exchange_rate<T0>(arg2)));
        let v7 = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::withdraw_from_alphalend<T0>(&mut arg2.investor, arg4, v6, 0x2::balance::supply_value<SupplyToken<T0>>(&arg2.xTokenSupply), arg5, arg6);
        let v8 = 0x1::u64::min(v6, 0x2::balance::value<SupplyToken<T0>>(&arg2.treasury_balance));
        0x2::balance::decrease_supply<SupplyToken<T0>>(&mut arg2.xTokenSupply, 0x2::balance::split<SupplyToken<T0>>(&mut arg2.treasury_balance, v8));
        let v9 = 0x1::u64::max(v4.x_token_amount, v8) - v8;
        if (v9 > 0) {
            0x2::balance::join<SupplyToken<T0>>(&mut arg2.growth_based_fees.pending, 0x2::balance::split<SupplyToken<T0>>(&mut arg2.treasury_balance, v9));
        };
        arg2.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::total_supplied_without_debt<T0>(&mut arg2.investor, arg4, arg5);
        let v10 = 0x2::balance::supply_value<SupplyToken<T0>>(&arg2.xTokenSupply);
        let v11 = arg2.tokensInvested;
        0x2::object_table::add<0x2::object::ID, UserWithdrawRequest>(&mut v1.all_withdrawals, arg3, v4);
        if (0x2::vec_map::length<0x2::object::ID, UserWithdrawRequest>(&v1.withdraw_requests) == 0) {
            add_or_remove_pending_position_cap_id<T0>(arg2, arg1, false, arg6);
        };
        let v12 = WithdrawClaimEvent{
            position_cap_id             : arg1,
            pool_id                     : v0,
            request_id                  : arg3,
            amount                      : 0x2::balance::value<T0>(&v7),
            current_user_xtoken_balance : 0x2::balance::value<SupplyToken<T0>>(&v1.xtokens),
            x_token_supply              : v10,
            tokens_invested             : v11,
            sender                      : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<WithdrawClaimEvent>(v12);
        (0x2::coin::from_balance<T0>(v7, arg6), v5)
    }

    public fun user_claim_withdraw_with_cap_id<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: 0x2::object::ID, arg2: &mut Pool<T0>, arg3: 0x2::object::ID, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = user_claim_withdraw_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(v1 != @0x0, 1031);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v1);
    }

    public fun user_deposit<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg2: &mut Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(!arg2.is_deposit_paused, 1011);
        assert!(0x2::coin::value<T0>(&arg3) > 0, 1012);
        let v0 = 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1);
        if (!0x2::object_table::contains<0x2::object::ID, Position<T0>>(&arg2.positions, v0)) {
            create_position<T0>(arg1, arg2, arg6);
        };
        update_pool<T0>(arg0, arg2, arg4, arg5, arg6);
        assert!(arg2.tokensInvested + 0x2::coin::value<T0>(&arg3) <= arg2.deposit_limit, 1032);
        let v1 = 0x2::coin::value<T0>(&arg3);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::deposit<T0>(&mut arg2.investor, arg4, arg3, arg5, arg6);
        arg2.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor::total_supplied_without_debt<T0>(&mut arg2.investor, arg4, arg5);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), exchange_rate<T0>(arg2)));
        assert!(v2 > 0, 1012);
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, Position<T0>>(&mut arg2.positions, v0);
        0x2::balance::join<SupplyToken<T0>>(&mut v3.xtokens, 0x2::balance::increase_supply<SupplyToken<T0>>(&mut arg2.xTokenSupply, v2));
        v3.principal = v3.principal + v1;
        let v4 = DepositEvent{
            position_cap_id     : v0,
            pool_id             : 0x2::object::id<Pool<T0>>(arg2),
            position_id         : 0x2::object::id<Position<T0>>(v3),
            amount              : v1,
            user_xtoken_balance : 0x2::balance::value<SupplyToken<T0>>(&v3.xtokens),
            x_token_supply      : 0x2::balance::supply_value<SupplyToken<T0>>(&arg2.xTokenSupply),
            tokens_invested     : arg2.tokensInvested,
            sender              : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public fun user_initiate_withdraw<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap, arg2: &mut Pool<T0>, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(!arg2.is_withdraw_paused, 1011);
        assert!(arg3 > 0, 1015);
        let v0 = 0x2::object::id<0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool::PositionCap>(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, Position<T0>>(&arg2.positions, v0), 1013);
        update_pool<T0>(arg0, arg2, arg4, arg5, arg6);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Position<T0>>(&mut arg2.positions, v0);
        let v2 = 0x2::balance::value<SupplyToken<T0>>(&v1.xtokens);
        assert!(v2 >= arg3, 1014);
        let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3), exchange_rate<T0>(arg2)));
        let v4 = &mut v1.principal;
        *v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*v4), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*v4), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2))));
        0x2::balance::join<SupplyToken<T0>>(&mut arg2.treasury_balance, 0x2::balance::split<SupplyToken<T0>>(&mut v1.xtokens, arg3));
        let v5 = 0x2::object::new(arg6);
        0x2::dynamic_field::add<vector<u8>, address>(&mut v5, b"sender", 0x2::tx_context::sender(arg6));
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = 0x2::clock::timestamp_ms(arg5);
        let v8 = v7 + arg2.locking_period;
        let v9 = UserWithdrawRequest{
            id              : v5,
            time_of_request : v7,
            time_of_claim   : 0,
            time_of_unlock  : v8,
            status          : 1,
            token_amount    : v3,
            x_token_amount  : arg3,
        };
        0x2::vec_map::insert<0x2::object::ID, UserWithdrawRequest>(&mut v1.withdraw_requests, v6, v9);
        add_or_remove_pending_position_cap_id<T0>(arg2, v0, true, arg6);
        let v10 = WithdrawRequestEvent{
            position_cap_id             : v0,
            pool_id                     : 0x2::object::id<Pool<T0>>(arg2),
            position_id                 : 0x2::object::id<Position<T0>>(v1),
            request_id                  : v6,
            requested_xtokens           : arg3,
            requested_token_amount      : v3,
            current_user_xtoken_balance : 0x2::balance::value<SupplyToken<T0>>(&v1.xtokens),
            x_token_supply              : 0x2::balance::supply_value<SupplyToken<T0>>(&arg2.xTokenSupply),
            tokens_invested             : arg2.tokensInvested,
            time_of_request             : v7,
            time_of_unlock              : v8,
            sender                      : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<WithdrawRequestEvent>(v10);
    }

    // decompiled from Move bytecode v7
}

