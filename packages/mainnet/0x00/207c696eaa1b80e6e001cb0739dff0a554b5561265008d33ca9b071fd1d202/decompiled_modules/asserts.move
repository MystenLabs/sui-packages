module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::asserts {
    public(friend) fun assert_active<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::assert_version(arg0);
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::assert_bound<T0>(arg1, arg2);
    }

    public(friend) fun assert_listable<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::Auth, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg3: &0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth::assert_admin(arg0, arg1, arg3);
        assert!(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_rate_data_set<T0>(arg2) && 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::get_token_config_set<T0>(arg2), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::lending_factory_liquidity_not_configured());
    }

    public(friend) fun assert_ready<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry) {
        assert_active<T0>(arg0, arg1, arg2);
        assert!(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::accounting::has_liquidity_binding<T0>(arg1, arg2, arg3), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::vault_not_live());
    }

    // decompiled from Move bytecode v7
}

