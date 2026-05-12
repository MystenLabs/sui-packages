module 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::operator {
    public(friend) fun authorize(arg0: &mut 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::Vault, arg1: &0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::OperatorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        abort 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::deprecated_use_v9()
    }

    public(friend) fun authorize_no_value(arg0: &mut 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::Vault, arg1: &0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::OperatorCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        abort 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::deprecated_use_v9()
    }

    public(friend) fun authorize_no_value_v9(arg0: &mut 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::Vault, arg1: &0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::OperatorCap, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        authorize_v9(arg0, arg1, arg2, arg3, 0, arg4, arg5);
    }

    public(friend) fun authorize_substep(arg0: &0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::Vault, arg1: &0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::OperatorCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::assert_version(arg0);
        0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::assert_not_paused(arg0);
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::operator_cap_vault_id(arg1) == 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::vault_id(arg0), 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::not_operator());
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::is_operator(arg0, 0x2::tx_context::sender(arg3)), 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::not_operator());
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::is_allowed_target(arg0, arg2), 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::target_not_allowed());
    }

    public(friend) fun authorize_v9(arg0: &mut 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::Vault, arg1: &0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::OperatorCap, arg2: address, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::assert_version(arg0);
        0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::assert_not_paused(arg0);
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::operator_cap_vault_id(arg1) == 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::vault_id(arg0), 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::not_operator());
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::is_operator(arg0, 0x2::tx_context::sender(arg6)), 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::not_operator());
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::is_allowed_target(arg0, arg2), 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::target_not_allowed());
        check_rate_limit_global(arg0, arg4, arg5);
        check_rate_limit_per_user(arg0, arg3, arg4, arg5, arg6);
    }

    fun check_rate_limit_global(arg0: &mut 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::Vault, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::cfg_rate_limits(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::config(arg0));
        if (v0 >= 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::rate_window_start(arg0) + 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::rl_window_duration_secs(v1)) {
            0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::reset_rate_window(arg0, v0);
        };
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::rate_ops_in_window(arg0) + 1 <= 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::rl_max_ops_per_window(v1), 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::rate_limit_exceeded());
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::rate_value_in_window(arg0) + arg1 <= 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::rl_max_value_per_window(v1), 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::rate_limit_exceeded());
        0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::increment_rate(arg0, arg1);
    }

    fun check_rate_limit_per_user(arg0: &mut 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::Vault, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::get_or_init_user_rate_state(arg0, arg1, arg4);
        if (v0 >= 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::user_rate_window_start(v1) + 3600) {
            0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::reset_user_rate_window(v1, v0);
        };
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::user_rate_ops(v1) + 1 <= 200, 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::rate_limit_exceeded());
        assert!(0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::user_rate_value(v1) + arg2 <= 50000000000000, 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors::rate_limit_exceeded());
        0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::vault_core::increment_user_rate(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

