module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::user {
    public fun withdraw<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: u64, arg5: 0x2::balance::Balance<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::asserts::assert_ready<T0>(arg0, arg1, arg3, arg2);
        let v0 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_shares(arg4, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::update_rates_from_reserve<T0>(arg1, arg3, arg6), true);
        assert!(0x2::balance::value<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>(&arg5) >= v0, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::insufficient_shares());
        (execute_withdraw<T0>(arg1, arg2, arg3, arg4, 0x2::balance::split<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>(&mut arg5, v0), arg6, arg7), arg5)
    }

    public fun deposit<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>> {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::asserts::assert_ready<T0>(arg0, arg1, arg3, arg2);
        let v0 = execute_deposit<T0>(arg1, arg2, arg3, arg4, arg6, arg7);
        assert!(0x2::balance::value<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>(&v0) >= arg5, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_min_amount_out());
        v0
    }

    fun execute_deposit<T0>(arg0: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg2: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>> {
        let (v0, v1) = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::liquidity::supply<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_shares(v0, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::update_rates<T0>(arg0, arg2, v1, arg4), false);
        assert!(v2 != 0, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_deposit_insignificant());
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_deposit(0x1::type_name::with_defining_ids<T0>(), 0x2::tx_context::sender(arg5), v0, v2);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::mint_share_balance<T0>(arg0, v2)
    }

    fun execute_withdraw<T0>(arg0: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg2: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg3: u64, arg4: 0x2::balance::Balance<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events::emit_log_withdraw(0x1::type_name::with_defining_ids<T0>(), 0x2::tx_context::sender(arg6), arg3, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::burn_share_balance<T0>(arg0, arg4));
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::liquidity::withdraw<T0>(arg0, arg1, arg2, arg3, arg5, arg6)
    }

    public fun mint<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>, 0x2::balance::Balance<T0>) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::asserts::assert_ready<T0>(arg0, arg1, arg3, arg2);
        let v0 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(arg4, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::calculate_new_token_exchange_price<T0>(arg1, arg3, arg7), true);
        assert!(0x2::balance::value<T0>(&arg6) >= v0, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::insufficient_assets());
        let v1 = execute_deposit<T0>(arg1, arg2, arg3, 0x2::balance::split<T0>(&mut arg6, v0), arg7, arg8);
        assert!(0x2::balance::value<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>(&v1) >= arg5, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_min_amount_out());
        (v1, arg6)
    }

    public fun redeem<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: 0x2::balance::Balance<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::asserts::assert_ready<T0>(arg0, arg1, arg3, arg2);
        let v0 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs::to_assets(0x2::balance::value<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::FToken<T0>>(&arg4), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::update_rates_from_reserve<T0>(arg1, arg3, arg6), false);
        assert!(v0 >= arg5, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_min_amount_out());
        execute_withdraw<T0>(arg1, arg2, arg3, v0, arg4, arg6, arg7)
    }

    public fun update_rate<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg3: &0x2::clock::Clock) : (u64, u64) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::asserts::assert_active<T0>(arg0, arg1, arg2);
        let v0 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::get_liquidity_exchange_price<T0>(arg2, arg3);
        (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::update_rates<T0>(arg1, arg2, v0, arg3), v0)
    }

    // decompiled from Move bytecode v7
}

