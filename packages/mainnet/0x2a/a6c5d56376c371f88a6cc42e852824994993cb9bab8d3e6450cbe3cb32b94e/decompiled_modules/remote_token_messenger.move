module 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::remote_token_messenger {
    struct RemoteTokenMessengerAdded has copy, drop {
        domain: u32,
        token_messenger: address,
    }

    struct RemoteTokenMessengerRemoved has copy, drop {
        domain: u32,
        token_messenger: address,
    }

    entry fun add_remote_token_messenger(arg0: u32, arg1: address, arg2: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &0x2::tx_context::TxContext) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg2));
        verify_owner(arg2, arg3);
        assert!(arg1 != @0x0, 1);
        assert!(!0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remote_token_messenger_for_remote_domain_exists(arg2, arg0), 2);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::add_remote_token_messenger(arg2, arg0, arg1);
        let v0 = RemoteTokenMessengerAdded{
            domain          : arg0,
            token_messenger : arg1,
        };
        0x2::event::emit<RemoteTokenMessengerAdded>(v0);
    }

    entry fun remove_remote_token_messenger(arg0: u32, arg1: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg2: &0x2::tx_context::TxContext) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg1));
        verify_owner(arg1, arg2);
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remote_token_messenger_for_remote_domain_exists(arg1, arg0), 3);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remove_remote_token_messenger(arg1, arg0);
        let v0 = RemoteTokenMessengerRemoved{
            domain          : arg0,
            token_messenger : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remote_token_messenger_from_remote_domain(arg1, arg0),
        };
        0x2::event::emit<RemoteTokenMessengerRemoved>(v0);
    }

    fun verify_owner(arg0: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::roles::owner(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v6
}

