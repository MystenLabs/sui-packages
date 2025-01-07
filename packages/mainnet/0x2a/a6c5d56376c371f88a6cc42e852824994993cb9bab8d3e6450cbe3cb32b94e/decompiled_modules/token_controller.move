module 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_controller {
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

    struct MintCapAdded has copy, drop {
        local_token: address,
        mint_cap_id: 0x2::object::ID,
    }

    struct MintCapRemoved has copy, drop {
        local_token: address,
        mint_cap_id: 0x2::object::ID,
    }

    entry fun add_stablecoin_mint_cap<T0: drop>(arg0: 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>, arg1: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg2: &0x2::tx_context::TxContext) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg1));
        verify_token_controller(arg1, arg2);
        let v0 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>();
        assert!(!0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::mint_cap_for_local_token_exists(arg1, v0), 4);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::add_mint_cap<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(arg1, v0, arg0);
        let v1 = MintCapAdded{
            local_token : v0,
            mint_cap_id : 0x2::object::id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(&arg0),
        };
        0x2::event::emit<MintCapAdded>(v1);
    }

    entry fun link_token_pair<T0: drop>(arg0: u32, arg1: address, arg2: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &0x2::tx_context::TxContext) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg2));
        verify_token_controller(arg2, arg3);
        assert!(arg1 != @0x0, 1);
        assert!(!0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::local_token_from_remote_token_exists(arg2, arg0, arg1), 2);
        let v0 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>();
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::add_local_token_for_remote_token(arg2, arg0, arg1, v0);
        let v1 = TokenPairLinked{
            local_token   : v0,
            remote_domain : arg0,
            remote_token  : arg1,
        };
        0x2::event::emit<TokenPairLinked>(v1);
    }

    entry fun remove_stablecoin_mint_cap<T0: drop>(arg0: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg1: &0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg0));
        verify_token_controller(arg0, arg2);
        let v0 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>();
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::mint_cap_for_local_token_exists(arg0, v0), 5);
        assert!(!0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::is_authorized_mint_cap<T0>(arg1, 0x2::object::id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::mint_cap_from_token_id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(arg0, v0))), 6);
        let v1 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remove_mint_cap<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(arg0, v0);
        let v2 = MintCapRemoved{
            local_token : v0,
            mint_cap_id : 0x2::object::id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(&v1),
        };
        0x2::event::emit<MintCapRemoved>(v2);
        0x2::transfer::public_transfer<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    entry fun set_max_burn_amount_per_message<T0: drop>(arg0: u64, arg1: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg2: &0x2::tx_context::TxContext) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg1));
        verify_token_controller(arg1, arg2);
        let v0 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>();
        if (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::burn_limit_for_token_id_exists(arg1, v0)) {
            0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remove_burn_limit(arg1, v0);
        };
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::add_burn_limit(arg1, v0, arg0);
        let v1 = SetBurnLimitPerMessage{
            token                  : v0,
            burn_limit_per_message : arg0,
        };
        0x2::event::emit<SetBurnLimitPerMessage>(v1);
    }

    entry fun unlink_token_pair<T0: drop>(arg0: u32, arg1: address, arg2: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &0x2::tx_context::TxContext) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg2));
        verify_token_controller(arg2, arg3);
        assert!(arg1 != @0x0, 1);
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::local_token_from_remote_token_exists(arg2, arg0, arg1), 3);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remove_local_token_for_remote_token(arg2, arg0, arg1);
        let v0 = TokenPairUnlinked{
            local_token   : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>(),
            remote_domain : arg0,
            remote_token  : arg1,
        };
        0x2::event::emit<TokenPairUnlinked>(v0);
    }

    fun verify_token_controller(arg0: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::roles::token_controller(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v6
}

