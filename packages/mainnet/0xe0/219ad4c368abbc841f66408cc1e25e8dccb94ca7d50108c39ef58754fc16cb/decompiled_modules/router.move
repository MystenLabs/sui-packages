module 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::router {
    struct RouterMintEvent has copy, drop {
        user: address,
        sy_amount: u64,
        py_amount: u64,
    }

    struct RouterSwapEvent has copy, drop {
        user: address,
        direction: u8,
        amount_in: u64,
        amount_out: u64,
    }

    struct RouterSwapYtEvent has copy, drop {
        user: address,
        sy_amount_in: u64,
        yt_amount_out: u64,
        sy_amount_out: u64,
    }

    struct RouterSwapYtForSyEvent has copy, drop {
        user: address,
        yt_amount_in: u64,
        sy_amount_out: u64,
        sy_amount_repaid: u64,
    }

    public fun transfer_position(arg0: 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: address) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::is_py_empty(&arg0) && 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::is_lp_empty(&arg0), 3006);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::transfer_position(arg0, arg2);
    }

    public(friend) fun add_liquidity_from_position<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        assert_before(arg6, arg8, arg9);
        assert_yt_route_match<T0>(arg3, arg4, arg5);
        let (v0, _, v2, v3) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::add_liquidity<T0>(arg0, arg1, arg3, arg4, observe_pool_index<T0>(arg3, arg5, arg7, arg9), arg9, arg10);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::sub_pt(arg4, v2);
        assert!(v0 >= arg2, 3001);
        (v0, v2, v3)
    }

    public(friend) fun add_liquidity_from_sy<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg7: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg8: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        assert_before(arg7, arg9, arg10);
        assert_yt_route_match<T0>(arg4, arg5, arg6);
        let v0 = observe_pool_index<T0>(arg4, arg6, arg8, arg10);
        let (v1, v2, v3) = add_liquidity_keep_yt_from_sy_with_index<T0>(arg0, arg1, 0, arg4, arg5, arg6, arg7, v0, arg10, arg11);
        let (v4, _) = sell_yt_for_sy_with_pt_settlement_with_index<T0>(v2, 0, arg4, arg5, arg6, arg7, v0, arg10, arg11);
        let v6 = 0x2::coin::into_balance<T0>(v3);
        0x2::balance::join<T0>(&mut v6, 0x2::coin::into_balance<T0>(v4));
        let v7 = 0x2::coin::from_balance<T0>(v6, arg11);
        let (v8, v9) = add_liquidity_from_sy_remainder<T0>(v7, arg4, arg5, arg7, v0, arg10, arg11);
        let v10 = v9;
        let v11 = (v1 as u128) + (v8 as u128);
        assert!(v11 <= 18446744073709551615, 3001);
        let v12 = (v11 as u64);
        assert!(v12 >= arg2, 3001);
        assert!(0x2::coin::value<T0>(&v10) >= arg3, 3001);
        (v12, v10)
    }

    fun add_liquidity_from_sy_remainder<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg1));
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = if (v0 <= 1) {
            true
        } else if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg1) <= 1) {
            true
        } else {
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg1) == 0
        };
        if (v1) {
            return (0, arg0)
        };
        let v2 = solve_sy_to_swap_for_lp_from_sy<T0>(v0, arg1, arg4, arg5);
        if (v2 == 0) {
            return (0, arg0)
        };
        let (v3, _, v5) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::swap_sy_for_pt<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg6), 0, arg1, arg4, arg5, arg6);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::add_pt(arg2, v3);
        let v6 = 0x2::coin::into_balance<T0>(arg0);
        0x2::balance::join<T0>(&mut v6, 0x2::coin::into_balance<T0>(v5));
        let (v7, _, v9, v10) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::add_liquidity<T0>(0x2::coin::from_balance<T0>(v6, arg6), v3, arg1, arg2, arg4, arg5, arg6);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::sub_pt(arg2, v9);
        (v7, v10)
    }

    public(friend) fun add_liquidity_keep_yt_from_sy<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg5));
        assert_before(arg6, arg8, arg9);
        assert_yt_route_match<T0>(arg3, arg4, arg5);
        assert!(0x2::coin::value<T0>(&arg0) > 1, 3000);
        let v0 = observe_pool_index<T0>(arg3, arg5, arg7, arg9);
        add_liquidity_keep_yt_from_sy_with_index<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg9, arg10)
    }

    fun add_liquidity_keep_yt_from_sy_with_index<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg5));
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 1, 3000);
        let v1 = solve_sy_to_mint_for_keep_yt<T0>(v0, arg1, arg3, arg5, arg7);
        assert!(v1 > 0 && v0 > v1, 3000);
        let v2 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::mint_py_with_sy_index<T0>(0x2::coin::split<T0>(&mut arg0, v1, arg9), arg7, arg4, arg5, arg8);
        let (v3, _, v5, v6) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::add_liquidity<T0>(arg0, v2, arg3, arg4, arg7, arg8, arg9);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::sub_pt(arg4, v5);
        assert!(v3 >= arg2, 3001);
        (v3, v2, v6)
    }

    public fun add_lp<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg7: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg8: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg9: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg10: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg6)) {
            assert_reward_distributor_matches_pool<T0>(arg2, arg6);
            let v4 = &mut arg0;
            let v5 = take_one_settlement(v4);
            let v6 = &mut arg1;
            let v7 = take_one_settlement(v6);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v5);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v7);
            let v8 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg6, v5);
            let v9 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::begin_reward_mutation(arg7, v7, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg2), 0x2::tx_context::sender(arg13));
            let (v10, v11, v12) = add_liquidity_from_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::end_reward_mutation(arg7, v9);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg6, v8);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg1);
            let v13 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v13, begin_post_lp_operation(arg2, arg9, arg7, 0x2::tx_context::sender(arg13)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v13, begin_post_pool_operation<T0>(arg2, arg9, arg6));
            (v10, v11, v12, v13)
        } else {
            assert_no_settlements(arg0);
            assert_no_settlements(arg1);
            let (v14, v15, v16) = add_liquidity_from_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
            (v14, v15, v16, 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun add_lp_from_sy<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg2: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg9: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg10: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg11: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg12: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        assert_pool_yt_reward_mode_match<T0>(arg8, arg10);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg8)) {
            assert_reward_distributor_matches_pool<T0>(arg3, arg8);
            assert_reward_distributor_matches_py_state<T0>(arg3, arg10);
            let v3 = &mut arg0;
            let v4 = take_one_settlement(v3);
            let v5 = &mut arg1;
            let v6 = take_one_settlement(v5);
            let v7 = &mut arg2;
            let v8 = take_one_settlement(v7);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg3, &v4);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg3, &v6);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg3, &v8);
            let v9 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg8, v4);
            let v10 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg10, v6, 0x2::tx_context::sender(arg15), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg9), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg9), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg9));
            let v11 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::begin_reward_mutation(arg9, v8, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg3), 0x2::tx_context::sender(arg15));
            let (v12, v13) = add_liquidity_from_sy<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::end_reward_mutation(arg9, v11);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg10, v10);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg8, v9);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg1);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg2);
            let v14 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v14, begin_post_yt_operation(arg3, arg11, arg9, 0x2::tx_context::sender(arg15)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v14, begin_post_lp_operation(arg3, arg11, arg9, 0x2::tx_context::sender(arg15)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v14, begin_post_pool_operation<T0>(arg3, arg11, arg8));
            (v12, v13, v14)
        } else {
            assert_no_settlements(arg0);
            assert_no_settlements(arg1);
            assert_no_settlements(arg2);
            let (v15, v16) = add_liquidity_from_sy<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
            (v15, v16, 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun add_lp_keep_yt<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg2: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg8: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg9: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg10: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg11: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        assert_pool_yt_reward_mode_match<T0>(arg7, arg9);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg7)) {
            assert_reward_distributor_matches_pool<T0>(arg3, arg7);
            assert_reward_distributor_matches_py_state<T0>(arg3, arg9);
            let v4 = &mut arg0;
            let v5 = take_one_settlement(v4);
            let v6 = &mut arg1;
            let v7 = take_one_settlement(v6);
            let v8 = &mut arg2;
            let v9 = take_one_settlement(v8);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg3, &v5);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg3, &v7);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg3, &v9);
            let v10 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg7, v5);
            let v11 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg9, v7, 0x2::tx_context::sender(arg14), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg8), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg8), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg8));
            let v12 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::begin_reward_mutation(arg8, v9, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg3), 0x2::tx_context::sender(arg14));
            let (v13, v14, v15) = add_liquidity_keep_yt_from_sy<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::end_reward_mutation(arg8, v12);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg9, v11);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg7, v10);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg1);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg2);
            let v16 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v16, begin_post_yt_operation(arg3, arg10, arg8, 0x2::tx_context::sender(arg14)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v16, begin_post_lp_operation(arg3, arg10, arg8, 0x2::tx_context::sender(arg14)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v16, begin_post_pool_operation<T0>(arg3, arg10, arg7));
            (v13, v14, v15, v16)
        } else {
            assert_no_settlements(arg0);
            assert_no_settlements(arg1);
            assert_no_settlements(arg2);
            let (v17, v18, v19) = add_liquidity_keep_yt_from_sy<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
            (v17, v18, v19, 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun assert_before(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 == 0 || v0 <= arg1, 3004);
        v0
    }

    public fun assert_coin_max_value<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0x2::coin::Coin<T0>, arg2: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0x2::coin::value<T0>(arg1);
        assert!(v0 <= arg2, 3001);
        v0
    }

    public fun assert_coin_min_value<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0x2::coin::Coin<T0>, arg2: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0x2::coin::value<T0>(arg1);
        assert!(v0 >= arg2, 3001);
        v0
    }

    public fun assert_lp_delta_at_least(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg2: u64, arg3: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::lp_amount(arg1);
        assert!(v0 >= arg2, 3001);
        let v1 = v0 - arg2;
        assert!(v1 >= arg3, 3001);
        v1
    }

    fun assert_no_settlements(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>) {
        assert!(0x1::vector::length<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(&arg0) == 0, 3005);
        0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
    }

    fun assert_pool_yt_reward_mode_match<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>) {
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg0) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_reward_distributor_required<T0>(arg1), 3002);
    }

    public fun assert_pt_delta_at_least(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg2: u64, arg3: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::pt_balance(arg1);
        assert!(v0 >= arg2, 3001);
        let v1 = v0 - arg2;
        assert!(v1 >= arg3, 3001);
        v1
    }

    fun assert_reward_distributor_matches_pool<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) {
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg0) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_id<T0>(arg1), 3002);
    }

    fun assert_reward_distributor_matches_py_state<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>) {
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg0) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_reward_distributor_id<T0>(arg1), 3002);
    }

    public fun assert_yt_delta_at_least(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg2: u64, arg3: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg1);
        assert!(v0 >= arg2, 3001);
        let v1 = v0 - arg2;
        assert!(v1 >= arg3, 3001);
        v1
    }

    fun assert_yt_output(arg0: u64, arg1: u64, arg2: bool) {
        if (arg2) {
            assert!(arg0 == arg1, 3003);
        } else {
            assert!(arg0 >= arg1, 3003);
        };
    }

    fun assert_yt_route_match<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::assert_state_match(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg2));
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg0) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg2), 3002);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::market_id(arg1) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg2), 3002);
    }

    fun begin_post_lp_operation(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg3: address) : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::begin_scoped_operation_for_profile_with_guard(arg0, arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::pool_id(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::lp_scope(), arg3, 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::lp_amount(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::lp_reward_guard(arg2))
    }

    fun begin_post_pool_operation<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::begin_scoped_operation_for_profile_with_guard(arg0, arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::pool_scope(), @0x0, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_guard<T0>(arg2))
    }

    fun begin_post_yt_operation(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg3: address) : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::begin_scoped_operation_for_profile_with_guard(arg0, arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::market_id(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::yt_scope(), arg3, 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg2))
    }

    fun better_keep_yt_split<T0: drop>(arg0: u64, arg1: u64, arg2: u64, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: u128) : u64 {
        let v0 = clamp_keep_yt_split(arg0, arg2);
        if (keep_yt_lp_for_split<T0>(arg0, v0, arg3, arg4, arg5) > keep_yt_lp_for_split<T0>(arg0, arg1, arg3, arg4, arg5)) {
            v0
        } else {
            arg1
        }
    }

    fun better_sy_to_swap_for_lp<T0: drop>(arg0: u64, arg1: u64, arg2: u64, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: u128, arg5: &0x2::clock::Clock) : u64 {
        if (arg2 == 0 || arg2 >= arg0) {
            return arg1
        };
        if (lp_for_sy_to_pt_lp_split<T0>(arg0, arg2, arg3, arg4, arg5) > lp_for_sy_to_pt_lp_split<T0>(arg0, arg1, arg3, arg4, arg5)) {
            arg2
        } else {
            arg1
        }
    }

    public fun buy_exact_pt<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg7: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg8: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg9: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg5)) {
            assert_reward_distributor_matches_pool<T0>(arg1, arg5);
            let v3 = &mut arg0;
            let v4 = take_one_settlement(v3);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg1, &v4);
            let v5 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg5, v4);
            let (v6, v7) = swap_sy_for_exact_pt_to_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg5, v5);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            let v8 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v8, begin_post_pool_operation<T0>(arg1, arg8, arg5));
            (v6, v7, v8)
        } else {
            assert_no_settlements(arg0);
            let (v9, v10) = swap_sy_for_exact_pt_to_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            (v9, v10, 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun buy_exact_yt<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg7: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg8: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg9: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg10: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        assert_pool_yt_reward_mode_match<T0>(arg6, arg8);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg6)) {
            assert_reward_distributor_matches_pool<T0>(arg2, arg6);
            assert_reward_distributor_matches_py_state<T0>(arg2, arg8);
            let v2 = &mut arg0;
            let v3 = take_one_settlement(v2);
            let v4 = &mut arg1;
            let v5 = take_one_settlement(v4);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v3);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v5);
            let v6 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg6, v3);
            let v7 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg8, v5, 0x2::tx_context::sender(arg13), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg7), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg7), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg7));
            let v8 = swap_sy_for_exact_yt_to_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg8, v7);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg6, v6);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg1);
            let v9 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v9, begin_post_yt_operation(arg2, arg9, arg7, 0x2::tx_context::sender(arg13)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v9, begin_post_pool_operation<T0>(arg2, arg9, arg6));
            (v8, v9)
        } else {
            assert_no_settlements(arg0);
            assert_no_settlements(arg1);
            (swap_sy_for_exact_yt_to_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun buy_pt<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg7: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg8: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg4)) {
            assert_reward_distributor_matches_pool<T0>(arg1, arg4);
            let v3 = &mut arg0;
            let v4 = take_one_settlement(v3);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg1, &v4);
            let v5 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg4, v4);
            let (v6, v7) = swap_sy_for_pt_to_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg4, v5);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            let v8 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v8, begin_post_pool_operation<T0>(arg1, arg7, arg4));
            (v6, v7, v8)
        } else {
            assert_no_settlements(arg0);
            let (v9, v10) = swap_sy_for_pt_to_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            (v9, v10, 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun buy_yt<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg7: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg8: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg9: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg10: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        assert_pool_yt_reward_mode_match<T0>(arg6, arg8);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg6)) {
            assert_reward_distributor_matches_pool<T0>(arg2, arg6);
            assert_reward_distributor_matches_py_state<T0>(arg2, arg8);
            let v3 = &mut arg0;
            let v4 = take_one_settlement(v3);
            let v5 = &mut arg1;
            let v6 = take_one_settlement(v5);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v4);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v6);
            let v7 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg6, v4);
            let v8 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg8, v6, 0x2::tx_context::sender(arg13), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg7), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg7), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg7));
            let (v9, v10) = swap_sy_for_yt_to_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg8, v8);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg6, v7);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg1);
            let v11 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v11, begin_post_yt_operation(arg2, arg9, arg7, 0x2::tx_context::sender(arg13)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v11, begin_post_pool_operation<T0>(arg2, arg9, arg6));
            (v9, v10, v11)
        } else {
            assert_no_settlements(arg0);
            assert_no_settlements(arg1);
            let (v12, v13) = swap_sy_for_yt_to_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
            (v12, v13, 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    fun buy_yt_net_sy_for_amount<T0: drop>(arg0: u64, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: u128, arg5: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        if (arg0 == 0) {
            return (18446744073709551615, 0, 0, 0)
        };
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::calc_sy_amount_for_py<T0>(arg0, arg4, arg3);
        if (v0 == 0) {
            return (18446744073709551615, v0, 0, 0)
        };
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        if (v1 >= 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2)) {
            return (18446744073709551615, v0, v1, 0)
        };
        let v2 = quote_pt_sale_after_sy_borrow<T0>(arg0, v1, arg2, arg4, arg5);
        if (v2 < v1) {
            return (18446744073709551615, v0, v1, v2)
        };
        let v3 = if (v0 > v2) {
            v0 - v2
        } else {
            0
        };
        (v3, v0, v1, v2)
    }

    public fun claim_yt_interest<T0: drop>(arg0: 0x1::option::Option<0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>>, arg1: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::claim_interest<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun clamp_keep_yt_split(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1
        };
        if (arg1 >= arg0) {
            return arg0 - 1
        };
        arg1
    }

    public fun create_lp_position<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg0));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::mint_lp(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg0), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg0), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::market_id<T0>(arg0), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg0), arg2, arg3)
    }

    public fun create_position<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition {
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg0) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg1), 3002);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg0) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::market_id<T0>(arg1), 3002);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg1));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg0));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::mint_lp(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg0), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg0), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::expiry<T0>(arg0), arg3, arg4)
    }

    public fun create_py_position<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg0));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::mint_py(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg0), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg0), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::expiry<T0>(arg0), arg2, arg3)
    }

    fun keep_yt_lp_for_split<T0: drop>(arg0: u64, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: u128) : u64 {
        let v0 = clamp_keep_yt_split(arg0, arg1);
        let v1 = arg0 - v0;
        let v2 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::calc_py_amount_for_sy<T0>(v0, arg4, arg3);
        if (v1 == 0 || v2 == 0) {
            return 0
        };
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::calc_lp_amount(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::lp_supply<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg2), v1, v2)
    }

    fun lp_for_sy_to_pt_lp_split<T0: drop>(arg0: u64, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: u128, arg4: &0x2::clock::Clock) : u64 {
        if (arg1 == 0 || arg1 >= arg0) {
            return 0
        };
        let (v0, v1) = quote_sy_to_pt_for_lp_split<T0>(arg1, arg2, arg3, arg4);
        let v2 = if (v0 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            !split_can_add_without_pt_dust<T0>(arg0, v1, v0, arg2)
        };
        if (v2) {
            return 0
        };
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::calc_lp_amount(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::lp_supply<T0>(arg2), (((0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2) as u128) + (v1 as u128)) as u64), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg2) - v0, arg0 - v1, v0)
    }

    fun mint_exact_yt_with_net_sy_budget<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg7: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg8: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg8, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg5));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg8, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg7));
        assert_yt_route_match<T0>(arg5, arg6, arg7);
        assert!(arg1 > 0 && arg2 > 0, 3000);
        let (v0, v1, v2, _) = buy_yt_net_sy_for_amount<T0>(arg1, arg2, arg5, arg7, arg9, arg10);
        assert!(v0 <= arg2, 3001);
        assert!(v2 <= v1, 3001);
        let v4 = v1 - v2;
        assert!(0x2::coin::value<T0>(&arg0) >= v4, 3001);
        if (v2 == 0) {
            let v5 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::mint_py_with_sy_index<T0>(0x2::coin::split<T0>(&mut arg0, v1, arg11), arg9, arg6, arg7, arg10);
            assert_yt_output(v5, arg1, arg4);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::sub_pt(arg6, v5);
            let v6 = 0x2::coin::into_balance<T0>(arg0);
            0x2::balance::join<T0>(&mut v6, 0x2::coin::into_balance<T0>(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::swap_pt_for_sy<T0>(v5, 0, arg5, arg9, arg10, arg11)));
            let v7 = 0x2::coin::from_balance<T0>(v6, arg11);
            assert!(0x2::coin::value<T0>(&v7) >= arg3, 3001);
            return (v5, v7)
        };
        let (v8, v9) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::borrow_sy_for_yt_mint<T0>(arg5, v2, arg11);
        let v10 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, v4, arg11));
        0x2::balance::join<T0>(&mut v10, 0x2::coin::into_balance<T0>(v8));
        let v11 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::mint_py_with_sy_index<T0>(0x2::coin::from_balance<T0>(v10, arg11), arg9, arg6, arg7, arg10);
        assert_yt_output(v11, arg1, arg4);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::sub_pt(arg6, v11);
        let v12 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::swap_pt_for_sy<T0>(v11, v2, arg5, arg9, arg10, arg11);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::repay_borrowed_sy_for_yt_mint<T0>(arg5, v9, 0x2::coin::split<T0>(&mut v12, v2, arg11), arg9);
        let v13 = 0x2::coin::into_balance<T0>(arg0);
        0x2::balance::join<T0>(&mut v13, 0x2::coin::into_balance<T0>(v12));
        let v14 = 0x2::coin::from_balance<T0>(v13, arg11);
        assert!(0x2::coin::value<T0>(&v14) >= arg3, 3001);
        (v11, v14)
    }

    public fun mint_py_from_sy<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg5: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::mint_py<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun mint_py_from_sy_after_yt_reward_settlement<T0: drop>(arg0: 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg2: 0x2::coin::Coin<T0>, arg3: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (u64, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation) {
        assert_reward_distributor_matches_py_state<T0>(arg1, arg5);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg1, &arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg5, arg0, 0x2::tx_context::sender(arg8), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg4));
        let v1 = mint_py_from_sy<T0>(arg2, arg3, arg4, arg5, arg6, arg7);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg5, v0);
        (v1, begin_post_yt_operation(arg1, arg6, arg4, 0x2::tx_context::sender(arg8)))
    }

    fun mint_yt_and_sell_pt_for_sy<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg5));
        assert_yt_route_match<T0>(arg3, arg4, arg5);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = observe_pool_index<T0>(arg3, arg5, arg7, arg8);
        let v2 = solve_yt_out_for_net_sy_in<T0>(v0, arg3, arg5, v1, arg8);
        assert!(v2 >= arg1, 3001);
        mint_exact_yt_with_net_sy_budget<T0>(arg0, v2, v0, arg2, false, arg3, arg4, arg5, arg6, v1, arg8, arg9)
    }

    fun observe_pool_index<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg1: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg2: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg3: &0x2::clock::Clock) : u128 {
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg0) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg1), 3002);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::update_py_index<T0>(arg1, 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::consume<T0>(arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::market_id<T0>(arg0), arg3), arg3)
    }

    fun quote_pt_sale_after_sy_borrow<T0: drop>(arg0: u64, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: u128, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2);
        if (arg0 == 0 || arg1 >= v0) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg2) <= v1) {
            return 0
        };
        let (v2, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_exact_pt_for_sy_indexed(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg2), v0 - arg1, arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg2), arg0, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg2) - v1);
        v2
    }

    fun quote_sy_to_pt_for_lp_split<T0: drop>(arg0: u64, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg0 == 0 || 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg1) <= v0) {
            return (0, 0)
        };
        let (v1, v2, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_exact_sy_for_pt_indexed(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg1), arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg1), arg0, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg1) - v0);
        (v1, v2)
    }

    public fun redeem_after_expiry<T0: drop>(arg0: u64, arg1: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::redeem_py_after_expiry<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun redeem_before_expiry<T0: drop>(arg0: u64, arg1: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::redeem_py_before_expiry<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun redeem_before_expiry_after_yt_reward_settlement<T0: drop>(arg0: 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg2: u64, arg3: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation) {
        assert_reward_distributor_matches_py_state<T0>(arg1, arg5);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg1, &arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg5, arg0, 0x2::tx_context::sender(arg8), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg4));
        let v1 = redeem_before_expiry<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg5, v0);
        (v1, begin_post_yt_operation(arg1, arg6, arg4, 0x2::tx_context::sender(arg8)))
    }

    public(friend) fun remove_liquidity_to_position<T0: drop>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        assert_before(arg5, arg6, arg7);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::assert_state_match(arg4, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg3));
        let (v0, v1) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::remove_liquidity<T0>(arg0, arg3, arg4, arg7, arg8);
        let v2 = v0;
        assert!(0x2::coin::value<T0>(&v2) >= arg1, 3001);
        assert!(v1 >= arg2, 3001);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::add_pt(arg4, v1);
        (v2, v1)
    }

    public fun remove_lp<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg7: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg8: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg6)) {
            assert_reward_distributor_matches_pool<T0>(arg2, arg6);
            let v3 = &mut arg0;
            let v4 = take_one_settlement(v3);
            let v5 = &mut arg1;
            let v6 = take_one_settlement(v5);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v4);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v6);
            let v7 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg6, v4);
            let v8 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::begin_reward_mutation(arg7, v6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg2), 0x2::tx_context::sender(arg11));
            let (v9, v10) = remove_liquidity_to_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::end_reward_mutation(arg7, v8);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg6, v7);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg1);
            let v11 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v11, begin_post_lp_operation(arg2, arg8, arg7, 0x2::tx_context::sender(arg11)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v11, begin_post_pool_operation<T0>(arg2, arg8, arg6));
            (v9, v10, v11)
        } else {
            assert_no_settlements(arg0);
            assert_no_settlements(arg1);
            let (v12, v13) = remove_liquidity_to_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            (v12, v13, 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun sell_pt<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg2: u64, arg3: u64, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg7: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg8: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg4)) {
            assert_reward_distributor_matches_pool<T0>(arg1, arg4);
            let v2 = &mut arg0;
            let v3 = take_one_settlement(v2);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg1, &v3);
            let v4 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg4, v3);
            let v5 = swap_pt_for_sy_from_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg4, v4);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            let v6 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v6, begin_post_pool_operation<T0>(arg1, arg7, arg4));
            (v5, v6)
        } else {
            assert_no_settlements(arg0);
            (swap_pt_for_sy_from_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun sell_pt_for_exact_sy<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg2: u64, arg3: u64, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg7: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg8: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg4)) {
            assert_reward_distributor_matches_pool<T0>(arg1, arg4);
            let v3 = &mut arg0;
            let v4 = take_one_settlement(v3);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg1, &v4);
            let v5 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg4, v4);
            let (v6, v7) = swap_pt_for_exact_sy_from_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg4, v5);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            let v8 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v8, begin_post_pool_operation<T0>(arg1, arg7, arg4));
            (v6, v7, v8)
        } else {
            assert_no_settlements(arg0);
            let (v9, v10) = swap_pt_for_exact_sy_from_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            (v9, v10, 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    public fun sell_yt<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: u64, arg4: u64, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg6: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg7: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg8: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg9: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>) {
        assert_pool_yt_reward_mode_match<T0>(arg5, arg7);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg5)) {
            assert_reward_distributor_matches_pool<T0>(arg2, arg5);
            assert_reward_distributor_matches_py_state<T0>(arg2, arg7);
            let v2 = &mut arg0;
            let v3 = take_one_settlement(v2);
            let v4 = &mut arg1;
            let v5 = take_one_settlement(v4);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v3);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v5);
            let v6 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::begin_reward_operation<T0>(arg5, v3);
            let v7 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg7, v5, 0x2::tx_context::sender(arg12), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(arg6), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg6), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg6));
            let v8 = swap_yt_for_sy_to_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg7, v7);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::end_reward_operation<T0>(arg5, v6);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg1);
            let v9 = 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v9, begin_post_yt_operation(arg2, arg8, arg6, 0x2::tx_context::sender(arg12)));
            0x1::vector::push_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>(&mut v9, begin_post_pool_operation<T0>(arg2, arg8, arg5));
            (v8, v9)
        } else {
            assert_no_settlements(arg0);
            assert_no_settlements(arg1);
            (swap_yt_for_sy_to_position<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12), 0x1::vector::empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation>())
        }
    }

    fun sell_yt_for_sy_with_pt_settlement<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg6: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert_yt_route_match<T0>(arg2, arg3, arg4);
        let v0 = observe_pool_index<T0>(arg2, arg4, arg6, arg7);
        sell_yt_for_sy_with_pt_settlement_with_index<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg7, arg8)
    }

    fun sell_yt_for_sy_with_pt_settlement_with_index<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg2));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg4));
        assert_yt_route_match<T0>(arg2, arg3, arg4);
        assert!(arg0 > 0, 3000);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg2) > arg0, 3001);
        let (v0, v1) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::redeem_yt_with_external_pt_before_expiry_with_sy_index<T0>(arg0, arg6, arg3, arg4, arg7, arg8);
        let v2 = v0;
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 >= arg1, 3001);
        let (v4, v5) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::swap_sy_for_exact_pt<T0>(v2, arg0, v3 - arg1, arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::py_index_stored<T0>(arg4), arg7, arg8);
        let v6 = v5;
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::repay_borrowed_pt_for_yt_redeem<T0>(arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::borrow_pt_for_yt_redeem<T0>(arg2, arg0), arg0);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::settle_external_pt_redeem<T0>(arg4, v1, arg0);
        assert!(0x2::coin::value<T0>(&v6) >= arg1, 3001);
        (v6, v4)
    }

    fun solve_sy_to_mint_for_keep_yt<T0: drop>(arg0: u64, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: u128) : u64 {
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2);
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg2);
        let v2 = clamp_keep_yt_split(arg0, arg0 / 2);
        if (v0 > 0 && v1 > 0) {
            let v3 = 1;
            let v4 = arg0 - 1;
            let v5 = 0;
            while (v5 < 64 && v3 < v4) {
                let v6 = v3 + (v4 - v3 + 1) / 2;
                if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::calc_py_amount_for_sy<T0>(v6, arg4, arg3) <= (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(((arg0 - v6) as u128), (v1 as u128), (v0 as u128)) as u64)) {
                    v3 = v6;
                } else {
                    v4 = v6 - 1;
                };
                v5 = v5 + 1;
            };
            let v7 = better_keep_yt_split<T0>(arg0, clamp_keep_yt_split(arg0, v3), v3 + 1, arg2, arg3, arg4);
            v2 = v7;
            if (v3 > 1) {
                v2 = better_keep_yt_split<T0>(arg0, v7, v3 - 1, arg2, arg3, arg4);
            };
        };
        if (arg1 > 0) {
            v2 = better_keep_yt_split<T0>(arg0, v2, arg1, arg2, arg3, arg4);
        };
        v2
    }

    fun solve_sy_to_swap_for_lp_from_sy<T0: drop>(arg0: u64, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock) : u64 {
        if (arg0 <= 1) {
            return 0
        };
        let v0 = 1;
        let v1 = arg0 - 1;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 64 && v0 <= v1) {
            let v4 = v0 + (v1 - v0) / 2;
            let (v5, v6) = quote_sy_to_pt_for_lp_split<T0>(v4, arg1, arg2, arg3);
            if (v5 == 0 || v6 == 0) {
                v0 = v4 + 1;
            } else if (v6 >= arg0 || !split_can_add_without_pt_dust<T0>(arg0, v6, v5, arg1)) {
                if (v4 == 0) {
                    break
                };
                v1 = v4 - 1;
            } else {
                v2 = v4;
                v0 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        let v7 = better_sy_to_swap_for_lp<T0>(arg0, v2, arg0 / 2, arg1, arg2, arg3);
        v2 = v7;
        if (v7 + 1 < arg0) {
            v2 = better_sy_to_swap_for_lp<T0>(arg0, v7, v7 + 1, arg1, arg2, arg3);
        };
        if (v2 > 1) {
            let v8 = v2 - 1;
            v2 = better_sy_to_swap_for_lp<T0>(arg0, v2, v8, arg1, arg2, arg3);
        };
        v2
    }

    fun solve_yt_out_for_net_sy_in<T0: drop>(arg0: u64, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg3: u128, arg4: &0x2::clock::Clock) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg1) <= 1) {
            true
        } else {
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg1) == 0
        };
        if (v0) {
            return 0
        };
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg1) - 1;
        let v2 = if (18446744073709551615 - arg0 > v1) {
            arg0 + v1
        } else {
            18446744073709551615
        };
        let v3 = 0;
        let v4 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::calc_py_amount_for_sy<T0>(v2, arg3, arg2);
        let v5 = 0;
        while (v5 < 64 && v3 < v4) {
            let v6 = v3 + (v4 - v3 + 1) / 2;
            let (v7, _, _, _) = buy_yt_net_sy_for_amount<T0>(v6, arg0, arg1, arg2, arg3, arg4);
            if (v7 <= arg0) {
                v3 = v6;
            } else {
                v4 = v6 - 1;
            };
            v5 = v5 + 1;
        };
        v3
    }

    fun split_can_add_without_pt_dust<T0: drop>(arg0: u64, arg1: u64, arg2: u64, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) : bool {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg1 >= arg0) {
            true
        } else {
            arg2 >= 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg3)
        };
        if (v0) {
            return false
        };
        let v1 = (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg3) as u128) + (arg1 as u128);
        if (v1 > 18446744073709551615) {
            return false
        };
        let v2 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg3) - arg2;
        if (v2 == 0) {
            return false
        };
        arg2 <= (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(((arg0 - arg1) as u128), (v2 as u128), v1) as u64)
    }

    public(friend) fun swap_pt_for_exact_sy_from_position<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg6: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg2));
        assert_before(arg5, arg7, arg8);
        assert_yt_route_match<T0>(arg2, arg3, arg4);
        let (v0, v1) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::swap_pt_for_exact_sy<T0>(arg0, arg1, arg2, observe_pool_index<T0>(arg2, arg4, arg6, arg8), arg8, arg9);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::sub_pt(arg3, v0);
        let v2 = RouterSwapEvent{
            user       : 0x2::tx_context::sender(arg9),
            direction  : 1,
            amount_in  : v0,
            amount_out : arg0,
        };
        0x2::event::emit<RouterSwapEvent>(v2);
        (v0, v1)
    }

    public(friend) fun swap_pt_for_sy_from_position<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg6: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg2));
        assert_before(arg5, arg7, arg8);
        assert_yt_route_match<T0>(arg2, arg3, arg4);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::sub_pt(arg3, arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::swap_pt_for_sy<T0>(arg0, arg1, arg2, observe_pool_index<T0>(arg2, arg4, arg6, arg8), arg8, arg9);
        let v1 = RouterSwapEvent{
            user       : 0x2::tx_context::sender(arg9),
            direction  : 1,
            amount_in  : arg0,
            amount_out : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<RouterSwapEvent>(v1);
        v0
    }

    public(friend) fun swap_sy_for_exact_pt_to_position<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        assert_before(arg6, arg8, arg9);
        assert_yt_route_match<T0>(arg3, arg4, arg5);
        let (v0, v1) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::swap_sy_for_exact_pt<T0>(arg0, arg1, arg2, arg3, observe_pool_index<T0>(arg3, arg5, arg7, arg9), arg9, arg10);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::add_pt(arg4, arg1);
        let v2 = RouterSwapEvent{
            user       : 0x2::tx_context::sender(arg10),
            direction  : 0,
            amount_in  : v0,
            amount_out : arg1,
        };
        0x2::event::emit<RouterSwapEvent>(v2);
        (v0, v1)
    }

    public(friend) fun swap_sy_for_exact_yt_to_position<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg5));
        assert_before(arg6, arg8, arg9);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::assert_state_match(arg4, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg5));
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg3) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg5), 3002);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::market_id(arg4) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg5), 3002);
        assert!(arg1 > 0, 3000);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = observe_pool_index<T0>(arg3, arg5, arg7, arg9);
        let (v2, v3) = mint_exact_yt_with_net_sy_budget<T0>(arg0, arg1, arg2, 0, true, arg3, arg4, arg5, arg6, v1, arg9, arg10);
        let v4 = v3;
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = if (v0 > v5) {
            v0 - v5
        } else {
            0
        };
        assert!(v6 <= arg2, 3001);
        let v7 = RouterSwapYtEvent{
            user          : 0x2::tx_context::sender(arg10),
            sy_amount_in  : v6,
            yt_amount_out : v2,
            sy_amount_out : 0x2::coin::value<T0>(&v4),
        };
        0x2::event::emit<RouterSwapYtEvent>(v7);
        v4
    }

    public(friend) fun swap_sy_for_pt_to_position<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg6: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg2));
        assert_before(arg5, arg7, arg8);
        assert_yt_route_match<T0>(arg2, arg3, arg4);
        let (v0, v1, v2) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::swap_sy_for_pt<T0>(arg0, arg1, arg2, observe_pool_index<T0>(arg2, arg4, arg6, arg8), arg8, arg9);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::add_pt(arg3, v0);
        let v3 = RouterSwapEvent{
            user       : 0x2::tx_context::sender(arg9),
            direction  : 0,
            amount_in  : v1,
            amount_out : v0,
        };
        0x2::event::emit<RouterSwapEvent>(v3);
        (v0, v2)
    }

    public(friend) fun swap_sy_for_yt_to_position<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg7: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg6, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg5));
        assert_before(arg6, arg8, arg9);
        let (v0, v1) = mint_yt_and_sell_pt_for_sy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v2 = v1;
        let v3 = RouterSwapYtEvent{
            user          : 0x2::tx_context::sender(arg10),
            sy_amount_in  : 0x2::coin::value<T0>(&arg0),
            yt_amount_out : v0,
            sy_amount_out : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<RouterSwapYtEvent>(v3);
        (v0, v2)
    }

    public(friend) fun swap_yt_for_sy_to_position<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg6: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg2));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg4));
        assert_before(arg5, arg7, arg8);
        let (v0, v1) = sell_yt_for_sy_with_pt_settlement<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v2 = v0;
        let v3 = RouterSwapYtForSyEvent{
            user             : 0x2::tx_context::sender(arg9),
            yt_amount_in     : arg0,
            sy_amount_out    : 0x2::coin::value<T0>(&v2),
            sy_amount_repaid : v1,
        };
        0x2::event::emit<RouterSwapYtForSyEvent>(v3);
        v2
    }

    fun take_one_settlement(arg0: &mut vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>) : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement {
        assert!(0x1::vector::length<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0) == 1, 3005);
        0x1::vector::pop_back<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0)
    }

    public fun transfer_lp_position_after_reward_settlement<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg2: 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg5: address, arg6: &0x2::tx_context::TxContext) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg4, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::assert_pool_match(&arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3));
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::is_py_empty(&arg2), 3006);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg3)) {
            assert_reward_distributor_matches_pool<T0>(arg1, arg3);
            let v0 = &mut arg0;
            let v1 = take_one_settlement(v0);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg1, &v1);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::end_reward_mutation(&mut arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::begin_reward_mutation(&mut arg2, v1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg1), 0x2::tx_context::sender(arg6)));
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
        } else {
            assert_no_settlements(arg0);
        };
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::transfer_position(arg2, arg5);
    }

    public fun transfer_position_after_reward_settlement<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg7: address, arg8: &0x2::tx_context::TxContext) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_pool_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg6));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg5, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg4));
        assert_yt_route_match<T0>(arg6, &arg3, arg4);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::assert_pool_match(&arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg6));
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_reward_distributor_required<T0>(arg4)) {
            assert_reward_distributor_matches_py_state<T0>(arg2, arg4);
            let v0 = &mut arg0;
            let v1 = take_one_settlement(v0);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v1);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg4, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg4, v1, 0x2::tx_context::sender(arg8), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(&arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(&arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(&arg3)));
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
        } else {
            assert_no_settlements(arg0);
        };
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg6)) {
            assert_reward_distributor_matches_pool<T0>(arg2, arg6);
            let v2 = &mut arg1;
            let v3 = take_one_settlement(v2);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg2, &v3);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::end_reward_mutation(&mut arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::begin_reward_mutation(&mut arg3, v3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg2), 0x2::tx_context::sender(arg8)));
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg1);
        } else {
            assert_no_settlements(arg1);
        };
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::transfer_position(arg3, arg7);
    }

    public fun transfer_py_position_after_reward_settlement<T0: drop>(arg0: vector<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg2: 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg5: address, arg6: &0x2::tx_context::TxContext) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_py_state_active(arg4, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg3));
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::assert_state_match(&arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg3));
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::market_id(&arg2) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg3), 3002);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::is_lp_empty(&arg2), 3006);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_reward_distributor_required<T0>(arg3)) {
            assert_reward_distributor_matches_py_state<T0>(arg1, arg3);
            let v0 = &mut arg0;
            let v1 = take_one_settlement(v0);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_settlement_config_current(arg1, &v1);
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::end_yt_reward_mutation<T0>(arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::begin_yt_reward_mutation<T0>(arg3, v1, 0x2::tx_context::sender(arg6), 0x2::object::id<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition>(&arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(&arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(&arg2)));
            0x1::vector::destroy_empty<0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardSettlement>(arg0);
        } else {
            assert_no_settlements(arg0);
        };
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::transfer_position(arg2, arg5);
    }

    // decompiled from Move bytecode v7
}

