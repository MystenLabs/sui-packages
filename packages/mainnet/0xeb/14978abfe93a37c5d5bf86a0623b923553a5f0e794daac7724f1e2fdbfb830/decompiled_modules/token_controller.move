module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_controller {
    struct SetBurnLimitPerMessage has copy, drop {
        token: address,
        burn_limit_per_message: u64,
    }

    struct TokenPairLinked has copy, drop {
        local_token: address,
        remote_domain: u32,
        remote_token: address,
    }

    struct TokenPairUnlinked has copy, drop {
        local_token: address,
        remote_domain: u32,
        remote_token: address,
    }

    entry fun link_token_pair<T0: drop>(arg0: u32, arg1: address, arg2: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg3: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg2));
        verify_token_controller(arg2, arg3);
        assert!(arg1 != @0x0, 1);
        assert!(!0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token_exists(arg2, arg0, arg1), 2);
        let v0 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>();
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::add_local_token_for_remote_token(arg2, arg0, arg1, v0);
        let v1 = TokenPairLinked{
            local_token   : v0,
            remote_domain : arg0,
            remote_token  : arg1,
        };
        0x2::event::emit<TokenPairLinked>(v1);
    }

    entry fun set_max_burn_amount_per_message<T0: drop>(arg0: u64, arg1: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg2: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg1));
        verify_token_controller(arg1, arg2);
        let v0 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>();
        if (0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::burn_limit_for_token_id_exists(arg1, v0)) {
            0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remove_burn_limit(arg1, v0);
        };
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::add_burn_limit(arg1, v0, arg0);
        let v1 = SetBurnLimitPerMessage{
            token                  : v0,
            burn_limit_per_message : arg0,
        };
        0x2::event::emit<SetBurnLimitPerMessage>(v1);
    }

    entry fun unlink_token_pair<T0: drop>(arg0: u32, arg1: address, arg2: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg3: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg2));
        verify_token_controller(arg2, arg3);
        assert!(arg1 != @0x0, 1);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token_exists(arg2, arg0, arg1), 3);
        let v0 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>();
        assert!(v0 == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token(arg2, arg0, arg1), 7);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remove_local_token_for_remote_token(arg2, arg0, arg1);
        let v1 = TokenPairUnlinked{
            local_token   : v0,
            remote_domain : arg0,
            remote_token  : arg1,
        };
        0x2::event::emit<TokenPairUnlinked>(v1);
    }

    fun verify_token_controller(arg0: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::token_controller(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v7
}

