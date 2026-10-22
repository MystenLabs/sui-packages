module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::asserts {
    public(friend) fun assert_active<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::assert_version(arg0);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::assert_bound<T0>(arg1, arg2);
    }

    public(friend) fun assert_listable<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::Auth, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>, arg4: &0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth::assert_admin(arg0, arg1, arg3, arg4);
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_rate_data_set<T0>(arg2) && 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_token_config_set<T0>(arg2), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::lending_factory_liquidity_not_configured());
    }

    public(friend) fun assert_ready<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry) {
        assert_active<T0>(arg0, arg1, arg2);
        assert!(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::accounting::has_liquidity_binding<T0>(arg1, arg2, arg3), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::vault_not_live());
    }

    // decompiled from Move bytecode v7
}

