module 0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::cctp_bridge {
    struct FeeCollectorCap has store {
        dummy_field: bool,
    }

    struct CctpBridge has key {
        id: 0x2::object::UID,
        chain_id_domain_map: 0x2::table::Table<u8, u32>,
        senders: 0x2::table::Table<u64, address>,
        fee_collector: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::FeeCollector<FeeCollectorCap>,
        fee_collector_cap: FeeCollectorCap,
        admin_fee_share_bp: u64,
        gas_usage: 0x2::table::Table<u8, u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun bridge<T0: drop>(arg0: &mut CctpBridge, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: &0x2::deny_list::DenyList, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<T0>, arg9: u8, arg10: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg11: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg8);
        assert!(0x2::coin::value<T0>(&arg6) > v0, 1);
        let v1 = get_transaction_cost(arg0, arg1, arg9);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg7) + 0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle_interface::stable_to_sui_amount(arg1, v0, 6);
        assert!(v2 >= v1, 0);
        let v3 = 0;
        if (arg0.admin_fee_share_bp != 0) {
            let v4 = 0x2::coin::value<T0>(&arg6) * arg0.admin_fee_share_bp / 10000;
            v3 = v4;
            if (v4 == 0) {
                v3 = 1;
            };
        };
        let v5 = 0x2::coin::split<T0>(&mut arg6, v3, arg12);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::add_fee<T0, FeeCollectorCap>(&mut arg0.fee_collector, v5);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::add_fee<0x2::sui::SUI, FeeCollectorCap>(&mut arg0.fee_collector, arg7);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::add_fee<T0, FeeCollectorCap>(&mut arg0.fee_collector, arg8);
        let (_, v7) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::deposit_for_burn_with_package_auth<T0, 0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, 0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::message_transmitter_authenticator::new(), arg6, get_domain_by_chain_id(arg0, arg9), 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_address(&arg10)), arg2, arg3, arg5, arg4, arg12);
        let v8 = v7;
        let v9 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v8);
        0x2::table::add<u64, address>(&mut arg0.senders, v9, 0x2::tx_context::sender(arg12));
        0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::events::tokens_sent_event<T0>(0x2::coin::value<T0>(&arg6), 0x2::coin::value<T0>(&v5), 0x2::tx_context::sender(arg12), arg10, arg11, arg9, v9);
        0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::events::receive_fee_event(0x2::coin::value<0x2::sui::SUI>(&arg7), v0, v2, v1);
    }

    public(friend) fun change_recipient<T0: drop>(arg0: &CctpBridge, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg4: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg5: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg6: &0x2::tx_context::TxContext) {
        let v0 = deserialize_nonce(&arg1);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<u64, address>(&arg0.senders, v0), 5);
        assert!(*0x2::table::borrow<u64, address>(&arg0.senders, v0) == v1, 6);
        let (_, _) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::replace_deposit_for_burn_with_package_auth<0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_replace_deposit_for_burn_ticket<0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::message_transmitter_authenticator::new(), arg1, arg2, 0x1::option::none<address>(), 0x1::option::some<address>(0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_address(&arg3))), arg4, arg5);
        0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::events::recipient_replaced<T0>(v1, v0, arg3);
    }

    fun deserialize_nonce(arg0: &vector<u8>) : u64 {
        let v0 = 12;
        let v1 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(arg0, v0, v0 + 8);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0x2::bcs::new(v1);
        0x2::bcs::peel_u64(&mut v2)
    }

    public(friend) fun fee_value<T0>(arg0: &mut CctpBridge) : u64 {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::balance<T0, FeeCollectorCap>(&mut arg0.fee_collector)
    }

    public(friend) fun gas_usage(arg0: &CctpBridge, arg1: u8) : u64 {
        *0x2::table::borrow<u8, u64>(&arg0.gas_usage, arg1)
    }

    public(friend) fun get_bridging_cost_in_tokens(arg0: &CctpBridge, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: u8) : u64 {
        assert!(0x2::table::contains<u8, u64>(&arg0.gas_usage, arg2), 4);
        0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle_interface::get_transaction_gas_cost_in_stable(arg1, arg2, *0x2::table::borrow<u8, u64>(&arg0.gas_usage, arg2), 6)
    }

    public(friend) fun get_domain_by_chain_id(arg0: &CctpBridge, arg1: u8) : u32 {
        assert!(0x2::table::contains<u8, u32>(&arg0.chain_id_domain_map, arg1), 2);
        *0x2::table::borrow<u8, u32>(&arg0.chain_id_domain_map, arg1)
    }

    public(friend) fun get_id(arg0: &CctpBridge) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_transaction_cost(arg0: &CctpBridge, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: u8) : u64 {
        assert!(0x2::table::contains<u8, u64>(&arg0.gas_usage, arg2), 4);
        0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle_interface::get_transaction_gas_cost_in_native_token(arg1, arg2, *0x2::table::borrow<u8, u64>(&arg0.gas_usage, arg2))
    }

    public(friend) fun get_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::new(arg0);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::init_version<AdminCap>(&v0, &mut v1, 1);
        let v2 = FeeCollectorCap{dummy_field: false};
        let v3 = CctpBridge{
            id                  : v1,
            chain_id_domain_map : 0x2::table::new<u8, u32>(arg0),
            senders             : 0x2::table::new<u64, address>(arg0),
            fee_collector       : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::new<FeeCollectorCap>(arg0),
            fee_collector_cap   : v2,
            admin_fee_share_bp  : 0,
            gas_usage           : 0x2::table::new<u8, u64>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<CctpBridge>(v3);
    }

    public(friend) fun is_message_processed(arg0: &CctpBridge, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: u8, arg3: u64) : bool {
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::is_nonce_used(arg1, get_domain_by_chain_id(arg0, arg2), arg3)
    }

    public(friend) fun migrate(arg0: &AdminCap, arg1: &mut CctpBridge) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::migrate_version<AdminCap>(arg0, &mut arg1.id, 1);
    }

    public(friend) fun receive_tokens<T0: drop>(arg0: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg1: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2::deny_list::DenyList, arg3: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::handle_receive_message::deconstruct_stamp_receipt_ticket_with_burn_message(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::handle_receive_message::handle_receive_message<T0>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::receive_message(arg5, arg6, arg1, arg8), arg0, arg2, arg3, arg8));
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::complete_receive_message(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::stamp_receipt<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(v0, arg1), arg1);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg7);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, arg4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::events::tokens_received_event<T0>(arg4, arg5, v2);
    }

    public(friend) fun register_bridge_destination(arg0: &mut CctpBridge, arg1: u8, arg2: u32) {
        0x2::table::add<u8, u32>(&mut arg0.chain_id_domain_map, arg1, arg2);
    }

    public(friend) fun set_admin_fee_share(arg0: &mut CctpBridge, arg1: u64) {
        assert!(arg1 <= 10000, 3);
        arg0.admin_fee_share_bp = arg1;
    }

    public(friend) fun set_gas_usage(arg0: &mut CctpBridge, arg1: u8, arg2: u64) {
        if (0x2::table::contains<u8, u64>(&arg0.gas_usage, arg1)) {
            *0x2::table::borrow_mut<u8, u64>(&mut arg0.gas_usage, arg1) = arg2;
        } else {
            0x2::table::add<u8, u64>(&mut arg0.gas_usage, arg1, arg2);
        };
    }

    public(friend) fun unregister_bridge_destination(arg0: &mut CctpBridge, arg1: u8) {
        0x2::table::remove<u8, u32>(&mut arg0.chain_id_domain_map, arg1);
    }

    public(friend) fun withdraw_fee<T0>(arg0: &mut CctpBridge, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::withdraw<T0, FeeCollectorCap>(&arg0.fee_collector_cap, &mut arg0.fee_collector, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

