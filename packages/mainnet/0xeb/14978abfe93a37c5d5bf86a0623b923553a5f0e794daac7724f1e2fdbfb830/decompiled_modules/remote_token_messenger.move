module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::remote_token_messenger {
    struct RemoteTokenMessengerAdded has copy, drop {
        domain: u32,
        token_messenger: address,
    }

    struct RemoteTokenMessengerRemoved has copy, drop {
        domain: u32,
        token_messenger: address,
    }

    entry fun add_remote_token_messenger(arg0: u32, arg1: address, arg2: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg3: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg2));
        verify_owner(arg2, arg3);
        assert!(arg1 != @0x0, 1);
        assert!(!0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_for_remote_domain_exists(arg2, arg0), 2);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::add_remote_token_messenger(arg2, arg0, arg1);
        let v0 = RemoteTokenMessengerAdded{
            domain          : arg0,
            token_messenger : arg1,
        };
        0x2::event::emit<RemoteTokenMessengerAdded>(v0);
    }

    entry fun remove_remote_token_messenger(arg0: u32, arg1: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg2: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg1));
        verify_owner(arg1, arg2);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_for_remote_domain_exists(arg1, arg0), 3);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remove_remote_token_messenger(arg1, arg0);
        let v0 = RemoteTokenMessengerRemoved{
            domain          : arg0,
            token_messenger : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_from_remote_domain(arg1, arg0),
        };
        0x2::event::emit<RemoteTokenMessengerRemoved>(v0);
    }

    fun verify_owner(arg0: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::owner(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v7
}

