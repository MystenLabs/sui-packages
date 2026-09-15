module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handler_registry {
    struct HandlerRegistered has copy, drop {
        token_address: address,
        handler_address: address,
    }

    struct HandlerDeregistered has copy, drop {
        token_address: address,
        handler_address: address,
    }

    public(friend) fun assert_is_registered_handler<T0: drop>(arg0: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: address, arg2: T0) {
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::handler_for_token_id_exists(arg0, arg1), 0);
        assert!(handler_identifier<T0>() == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::handler(arg0, arg1), 1);
    }

    entry fun deregister_handler(arg0: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg0));
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::OwnerRole>(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::owner_role(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), arg2);
        assert!(arg1 != @0x0, 2);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::handler_for_token_id_exists(arg0, arg1), 0);
        let v0 = HandlerDeregistered{
            token_address   : arg1,
            handler_address : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remove_handler(arg0, arg1),
        };
        0x2::event::emit<HandlerDeregistered>(v0);
    }

    fun handler_identifier<T0: drop>() : address {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 3);
        let v1 = 0x1::type_name::into_string(v0);
        0x2::address::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v1)))
    }

    entry fun register_handler<T0: drop>(arg0: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg0));
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::OwnerRole>(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::owner_role(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), arg2);
        assert!(arg1 != @0x0, 2);
        let v0 = handler_identifier<T0>();
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::set_handler(arg0, arg1, v0);
        let v1 = HandlerRegistered{
            token_address   : arg1,
            handler_address : v0,
        };
        0x2::event::emit<HandlerRegistered>(v1);
    }

    // decompiled from Move bytecode v7
}

