module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::admin {
    public fun init_lending<T0>(arg0: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0x2::coin_registry::Currency<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::asserts::assert_listable<T0>(arg0, arg1, arg3, arg6);
        share_lending_state<T0>(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::create<T0>(arg0, arg2, arg3, arg4, arg5, arg6));
    }

    public fun init_lending_with_metadata<T0>(arg0: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::asserts::assert_listable<T0>(arg0, arg1, arg3, arg6);
        share_lending_state<T0>(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::create_with_metadata<T0>(arg0, arg2, arg3, arg4, arg5, arg6));
    }

    public fun migrate(arg0: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: &0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::assert_is_admin(arg1, 0x2::tx_context::sender(arg2));
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::migrate(arg0);
    }

    public fun mint_rewards_writer_cap<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0> {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::assert_admin(arg0, arg1, arg3);
        let v0 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::new_writer_cap<T0>(0x2::object::id<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>>(arg2), arg3);
        let v1 = 0x2::object::id<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0>>(&v0);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::set_rewards_writer<T0>(arg2, 0x1::option::some<0x2::object::ID>(v1));
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_set_rewards_writer(0x1::type_name::with_defining_ids<T0>(), 0x1::option::some<0x2::object::ID>(v1));
        v0
    }

    public fun rebalance<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::assert_role<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::RebalancerRole>(arg0, arg1, arg7);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::assert_bound<T0>(arg2, arg4);
        let v0 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::get_liquidity_exchange_price<T0>(arg4, arg6);
        let v1 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::nav_owed_at<T0>(arg2, arg4, v0, arg6);
        let v2 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::backed_at<T0>(arg2, arg4, v0);
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        let v4 = if (v3 == 0) {
            0
        } else {
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets((0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_ceil((v3 as u256), (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::exchange_prices_precision() as u256), (v0 as u256)) as u64), v0, true)
        };
        let v5 = 0x1::u64::min(v4, 0x2::balance::value<T0>(&arg5));
        let (_, v7) = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::liquidity::supply<T0>(arg2, arg3, arg4, 0x2::balance::split<T0>(&mut arg5, v5), arg6, arg7);
        if (v3 > 0 && v5 == v4) {
            assert!(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::backed_at<T0>(arg2, arg4, v0) >= v1, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::rebalance_gap_not_closed());
        };
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::update_rates<T0>(arg2, arg4, v7, arg6);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_rebalance(0x1::type_name::with_defining_ids<T0>(), v5);
        arg5
    }

    public fun revoke_rewards_writer<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg3: &0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::assert_admin(arg0, arg1, arg3);
        assert!(!0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::has_rewards<T0>(arg2), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::rewards_still_configured());
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::set_rewards_writer<T0>(arg2, 0x1::option::none<0x2::object::ID>());
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_set_rewards_writer(0x1::type_name::with_defining_ids<T0>(), 0x1::option::none<0x2::object::ID>());
    }

    public fun set_rewards_schedule<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0>, arg2: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: 0x1::option::Option<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>, arg5: &0x2::clock::Clock) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::assert_version(arg0);
        assert!(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::cap_state_id<T0>(arg1) == 0x2::object::id<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>>(arg2), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::cap_holder_mismatch());
        assert!(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::rewards_writer<T0>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0>>(arg1)), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::cap_holder_mismatch());
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::update_rates_from_reserve<T0>(arg2, arg3, arg5);
        if (0x1::option::is_some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(&arg4)) {
            let v0 = 0x1::option::destroy_some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(arg4);
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::set_rewards<T0>(arg2, v0);
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_set_rewards_schedule(0x1::type_name::with_defining_ids<T0>(), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::start_tvl(&v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::start_s(&v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::yearly_reward(&v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::next_start_s(&v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::next_end_s(&v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::next_yearly_reward(&v0));
        } else if (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::has_rewards<T0>(arg2)) {
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::clear_rewards<T0>(arg2);
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_clear_rewards(0x1::type_name::with_defining_ids<T0>());
        };
    }

    fun share_lending_state<T0>(arg0: 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::share<T0>(arg0);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_lending_state_created(0x2::object::id<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>>(&arg0), 0x1::type_name::with_defining_ids<T0>());
    }

    public fun update_admin(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::assert_admin(arg0, arg1, arg4);
        if (arg3) {
            assert!(arg2 != @0x0, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_invalid_params());
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::add_admin(arg1, arg2);
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_add_admin(arg2);
        } else {
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::remove_admin(arg1, arg2);
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_remove_admin(arg2);
        };
    }

    public fun update_role<T0: drop + store>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::assert_admin(arg0, arg1, arg4);
        if (arg3) {
            assert!(arg2 != @0x0, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_invalid_params());
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::grant_rate_admin_or_rebalancer_role<T0>(arg1, arg2);
        } else {
            0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::revoke_rate_admin_or_rebalancer_role<T0>(arg1, arg2);
        };
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_role_change(0x1::type_name::with_defining_ids<T0>(), arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

