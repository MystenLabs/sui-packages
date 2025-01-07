module 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn {
    struct DepositForBurn has copy, drop {
        nonce: u64,
        burn_token: address,
        amount: u64,
        depositor: address,
        mint_recipient: address,
        destination_domain: u32,
        destination_token_messenger: address,
        destination_caller: address,
    }

    struct DepositForBurnTicket<phantom T0: drop, T1: drop> {
        auth: T1,
        coins: 0x2::coin::Coin<T0>,
        destination_domain: u32,
        mint_recipient: address,
    }

    struct DepositForBurnWithCallerTicket<phantom T0: drop, T1: drop> {
        auth: T1,
        coins: 0x2::coin::Coin<T0>,
        destination_domain: u32,
        mint_recipient: address,
        destination_caller: address,
    }

    struct ReplaceDepositForBurnTicket<T0: drop> {
        auth: T0,
        original_raw_message: vector<u8>,
        original_attestation: vector<u8>,
        new_destination_caller: 0x1::option::Option<address>,
        new_mint_recipient: 0x1::option::Option<address>,
    }

    entry fun deposit_for_burn<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg4: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg5: &0x2::deny_list::DenyList, arg6: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg7: &0x2::tx_context::TxContext) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) {
        deposit_for_burn_shared<T0>(arg0, arg1, arg2, @0x0, 0x2::tx_context::sender(arg7), arg3, arg4, arg5, arg6, arg7)
    }

    public fun create_deposit_for_burn_ticket<T0: drop, T1: drop>(arg0: T1, arg1: 0x2::coin::Coin<T0>, arg2: u32, arg3: address) : DepositForBurnTicket<T0, T1> {
        DepositForBurnTicket<T0, T1>{
            auth               : arg0,
            coins              : arg1,
            destination_domain : arg2,
            mint_recipient     : arg3,
        }
    }

    public fun create_deposit_for_burn_with_caller_ticket<T0: drop, T1: drop>(arg0: T1, arg1: 0x2::coin::Coin<T0>, arg2: u32, arg3: address, arg4: address) : DepositForBurnWithCallerTicket<T0, T1> {
        DepositForBurnWithCallerTicket<T0, T1>{
            auth               : arg0,
            coins              : arg1,
            destination_domain : arg2,
            mint_recipient     : arg3,
            destination_caller : arg4,
        }
    }

    public fun create_replace_deposit_for_burn_ticket<T0: drop>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<address>) : ReplaceDepositForBurnTicket<T0> {
        ReplaceDepositForBurnTicket<T0>{
            auth                   : arg0,
            original_raw_message   : arg1,
            original_attestation   : arg2,
            new_destination_caller : arg3,
            new_mint_recipient     : arg4,
        }
    }

    fun deposit_for_burn_shared<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: address, arg4: address, arg5: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg6: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg7: &0x2::deny_list::DenyList, arg8: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg9: &0x2::tx_context::TxContext) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg5));
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>();
        assert!(!0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::paused(arg5), 3);
        assert!(v0 > 0, 0);
        assert!(arg2 != @0x0, 1);
        let v2 = safe_get_remote_token_messenger(arg1, arg5);
        let v3 = safe_get_mint_cap<T0>(v1, arg5);
        assert!(safe_get_burn_limit(v1, arg5) >= v0, 6);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::burn<T0>(arg8, v3, arg7, arg0, arg9);
        let v4 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::new(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::message_body_version(arg5), v1, arg2, (v0 as u256), arg4);
        let v5 = send_deposit_for_burn_message(arg1, v2, arg3, &v4, arg6);
        let v6 = DepositForBurn{
            nonce                       : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v5),
            burn_token                  : v1,
            amount                      : v0,
            depositor                   : arg4,
            mint_recipient              : arg2,
            destination_domain          : arg1,
            destination_token_messenger : v2,
            destination_caller          : arg3,
        };
        0x2::event::emit<DepositForBurn>(v6);
        (v4, v5)
    }

    entry fun deposit_for_burn_with_caller<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: address, arg4: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg5: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg6: &0x2::deny_list::DenyList, arg7: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg8: &0x2::tx_context::TxContext) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) {
        deposit_for_burn_shared<T0>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg8), arg4, arg5, arg6, arg7, arg8)
    }

    public fun deposit_for_burn_with_caller_with_package_auth<T0: drop, T1: drop>(arg0: DepositForBurnWithCallerTicket<T0, T1>, arg1: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg2: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: &0x2::tx_context::TxContext) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) {
        let DepositForBurnWithCallerTicket {
            auth               : _,
            coins              : v1,
            destination_domain : v2,
            mint_recipient     : v3,
            destination_caller : v4,
        } = arg0;
        deposit_for_burn_shared<T0>(v1, v2, v3, v4, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth::auth_caller_identifier<T1>(), arg1, arg2, arg3, arg4, arg5)
    }

    public fun deposit_for_burn_with_package_auth<T0: drop, T1: drop>(arg0: DepositForBurnTicket<T0, T1>, arg1: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg2: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: &0x2::tx_context::TxContext) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) {
        let DepositForBurnTicket {
            auth               : _,
            coins              : v1,
            destination_domain : v2,
            mint_recipient     : v3,
        } = arg0;
        deposit_for_burn_shared<T0>(v1, v2, v3, @0x0, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth::auth_caller_identifier<T1>(), arg1, arg2, arg3, arg4, arg5)
    }

    entry fun replace_deposit_for_burn(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg5: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg6: &0x2::tx_context::TxContext) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) {
        replace_deposit_for_burn_shared(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg6), arg4, arg5)
    }

    fun replace_deposit_for_burn_shared(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: address, arg5: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg6: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg5));
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::message_body_from_bytes(&arg0);
        let v1 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::from_bytes(&v0);
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::message_sender(&v1) == arg4, 7);
        let v2 = 0x1::option::get_with_default<address>(&arg3, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::mint_recipient(&v1));
        assert!(v2 != @0x0, 1);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::update_mint_recipient(&mut v1, v2);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::update_version(&mut v1, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::message_body_version(arg5));
        let v3 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::replace_message<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::create_replace_message_ticket<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::new(), arg0, arg1, 0x1::option::some<vector<u8>>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::serialize(&v1)), arg2), arg6);
        let v4 = DepositForBurn{
            nonce                       : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v3),
            burn_token                  : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::burn_token(&v1),
            amount                      : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::amount(&v1) as u64),
            depositor                   : arg4,
            mint_recipient              : v2,
            destination_domain          : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_domain(&v3),
            destination_token_messenger : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::recipient(&v3),
            destination_caller          : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_caller(&v3),
        };
        0x2::event::emit<DepositForBurn>(v4);
        (v1, v3)
    }

    public fun replace_deposit_for_burn_with_package_auth<T0: drop>(arg0: ReplaceDepositForBurnTicket<T0>, arg1: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) {
        let ReplaceDepositForBurnTicket {
            auth                   : _,
            original_raw_message   : v1,
            original_attestation   : v2,
            new_destination_caller : v3,
            new_mint_recipient     : v4,
        } = arg0;
        replace_deposit_for_burn_shared(v1, v2, v3, v4, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth::auth_caller_identifier<T0>(), arg1, arg2)
    }

    fun safe_get_burn_limit(arg0: address, arg1: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State) : u64 {
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::burn_limit_for_token_id_exists(arg1, arg0), 5);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::burn_limit_from_token_id(arg1, arg0)
    }

    fun safe_get_mint_cap<T0>(arg0: address, arg1: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State) : &0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0> {
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::mint_cap_for_local_token_exists(arg1, arg0), 4);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::mint_cap_from_token_id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(arg1, arg0)
    }

    fun safe_get_remote_token_messenger(arg0: u32, arg1: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State) : address {
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remote_token_messenger_for_remote_domain_exists(arg1, arg0), 2);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remote_token_messenger_from_remote_domain(arg1, arg0)
    }

    fun send_deposit_for_burn_message(arg0: u32, arg1: address, arg2: address, arg3: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, arg4: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message {
        if (arg2 == @0x0) {
            0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::send_message<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::create_send_message_ticket<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::new(), arg0, arg1, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::serialize(arg3)), arg4)
        } else {
            0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::send_message_with_caller<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::create_send_message_with_caller_ticket<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::new(), arg0, arg1, arg2, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::serialize(arg3)), arg4)
        }
    }

    // decompiled from Move bytecode v6
}

