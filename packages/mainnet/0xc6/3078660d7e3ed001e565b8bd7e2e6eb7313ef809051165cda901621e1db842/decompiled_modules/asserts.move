module 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::asserts {
    public(friend) fun assert_active<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg1: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>) {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::assert_version(arg0);
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::assert_bound<T0>(arg1, arg2);
    }

    public(friend) fun assert_listable<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg1: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg3: 0x1::option::Option<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::timelock_cap::TimelockTicket>, arg4: &0x2::tx_context::TxContext) {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::assert_admin(arg0, arg1, arg3, arg4);
        assert!(0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_rate_data_set<T0>(arg2) && 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_token_config_set<T0>(arg2), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::errors::lending_factory_liquidity_not_configured());
    }

    public(friend) fun assert_ready<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg1: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry) {
        assert_active<T0>(arg0, arg1, arg2);
        assert!(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::accounting::has_liquidity_binding<T0>(arg1, arg2, arg3), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::errors::vault_not_live());
    }

    // decompiled from Move bytecode v7
}

