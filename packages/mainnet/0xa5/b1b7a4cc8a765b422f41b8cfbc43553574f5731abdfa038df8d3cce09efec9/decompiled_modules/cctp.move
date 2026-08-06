module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::cctp {
    struct CctpDepositBox has store, key {
        id: 0x2::object::UID,
        next_deposit_id: u64,
        deposits: 0x2::table::Table<u64, CctpDeposit>,
    }

    struct CctpDeposit has store {
        amount: u64,
        message_sender: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
    }

    struct CctpReceiveAuth has drop {
        dummy_field: bool,
    }

    struct CctpBurnAuth has drop {
        dummy_field: bool,
    }

    struct CctpDepositBoxCreatedEvent has copy, drop {
        box_id: 0x2::object::ID,
    }

    struct CctpDepositQueuedEvent has copy, drop {
        box_id: 0x2::object::ID,
        deposit_id: u64,
        amount: u64,
        message_sender: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
    }

    struct CctpDepositSweptEvent has copy, drop {
        box_id: 0x2::object::ID,
        deposit_id: u64,
        beneficiary: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
        amount: u64,
    }

    public fun create_receive_message_ticket(arg0: vector<u8>, arg1: vector<u8>) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::ReceiveMessageTicket<CctpReceiveAuth> {
        let v0 = CctpReceiveAuth{dummy_field: false};
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::create_receive_message_ticket<CctpReceiveAuth>(v0, arg0, arg1)
    }

    fun cctp_domain_from_chain_id(arg0: u8) : u32 {
        if (arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()) {
            0
        } else if (arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana()) {
            5
        } else {
            assert!(arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_sui(), 2100);
            8
        }
    }

    fun cctp_message_sender_raw_bytes(arg0: u8, arg1: address) : vector<u8> {
        if (arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()) {
            trailing_bytes(0x2::address::to_bytes(arg1), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::evm_address_length())
        } else {
            0x2::address::to_bytes(arg1)
        }
    }

    fun cctp_mint_recipient(arg0: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress) : address {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(arg0);
        if (v0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()) {
            0x2::address::from_bytes(left_pad_to_32(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::bytes(arg0)))
        } else {
            assert!(v0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana(), 2100);
            0x2::address::from_bytes(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::bytes(arg0))
        }
    }

    fun chain_id_from_cctp_domain(arg0: u32) : u8 {
        if (arg0 == 8) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_sui()
        } else if (arg0 == 0) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()
        } else if (arg0 == 5) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana()
        } else {
            255
        }
    }

    public(friend) fun create_cctp_deposit_box(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CctpDepositBox{
            id              : 0x2::object::new(arg0),
            next_deposit_id : 0,
            deposits        : 0x2::table::new<u64, CctpDeposit>(arg0),
        };
        let v1 = CctpDepositBoxCreatedEvent{box_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CctpDepositBoxCreatedEvent>(v1);
        0x2::transfer::share_object<CctpDepositBox>(v0);
    }

    public fun deposit_box_address(arg0: &CctpDepositBox) : address {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x2::object::id_to_address(&v0)
    }

    public fun destination_caller() : address {
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth::auth_caller_identifier<CctpReceiveAuth>()
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        create_cctp_deposit_box(arg0);
    }

    fun left_pad_to_32(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 <= 32, 2100);
        let v1 = 0x1::vector::empty<u8>();
        while (v0 < 32) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(&mut v1, arg0);
        v1
    }

    public fun pending_deposit_amount(arg0: &CctpDepositBox, arg1: u64) : u64 {
        0x2::table::borrow<u64, CctpDeposit>(&arg0.deposits, arg1).amount
    }

    public fun pending_deposit_message_sender(arg0: &CctpDepositBox, arg1: u64) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        0x2::table::borrow<u64, CctpDeposit>(&arg0.deposits, arg1).message_sender
    }

    fun queue_deposit(arg0: &mut CctpDepositBox, arg1: u64, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress) : u64 {
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&arg2) != @0x0, 105);
        let v0 = arg0.next_deposit_id;
        let v1 = CctpDeposit{
            amount         : arg1,
            message_sender : arg2,
        };
        0x2::table::add<u64, CctpDeposit>(&mut arg0.deposits, v0, v1);
        arg0.next_deposit_id = v0 + 1;
        let v2 = CctpDepositQueuedEvent{
            box_id         : 0x2::object::uid_to_inner(&arg0.id),
            deposit_id     : v0,
            amount         : arg1,
            message_sender : arg2,
        };
        0x2::event::emit<CctpDepositQueuedEvent>(v2);
        v0
    }

    public fun receive_into_deposit_box<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::Receipt, arg2: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: &mut CctpDepositBox, arg6: &mut 0x2::tx_context::TxContext) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::StampReceiptTicket<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator> {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let (v0, v1) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::handle_receive_message::deconstruct_stamp_receipt_ticket_with_burn_message(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::handle_receive_message::handle_receive_message<T0>(arg1, arg2, arg3, arg4, arg6));
        let v2 = v1;
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::mint_recipient(&v2) == deposit_box_address(arg5), 2102);
        queue_deposit(arg5, (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::amount(&v2) as u64), unified_message_sender_from_cctp(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::source_domain(&arg1), 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::message_sender(&v2)));
        v0
    }

    entry fun sweep_deposit_box<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut CctpDepositBox, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: u64, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let CctpDeposit {
            amount         : v0,
            message_sender : v1,
        } = 0x2::table::remove<u64, CctpDeposit>(&mut arg1.deposits, arg4);
        let v2 = v1;
        let v3 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg1.id, arg5);
        let v4 = 0x2::coin::value<T0>(&v3);
        assert!(v4 == v0, 2103);
        let v5 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::deposit_with_source<T0>(arg2, v5, v5, v3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg3));
        let v6 = CctpDepositSweptEvent{
            box_id      : 0x2::object::uid_to_inner(&arg1.id),
            deposit_id  : arg4,
            beneficiary : v2,
            amount      : v4,
        };
        0x2::event::emit<CctpDepositSweptEvent>(v6);
    }

    fun trailing_bytes(arg0: vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = v0 - arg1;
        while (v2 < v0) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    fun unified_message_sender_from_cctp(arg0: u32, arg1: address) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        let v0 = chain_id_from_cctp_domain(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_chain_id_and_bytes(v0, cctp_message_sender_raw_bytes(v0, arg1))
    }

    fun verify_cctp_withdraw_signature<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u128, arg5: u128, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock) : (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, address, vector<u8>) {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg9, arg6, 34);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg1);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg2);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::assert_same_chain(&v0, &v1);
        assert!(!0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::is_sui(&v1), 2100);
        let (v2, v3) = if (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(&v1) == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana()) {
            let v4 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg3);
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::assert_same_chain(&v0, &v4);
            (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::withdraw_solana(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::bank_address<T0>(arg0), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::type_string<T0>(), v0, v1, v4, arg4, arg5, arg6), cctp_mint_recipient(&v4))
        } else {
            assert!(0x1::vector::length<u8>(&arg3) == 0, 2100);
            (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::withdraw(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::bank_address<T0>(arg0), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::type_string<T0>(), v0, v1, arg4, arg5, arg6), cctp_mint_recipient(&v1))
        };
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::verify_user_signature(&v0, 0x1::vector::empty<address>(), v2, arg7, arg8, 52);
        (v0, v1, v3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v2))
    }

    public fun withdraw_and_create_burn_ticket<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u128, arg8: u128, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnTicket<T0, CctpBurnAuth> {
        let (v0, v1, v2) = withdraw_for_cctp_burn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v3 = CctpBurnAuth{dummy_field: false};
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, CctpBurnAuth>(v3, v0, v1, v2)
    }

    fun withdraw_for_cctp_burn<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u128, arg8: u128, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u32, address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let (v0, v1, v2, v3) = verify_cctp_withdraw_signature<T0>(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v4 = v0;
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg2, &v4, arg13);
        withdraw_verified_for_cctp_burn<T0>(arg0, arg1, arg3, v4, v1, v2, v3, arg7, arg13)
    }

    fun withdraw_verified_for_cctp_burn<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg4: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg5: address, arg6: vector<u8>, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u32, address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg2, arg6);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&arg3);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::convert_usdc_to_base_decimals(arg7);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::configured_action_gas_fee(arg0, 0x1::string::utf8(b"Withdraw"));
        let (v4, v5) = if (v3 > 0) {
            if (v2 <= v3) {
                (0, v2)
            } else {
                (v2 - v3, v3)
            }
        } else {
            (v2, 0)
        };
        if (v5 > 0) {
            let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::gas_relayer(arg0);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg1, v6);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer_gas_fee<T0>(arg1, v1, v6, v5, 3, v0);
        };
        assert!(v4 > 0, 1001);
        assert!(v4 % 1000 == 0, 2026);
        (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::withdraw_internal_with_tx_index<T0>(arg1, v1, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&arg4), v4 / 1000, v0, arg8), cctp_domain_from_chain_id(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(&arg4)), arg5)
    }

    // decompiled from Move bytecode v7
}

