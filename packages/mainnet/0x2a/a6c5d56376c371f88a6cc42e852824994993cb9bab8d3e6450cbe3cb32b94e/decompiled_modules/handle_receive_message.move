module 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::handle_receive_message {
    struct MintAndWithdraw has copy, drop {
        mint_recipient: address,
        amount: u64,
        mint_token: address,
    }

    struct StampReceiptTicketWithBurnMessage {
        stamp_receipt_ticket: 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::StampReceiptTicket<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>,
        burn_message: 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage,
    }

    public fun handle_receive_message<T0: drop>(arg0: 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::Receipt, arg1: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg2: &0x2::deny_list::DenyList, arg3: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg4: &mut 0x2::tx_context::TxContext) : StampReceiptTicketWithBurnMessage {
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::version_control::assert_object_version_is_compatible_with_package(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::compatible_versions(arg1));
        assert!(!0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::paused(arg1), 6);
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::source_domain(&arg0);
        let v1 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::from_bytes(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::message_body(&arg0));
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::amount(&v1) <= 18446744073709551615, 7);
        let v2 = (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::amount(&v1) as u64);
        validate_remote_token_messenger(v0, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::sender(&arg0), arg1);
        validate_burn_message_version(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::version(&v1), arg1);
        let v3 = validate_and_return_local_token<T0>(v0, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::burn_token(&v1), arg1);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::mint<T0>(arg3, validate_and_return_mint_cap<T0>(v3, arg1), arg2, v2, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::mint_recipient(&v1), arg4);
        let v4 = MintAndWithdraw{
            mint_recipient : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::mint_recipient(&v1),
            amount         : v2,
            mint_token     : v3,
        };
        0x2::event::emit<MintAndWithdraw>(v4);
        StampReceiptTicketWithBurnMessage{
            stamp_receipt_ticket : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::create_stamp_receipt_ticket<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::new(), arg0),
            burn_message         : v1,
        }
    }

    public fun deconstruct_stamp_receipt_ticket_with_burn_message(arg0: StampReceiptTicketWithBurnMessage) : (0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::StampReceiptTicket<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage) {
        let StampReceiptTicketWithBurnMessage {
            stamp_receipt_ticket : v0,
            burn_message         : v1,
        } = arg0;
        (v0, v1)
    }

    fun validate_and_return_local_token<T0: drop>(arg0: u32, arg1: address, arg2: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State) : address {
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::local_token_from_remote_token_exists(arg2, arg0, arg1), 3);
        let v0 = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::local_token_from_remote_token(arg2, arg0, arg1);
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>() == v0, 4);
        v0
    }

    fun validate_and_return_mint_cap<T0: drop>(arg0: address, arg1: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State) : &0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0> {
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::mint_cap_for_local_token_exists(arg1, arg0), 5);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::mint_cap_from_token_id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(arg1, arg0)
    }

    fun validate_burn_message_version(arg0: u32, arg1: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State) {
        assert!(arg0 == 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::message_body_version(arg1), 2);
    }

    fun validate_remote_token_messenger(arg0: u32, arg1: address, arg2: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State) {
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remote_token_messenger_for_remote_domain_exists(arg2, arg0), 0);
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::remote_token_messenger_from_remote_domain(arg2, arg0) == arg1 && arg1 != @0x0, 1);
    }

    // decompiled from Move bytecode v6
}

