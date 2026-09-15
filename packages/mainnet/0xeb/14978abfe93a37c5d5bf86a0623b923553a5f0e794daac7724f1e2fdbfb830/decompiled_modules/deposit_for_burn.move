module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn {
    struct DepositForBurn has copy, drop {
        burn_token: address,
        amount: u256,
        depositor: address,
        mint_recipient: address,
        destination_domain: u32,
        destination_token_messenger: address,
        destination_caller: address,
        max_fee: u256,
        min_finality_threshold: u32,
        hook_data: vector<u8>,
    }

    struct BurnReceipt<phantom T0> {
        caller: address,
        burn_token: address,
        amount: u64,
        destination_domain: u32,
        mint_recipient: address,
        destination_caller: address,
        destination_token_messenger: address,
        max_fee: u256,
        min_finality_threshold: u32,
        hook_data: vector<u8>,
        current_version: u64,
    }

    struct DepositForBurnWithPackageAuthTicket<phantom T0: drop, T1: drop> {
        coin: 0x2::coin::Coin<T0>,
        destination_domain: u32,
        mint_recipient: address,
        destination_caller: address,
        max_fee: u256,
        min_finality_threshold: u32,
        hook_data: vector<u8>,
        witness: T1,
    }

    struct CompleteBurnTicket<phantom T0: drop, T1: drop> {
        burn_receipt: BurnReceipt<T0>,
        witness: T1,
    }

    public fun deposit_for_burn<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: address, arg4: u256, arg5: u32, arg6: vector<u8>, arg7: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg8: &mut 0x2::tx_context::TxContext) : (BurnReceipt<T0>, 0x2::coin::Coin<T0>) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::denylistable::assert_sponsor_not_denylisted(arg7, arg8);
        create_burn_receipt<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::tx_context::sender(arg8), arg7)
    }

    public fun complete_burn<T0: drop, T1: drop>(arg0: CompleteBurnTicket<T0, T1>, arg1: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg2: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg1));
        let CompleteBurnTicket {
            burn_receipt : v0,
            witness      : v1,
        } = arg0;
        let BurnReceipt {
            caller                      : v2,
            burn_token                  : v3,
            amount                      : v4,
            destination_domain          : v5,
            mint_recipient              : v6,
            destination_caller          : v7,
            destination_token_messenger : v8,
            max_fee                     : v9,
            min_finality_threshold      : v10,
            hook_data                   : v11,
            current_version             : v12,
        } = v0;
        assert!(v12 == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::current_version(), 11);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handler_registry::assert_is_registered_handler<T1>(arg1, v3, v1);
        let v13 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::new(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::message_body_version(arg1), v3, v6, (v4 as u256), v2, v9, v11);
        send_burn_message(v5, v8, v7, v10, &v13, arg2);
        let v14 = DepositForBurn{
            burn_token                  : v3,
            amount                      : (v4 as u256),
            depositor                   : v2,
            mint_recipient              : v6,
            destination_domain          : v5,
            destination_token_messenger : v8,
            destination_caller          : v7,
            max_fee                     : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::max_fee(&v13),
            min_finality_threshold      : v10,
            hook_data                   : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::hook_data(&v13),
        };
        0x2::event::emit<DepositForBurn>(v14);
    }

    fun create_burn_receipt<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: address, arg4: u256, arg5: u32, arg6: vector<u8>, arg7: address, arg8: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State) : (BurnReceipt<T0>, 0x2::coin::Coin<T0>) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg8));
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>();
        assert!(!0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::paused(arg8), 3);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::denylistable::assert_not_denylisted(arg8, arg7);
        assert!(v0 > 0, 0);
        assert!(arg2 != @0x0, 1);
        assert!(arg4 < (v0 as u256), 7);
        assert!(arg4 >= 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::fee_controller::calculate_min_fee_amount(arg8, v1, (v0 as u256)), 8);
        assert!(safe_get_burn_limit(v1, arg8) >= v0, 6);
        let v2 = BurnReceipt<T0>{
            caller                      : arg7,
            burn_token                  : v1,
            amount                      : v0,
            destination_domain          : arg1,
            mint_recipient              : arg2,
            destination_caller          : arg3,
            destination_token_messenger : safe_get_remote_token_messenger(arg1, arg8),
            max_fee                     : arg4,
            min_finality_threshold      : arg5,
            hook_data                   : arg6,
            current_version             : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::current_version(),
        };
        (v2, arg0)
    }

    public fun create_complete_burn_ticket<T0: drop, T1: drop>(arg0: BurnReceipt<T0>, arg1: T1) : CompleteBurnTicket<T0, T1> {
        CompleteBurnTicket<T0, T1>{
            burn_receipt : arg0,
            witness      : arg1,
        }
    }

    public fun create_deposit_for_burn_with_package_auth_ticket<T0: drop, T1: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: address, arg4: u256, arg5: u32, arg6: vector<u8>, arg7: T1) : DepositForBurnWithPackageAuthTicket<T0, T1> {
        DepositForBurnWithPackageAuthTicket<T0, T1>{
            coin                   : arg0,
            destination_domain     : arg1,
            mint_recipient         : arg2,
            destination_caller     : arg3,
            max_fee                : arg4,
            min_finality_threshold : arg5,
            hook_data              : arg6,
            witness                : arg7,
        }
    }

    public fun deposit_for_burn_with_package_auth<T0: drop, T1: drop>(arg0: DepositForBurnWithPackageAuthTicket<T0, T1>, arg1: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg2: &mut 0x2::tx_context::TxContext) : (BurnReceipt<T0>, 0x2::coin::Coin<T0>) {
        let DepositForBurnWithPackageAuthTicket {
            coin                   : v0,
            destination_domain     : v1,
            mint_recipient         : v2,
            destination_caller     : v3,
            max_fee                : v4,
            min_finality_threshold : v5,
            hook_data              : v6,
            witness                : _,
        } = arg0;
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::denylistable::assert_not_denylisted(arg1, 0x2::tx_context::sender(arg2));
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::denylistable::assert_sponsor_not_denylisted(arg1, arg2);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::denylistable::assert_not_denylisted(arg1, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_package_address<T1>());
        create_burn_receipt<T0>(v0, v1, v2, v3, v4, v5, v6, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<T1>(), arg1)
    }

    public fun get_burn_details<T0>(arg0: &BurnReceipt<T0>) : (address, u64, address) {
        (arg0.burn_token, arg0.amount, arg0.mint_recipient)
    }

    fun safe_get_burn_limit(arg0: address, arg1: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State) : u64 {
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::burn_limit_for_token_id_exists(arg1, arg0), 5);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::burn_limit_from_token_id(arg1, arg0)
    }

    fun safe_get_remote_token_messenger(arg0: u32, arg1: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State) : address {
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_for_remote_domain_exists(arg1, arg0), 2);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_from_remote_domain(arg1, arg0)
    }

    fun send_burn_message(arg0: u32, arg1: address, arg2: address, arg3: u32, arg4: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::BurnMessage, arg5: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State) : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message::Message {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::send_message::send_message<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::send_message::create_send_message_ticket<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::new(), arg0, arg1, arg2, arg3, 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message::serialize(arg4)), arg5)
    }

    // decompiled from Move bytecode v7
}

