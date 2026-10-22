module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::admin {
    public fun disable_timelock(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap, arg3: &0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::assert_version(arg0);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_is_admin_direct(arg1, arg3);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::disable_timelock(arg1, arg2);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_timelock_disabled(0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap>(&arg2));
    }

    public fun init_lending<T0>(arg0: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>, arg3: &mut 0x2::coin_registry::CoinRegistry, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x2::coin_registry::Currency<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::asserts::assert_listable<T0>(arg0, arg1, arg4, arg2, arg7);
        share_lending_state<T0>(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::create<T0>(arg0, arg3, arg4, arg5, arg6, arg7));
    }

    public fun init_lending_with_metadata<T0>(arg0: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>, arg3: &mut 0x2::coin_registry::CoinRegistry, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::asserts::assert_listable<T0>(arg0, arg1, arg4, arg2, arg7);
        share_lending_state<T0>(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::create_with_metadata<T0>(arg0, arg3, arg4, arg5, arg6, arg7));
    }

    public fun migrate(arg0: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: &0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_is_migrator(arg1, arg2);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::migrate(arg0);
    }

    public fun mint_rewards_writer_cap<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>, arg3: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsWriterCap<T0> {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_admin(arg0, arg1, arg2, arg4);
        let v0 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::new_writer_cap<T0>(0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>>(arg3), arg4);
        let v1 = 0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsWriterCap<T0>>(&v0);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::set_rewards_writer<T0>(arg3, 0x1::option::some<0x2::object::ID>(v1));
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_set_rewards_writer(0x1::type_name::with_defining_ids<T0>(), 0x1::option::some<0x2::object::ID>(v1));
        v0
    }

    public fun mint_timelock_cap(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: &mut 0x2::tx_context::TxContext) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::assert_version(arg0);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_is_admin_direct(arg1, arg2);
        let v0 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::enable_timelock(arg1, arg2);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_timelock_enabled(0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public fun rebalance<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg3: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg4: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_role<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::RebalancerRole>(arg0, arg1, arg7);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::assert_bound<T0>(arg2, arg4);
        let v0 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::accounting::get_liquidity_exchange_price<T0>(arg4, arg6);
        let v1 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::accounting::nav_owed_at<T0>(arg2, arg4, v0, arg6);
        let v2 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::accounting::backed_at<T0>(arg2, arg4, v0);
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        let v4 = if (v3 == 0) {
            0
        } else {
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_calcs::to_assets((0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil((v3 as u256), (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::exchange_prices_precision() as u256), (v0 as u256)) as u64), v0, true)
        };
        let v5 = 0x1::u64::min(v4, 0x2::balance::value<T0>(&arg5));
        assert!(v5 != 0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::nothing_to_rebalance());
        let (_, v7) = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::liquidity::supply<T0>(arg2, arg3, arg4, 0x2::balance::split<T0>(&mut arg5, v5), arg6, arg7);
        if (v3 > 0 && v5 == v4) {
            assert!(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::accounting::backed_at<T0>(arg2, arg4, v0) >= v1, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::rebalance_gap_not_closed());
        };
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::accounting::update_rates<T0>(arg2, arg4, v7, arg6);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_rebalance(0x1::type_name::with_defining_ids<T0>(), v5);
        arg5
    }

    public fun revoke_rewards_writer<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>, arg3: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg4: &0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_admin(arg0, arg1, arg2, arg4);
        let v0 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::rewards_writer<T0>(arg3);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::rewards_writer_not_configured());
        assert!(!0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::has_rewards<T0>(arg3), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::rewards_still_configured());
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::set_rewards_writer<T0>(arg3, 0x1::option::none<0x2::object::ID>());
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_set_rewards_writer(0x1::type_name::with_defining_ids<T0>(), 0x1::option::none<0x2::object::ID>());
    }

    public fun set_rewards_schedule<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsWriterCap<T0>, arg2: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg3: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>, arg5: &0x2::clock::Clock) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::assert_version(arg0);
        assert!(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::cap_state_id<T0>(arg1) == 0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>>(arg2), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::cap_holder_mismatch());
        assert!(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::rewards_writer<T0>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsWriterCap<T0>>(arg1)), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::cap_holder_mismatch());
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::accounting::update_rates_from_reserve<T0>(arg2, arg3, arg5);
        if (0x1::option::is_some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(&arg4)) {
            let v0 = 0x1::option::destroy_some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(arg4);
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::set_rewards<T0>(arg2, v0);
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_set_rewards_schedule(0x1::type_name::with_defining_ids<T0>(), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::start_tvl(&v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::start_s(&v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::yearly_reward(&v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::next_start_s(&v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::next_end_s(&v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::next_yearly_reward(&v0));
        } else if (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::has_rewards<T0>(arg2)) {
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::clear_rewards<T0>(arg2);
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_clear_rewards(0x1::type_name::with_defining_ids<T0>());
        };
    }

    fun share_lending_state<T0>(arg0: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::share<T0>(arg0);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_lending_state_created(0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>>(&arg0), 0x1::type_name::with_defining_ids<T0>());
    }

    public fun update_admin(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_admin(arg0, arg1, arg2, arg5);
        if (arg4) {
            assert!(arg3 != @0x0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::f_token_invalid_params());
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::add_admin(arg1, arg3);
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_add_admin(arg3);
        } else {
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::remove_admin(arg1, arg3);
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_remove_admin(arg3);
        };
    }

    public fun update_role<T0: drop + store>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_admin(arg0, arg1, arg2, arg5);
        if (arg4) {
            assert!(arg3 != @0x0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::f_token_invalid_params());
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::grant_operator_role<T0>(arg1, arg3);
        } else {
            0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::revoke_operator_role<T0>(arg1, arg3);
        };
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_role_change(0x1::type_name::with_defining_ids<T0>(), arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

