module 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::accounting {
    public(friend) fun accrued_token_exchange_price<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64, arg3: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::TimestampS) : u256 {
        let (v0, _, _, _, _, _, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_data<T0>(arg1, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::holder<T0>(arg0));
        assert!(v0, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::errors::f_token_liquidity_mode_unexpected());
        let (v8, v9) = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::exchange_prices<T0>(arg0);
        let v10 = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::liquidity_return(v9, arg2);
        if (0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::has_rewards<T0>(arg0)) {
            let v11 = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::get_rate_segments(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::borrow_rewards<T0>(arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::total_shares<T0>(arg0), v8, true), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::last_update_s<T0>(arg0), arg3);
            while (!0x1::vector::is_empty<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RateSegment>(&v11)) {
                let v12 = 0x1::vector::pop_back<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RateSegment>(&mut v11);
                assert!(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::segment_rate(&v12) <= 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::max_rewards_rate(), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::errors::rewards_rate_above_cap());
                v10 = v10 + 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::rewards_return(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::segment_rate(&v12), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::elapsed_since(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::segment_to(&v12), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::segment_from(&v12)));
            };
        };
        (v8 as u256) + 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div((v8 as u256), (v10 as u256), (0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::return_percent_precision() as u256))
    }

    public fun backed<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::assert_bound<T0>(arg0, arg1);
        let (v0, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_exchange_prices<T0>(arg1, arg2);
        backed_at<T0>(arg0, arg1, (v0 as u64))
    }

    public(friend) fun backed_at<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64) : u64 {
        let (v0, v1, _, _, _, _, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_data<T0>(arg1, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::holder<T0>(arg0));
        if (v0) {
            0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(v1, arg2, false)
        } else {
            v1
        }
    }

    public(friend) fun calculate_new_token_exchange_price<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::assert_bound<T0>(arg0, arg1);
        (accrued_token_exchange_price<T0>(arg0, arg1, get_liquidity_exchange_price<T0>(arg1, arg2), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg2)) as u64)
    }

    public fun can_operate<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg3: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action) : bool {
        if (!has_liquidity_binding<T0>(arg0, arg1, arg2)) {
            return false
        };
        if (arg3 == 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::action_borrow() || arg3 == 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::action_payback()) {
            return false
        };
        if (0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_pause<T0>(arg1, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::holder<T0>(arg0), arg3)) {
            return false
        };
        let v0 = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_pause_flags<T0>(arg1);
        let v1 = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::get_pause_flags(arg2);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::get_allows(&v0, arg3) && 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::get_allows(&v1, arg3)
    }

    public(friend) fun get_liquidity_exchange_price<T0>(arg0: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg1: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_exchange_prices<T0>(arg0, arg1);
        (v0 as u64)
    }

    public fun has_liquidity_binding<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry) : bool {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::assert_bound<T0>(arg0, arg1);
        let v0 = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::has_liquidity_cap<T0>(arg0) && 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::get_is_active<T0>(arg2, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::holder<T0>(arg0));
        if (!v0) {
            return false
        };
        let (v1, _, _, _, _, _, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_data<T0>(arg1, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::holder<T0>(arg0));
        v1
    }

    public fun is_live<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry) : bool {
        can_operate<T0>(arg0, arg1, arg2, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::action_supply()) && can_operate<T0>(arg0, arg1, arg2, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::action_withdraw())
    }

    public fun nav_owed<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::assert_bound<T0>(arg0, arg1);
        nav_owed_at<T0>(arg0, arg1, get_liquidity_exchange_price<T0>(arg1, arg2), arg2)
    }

    public(friend) fun nav_owed_at<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::total_shares<T0>(arg0), (accrued_token_exchange_price<T0>(arg0, arg1, arg2, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg3)) as u64), false)
    }

    public fun preview_deposit<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::assert_bound<T0>(arg0, arg1);
        let v0 = get_liquidity_exchange_price<T0>(arg1, arg3);
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_shares(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_shares(arg2, v0, false), v0, false), (accrued_token_exchange_price<T0>(arg0, arg1, v0, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg3)) as u64), false)
    }

    public fun preview_mint<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::assert_bound<T0>(arg0, arg1);
        let v0 = get_liquidity_exchange_price<T0>(arg1, arg3);
        let v1 = (accrued_token_exchange_price<T0>(arg0, arg1, v0, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg3)) as u64);
        let v2 = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(arg2, v1, true);
        (v2, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_shares(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_shares(v2, v0, false), v0, false), v1, false))
    }

    public fun preview_redeem<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        redeem_assets_payout(arg2, get_liquidity_exchange_price<T0>(arg1, arg3), calculate_new_token_exchange_price<T0>(arg0, arg1, arg3))
    }

    public fun preview_withdraw<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = calculate_new_token_exchange_price<T0>(arg0, arg1, arg3);
        0x1::u64::max(withdraw_shares_needed<T0>(arg0, arg1, arg2, get_liquidity_exchange_price<T0>(arg1, arg3), v0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_shares(arg2, v0, true))
    }

    public(friend) fun redeem_assets_payout(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_shares(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(arg0, arg2, false), arg1, false), arg1, false)
    }

    public fun total_assets<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::total_shares<T0>(arg0), calculate_new_token_exchange_price<T0>(arg0, arg1, arg2), false)
    }

    public(friend) fun update_rates<T0>(arg0: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg3);
        let (v1, v2) = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::exchange_prices<T0>(arg0);
        if (v0 == 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::last_update_s<T0>(arg0) && arg2 == v2) {
            return v1
        };
        let v3 = (accrued_token_exchange_price<T0>(arg0, arg1, arg2, v0) as u64);
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::store_prices<T0>(arg0, v3, arg2, v0);
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::events::emit_log_update_rates(0x1::type_name::with_defining_ids<T0>(), v3, arg2);
        v3
    }

    public(friend) fun update_rates_from_reserve<T0>(arg0: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::assert_bound<T0>(arg0, arg1);
        update_rates<T0>(arg0, arg1, get_liquidity_exchange_price<T0>(arg1, arg2), arg2)
    }

    public(friend) fun withdraw_shares_needed<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let (_, v1, _, _, _, _, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_data<T0>(arg1, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::holder<T0>(arg0));
        let v8 = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_shares(arg2, arg3, true);
        let v9 = if (v8 > v1) {
            v1
        } else {
            v8
        };
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_shares(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(v1, arg3, false) - 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(v1 - v9, arg3, false), arg4, true)
    }

    // decompiled from Move bytecode v7
}

