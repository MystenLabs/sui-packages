module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message {
    struct MintAndWithdraw has copy, drop {
        mint_recipient: address,
        amount: u64,
        mint_token: address,
        fee_collected: u64,
    }

    struct MintReceipt<phantom T0> {
        stamp_receipt_ticket: 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::StampReceiptTicket<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::MessageTransmitterAuthenticator>,
        local_token: address,
        mint_recipient: address,
        amount: u64,
        fee: u64,
        current_version: u64,
    }

    struct CompleteMintTicket<phantom T0: drop, T1: drop> {
        mint_receipt: MintReceipt<T0>,
        witness: T1,
    }

    public fun complete_mint<T0: drop, T1: drop>(arg0: CompleteMintTicket<T0, T1>, arg1: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg2: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg1));
        let CompleteMintTicket {
            mint_receipt : v0,
            witness      : v1,
        } = arg0;
        let MintReceipt {
            stamp_receipt_ticket : v2,
            local_token          : v3,
            mint_recipient       : v4,
            amount               : v5,
            fee                  : v6,
            current_version      : v7,
        } = v0;
        assert!(v7 == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::current_version(), 13);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handler_registry::assert_is_registered_handler<T1>(arg1, v3, v1);
        let v8 = MintAndWithdraw{
            mint_recipient : v4,
            amount         : v5,
            mint_token     : v3,
            fee_collected  : v6,
        };
        0x2::event::emit<MintAndWithdraw>(v8);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::complete_receive_message(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::stamp_receipt<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::MessageTransmitterAuthenticator>(v2, arg2), arg2);
    }

    public fun create_complete_mint_ticket<T0: drop, T1: drop>(arg0: MintReceipt<T0>, arg1: T1) : CompleteMintTicket<T0, T1> {
        CompleteMintTicket<T0, T1>{
            mint_receipt : arg0,
            witness      : arg1,
        }
    }

    public fun get_mint_details<T0>(arg0: &MintReceipt<T0>) : (address, address, u64, u64) {
        (arg0.local_token, arg0.mint_recipient, arg0.amount, arg0.fee)
    }

    public fun prepare_mint<T0: drop>(arg0: 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::Receipt, arg1: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg2: &0x2::clock::Clock) : MintReceipt<T0> {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg1));
        assert!(!0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::paused(arg1), 6);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::finality_threshold_executed(&arg0) >= 500, 11);
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::source_domain(&arg0);
        let v1 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::from_bytes(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::message_body(&arg0));
        validate_remote_token_messenger(v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::sender(&arg0), arg1);
        validate_burn_message_version(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::version(&v1), arg1);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::amount(&v1) <= 18446744073709551615, 7);
        let v2 = (0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::amount(&v1) as u64);
        let v3 = validate_fee_and_return_amount(v2, 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::max_fee(&v1), 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::fee_executed(&v1));
        let v4 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::expiration_block(&v1);
        if (v4 != 0) {
            assert!((0x2::clock::timestamp_ms(arg2) as u256) < v4, 8);
        };
        MintReceipt<T0>{
            stamp_receipt_ticket : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::create_stamp_receipt_ticket<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::new(), arg0),
            local_token          : validate_and_return_local_token<T0>(v0, 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::burn_token(&v1), arg1),
            mint_recipient       : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::mint_recipient(&v1),
            amount               : v2 - v3,
            fee                  : v3,
            current_version      : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::current_version(),
        }
    }

    fun validate_and_return_local_token<T0: drop>(arg0: u32, arg1: address, arg2: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State) : address {
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token_exists(arg2, arg0, arg1), 3);
        let v0 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token(arg2, arg0, arg1);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>() == v0, 4);
        v0
    }

    fun validate_burn_message_version(arg0: u32, arg1: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State) {
        assert!(arg0 == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::message_body_version(arg1), 2);
    }

    fun validate_fee_and_return_amount(arg0: u64, arg1: u256, arg2: u256) : u64 {
        assert!(arg2 <= arg1, 9);
        assert!(arg2 < (arg0 as u256), 10);
        (arg2 as u64)
    }

    fun validate_remote_token_messenger(arg0: u32, arg1: address, arg2: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State) {
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_for_remote_domain_exists(arg2, arg0), 0);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_from_remote_domain(arg2, arg0) == arg1 && arg1 != @0x0, 1);
    }

    // decompiled from Move bytecode v7
}

