module 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator {
    public(friend) fun authorize(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::assert_version(arg0);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::assert_not_paused(arg0);
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::operator_cap_vault_id(arg1) == 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::vault_id(arg0), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::not_operator());
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::is_operator(arg0, 0x2::tx_context::sender(arg5)), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::not_operator());
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::is_allowed_target(arg0, arg2), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::target_not_allowed());
        check_rate_limit(arg0, arg3, arg4);
    }

    public(friend) fun authorize_no_value(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        authorize(arg0, arg1, arg2, 0, arg3, arg4);
    }

    fun check_rate_limit(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_rate_limits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0));
        if (v0 >= 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::rate_window_start(arg0) + 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::rl_window_duration_secs(v1)) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::reset_rate_window(arg0, v0);
        };
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::rate_ops_in_window(arg0) + 1 <= 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::rl_max_ops_per_window(v1), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::rate_limit_exceeded());
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::rate_value_in_window(arg0) + arg1 <= 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::rl_max_value_per_window(v1), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::rate_limit_exceeded());
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::increment_rate(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

