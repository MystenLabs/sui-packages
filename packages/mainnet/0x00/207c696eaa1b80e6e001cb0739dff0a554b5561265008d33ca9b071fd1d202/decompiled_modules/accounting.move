module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting {
    public(friend) fun accrued_token_exchange_price<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: u64, arg3: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) : u256 {
        let (v0, _, _, _, _, _, _, _) = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_user_supply_data<T0>(arg1, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::holder<T0>(arg0));
        assert!(v0, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_liquidity_mode_unexpected());
        let (v8, v9) = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::exchange_prices<T0>(arg0);
        let v10 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::liquidity_return(v8, arg2);
        if (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::has_rewards<T0>(arg0)) {
            let v11 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::get_rate_segments(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::borrow_rewards<T0>(arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::total_shares<T0>(arg0), v9, false), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::last_update_s<T0>(arg0), arg3);
            while (!0x1::vector::is_empty<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RateSegment>(&v11)) {
                let v12 = 0x1::vector::pop_back<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RateSegment>(&mut v11);
                assert!(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::segment_rate(&v12) <= 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::max_rewards_rate(), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::rewards_rate_above_cap());
                v10 = v10 + 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::rewards_return(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::segment_rate(&v12), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::elapsed_since(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::segment_to(&v12), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::segment_from(&v12)));
            };
        };
        (v9 as u256) + 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div((v9 as u256), (v10 as u256), (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::return_percent_precision() as u256))
    }

    public fun backed<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::assert_bound<T0>(arg0, arg1);
        let (v0, _) = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_exchange_prices<T0>(arg1, arg2);
        backed_at<T0>(arg0, arg1, (v0 as u64))
    }

    public(friend) fun backed_at<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: u64) : u64 {
        let (v0, v1, _, _, _, _, _, _) = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_user_supply_data<T0>(arg1, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::holder<T0>(arg0));
        if (v0) {
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(v1, arg2, false)
        } else {
            v1
        }
    }

    public(friend) fun calculate_new_token_exchange_price<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::assert_bound<T0>(arg0, arg1);
        (accrued_token_exchange_price<T0>(arg0, arg1, get_liquidity_exchange_price<T0>(arg1, arg2), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg2)) as u64)
    }

    public fun can_operate<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg3: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action) : bool {
        if (!has_liquidity_binding<T0>(arg0, arg1, arg2)) {
            return false
        };
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_user_supply_pause<T0>(arg1, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::holder<T0>(arg0), arg3)) {
            return false
        };
        let v0 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_pause_flags<T0>(arg1);
        let v1 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::get_pause_flags(arg2);
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::get_allows(&v0, arg3) && 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::get_allows(&v1, arg3)
    }

    public(friend) fun get_liquidity_exchange_price<T0>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg1: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_exchange_prices<T0>(arg0, arg1);
        (v0 as u64)
    }

    public fun has_liquidity_binding<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry) : bool {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::assert_bound<T0>(arg0, arg1);
        let v0 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::has_liquidity_cap<T0>(arg0) && 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::user_cap::get_is_active<T0>(arg2, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::holder<T0>(arg0));
        if (!v0) {
            return false
        };
        let (v1, _, _, _, _, _, _, _) = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_user_supply_data<T0>(arg1, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::holder<T0>(arg0));
        v1
    }

    public fun is_live<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry) : bool {
        can_operate<T0>(arg0, arg1, arg2, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_supply()) && can_operate<T0>(arg0, arg1, arg2, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_withdraw())
    }

    public fun nav_owed<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::assert_bound<T0>(arg0, arg1);
        nav_owed_at<T0>(arg0, arg1, get_liquidity_exchange_price<T0>(arg1, arg2), arg2)
    }

    public(friend) fun nav_owed_at<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::total_shares<T0>(arg0), (accrued_token_exchange_price<T0>(arg0, arg1, arg2, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg3)) as u64), false)
    }

    public fun preview_deposit<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::assert_bound<T0>(arg0, arg1);
        let v0 = get_liquidity_exchange_price<T0>(arg1, arg3);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_shares(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_shares(arg2, v0, false), v0, false), (accrued_token_exchange_price<T0>(arg0, arg1, v0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg3)) as u64), false)
    }

    public fun preview_mint<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(arg2, calculate_new_token_exchange_price<T0>(arg0, arg1, arg3), true)
    }

    public fun preview_redeem<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(arg2, calculate_new_token_exchange_price<T0>(arg0, arg1, arg3), false)
    }

    public fun preview_withdraw<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_shares(arg2, calculate_new_token_exchange_price<T0>(arg0, arg1, arg3), true)
    }

    public fun total_assets<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::total_shares<T0>(arg0), calculate_new_token_exchange_price<T0>(arg0, arg1, arg2), false)
    }

    public(friend) fun update_rates<T0>(arg0: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg3);
        let (v1, v2) = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::exchange_prices<T0>(arg0);
        if (v0 == 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::last_update_s<T0>(arg0) && arg2 == v1) {
            return v2
        };
        let v3 = (accrued_token_exchange_price<T0>(arg0, arg1, arg2, v0) as u64);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::store_prices<T0>(arg0, v3, arg2, v0);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_update_rates(0x1::type_name::with_defining_ids<T0>(), v3, arg2);
        v3
    }

    public(friend) fun update_rates_from_reserve<T0>(arg0: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::assert_bound<T0>(arg0, arg1);
        update_rates<T0>(arg0, arg1, get_liquidity_exchange_price<T0>(arg1, arg2), arg2)
    }

    // decompiled from Move bytecode v7
}

