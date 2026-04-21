module 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::operator {
    public(friend) fun authorize(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::OperatorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::assert_version(arg0);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::assert_not_paused(arg0);
        assert!(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::operator_cap_vault_id(arg1) == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::vault_id(arg0), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::not_operator());
        assert!(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::is_operator(arg0, 0x2::tx_context::sender(arg5)), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::not_operator());
        assert!(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::is_allowed_target(arg0, arg2), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::target_not_allowed());
        check_rate_limit(arg0, arg3, arg4);
    }

    public(friend) fun authorize_no_value(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::OperatorCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        authorize(arg0, arg1, arg2, 0, arg3, arg4);
    }

    fun check_rate_limit(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_rate_limits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0));
        if (v0 >= 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::rate_window_start(arg0) + 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::rl_window_duration_secs(v1)) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::reset_rate_window(arg0, v0);
        };
        assert!(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::rate_ops_in_window(arg0) + 1 <= 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::rl_max_ops_per_window(v1), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::rate_limit_exceeded());
        assert!(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::rate_value_in_window(arg0) + arg1 <= 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::rl_max_value_per_window(v1), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::rate_limit_exceeded());
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::increment_rate(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

