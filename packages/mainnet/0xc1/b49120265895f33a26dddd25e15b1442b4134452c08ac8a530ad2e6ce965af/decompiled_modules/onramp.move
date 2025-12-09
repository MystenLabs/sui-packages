module 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::onramp {
    struct OnRampState has store, key {
        id: 0x2::object::UID,
        package_ids: vector<address>,
        chain_selector: u64,
        fee_aggregator: address,
        allowlist_admin: address,
        dest_chain_configs: 0x2::table::Table<u64, DestChainConfig>,
        fee_tokens: 0x2::bag::Bag,
        nonce_manager_cap: 0x1::option::Option<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager::NonceManagerCap>,
        source_transfer_cap: 0x1::option::Option<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::SourceTransferCap>,
        ownable_state: 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnableState,
    }

    struct OnRampObject has key {
        id: 0x2::object::UID,
    }

    struct OnRampStatePointer has store, key {
        id: 0x2::object::UID,
        on_ramp_object_id: address,
    }

    struct DestChainConfig has drop, store {
        sequence_number: u64,
        allowlist_enabled: bool,
        allowed_senders: vector<address>,
        router: address,
    }

    struct RampMessageHeader has copy, drop, store {
        message_id: vector<u8>,
        source_chain_selector: u64,
        dest_chain_selector: u64,
        sequence_number: u64,
        nonce: u64,
    }

    struct Sui2AnyRampMessage has copy, drop, store {
        header: RampMessageHeader,
        sender: address,
        data: vector<u8>,
        receiver: vector<u8>,
        extra_args: vector<u8>,
        fee_token: address,
        fee_token_amount: u64,
        fee_value_juels: u256,
        token_amounts: vector<Sui2AnyTokenTransfer>,
    }

    struct Sui2AnyTokenTransfer has copy, drop, store {
        source_pool_address: address,
        dest_token_address: vector<u8>,
        extra_data: vector<u8>,
        amount: u64,
        dest_exec_data: vector<u8>,
    }

    struct StaticConfig has copy, drop {
        chain_selector: u64,
    }

    struct DynamicConfig has copy, drop {
        fee_aggregator: address,
        allowlist_admin: address,
    }

    struct ConfigSet has copy, drop {
        static_config: StaticConfig,
        dynamic_config: DynamicConfig,
    }

    struct DestChainConfigSet has copy, drop {
        dest_chain_selector: u64,
        sequence_number: u64,
        allowlist_enabled: bool,
        router: address,
    }

    struct CCIPMessageSent has copy, drop {
        dest_chain_selector: u64,
        sequence_number: u64,
        message: Sui2AnyRampMessage,
    }

    struct AllowlistSendersAdded has copy, drop {
        dest_chain_selector: u64,
        senders: vector<address>,
    }

    struct AllowlistSendersRemoved has copy, drop {
        dest_chain_selector: u64,
        senders: vector<address>,
    }

    struct FeeTokenWithdrawn has copy, drop {
        fee_aggregator: address,
        fee_token: address,
        amount: u64,
    }

    struct ONRAMP has drop {
        dummy_field: bool,
    }

    struct McmsCallback has drop {
        dummy_field: bool,
    }

    struct McmsAcceptOwnershipProof has drop {
        dummy_field: bool,
    }

    public fun get_outbound_nonce(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: u64, arg2: address) : u64 {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"get_outbound_nonce"), 1);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager::get_outbound_nonce(arg0, arg1, arg2)
    }

    public fun accept_ownership(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"accept_ownership"), 1);
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::accept_ownership(&mut arg1.ownable_state, arg2);
    }

    public fun accept_ownership_from_object(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0x2::object::UID, arg3: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"accept_ownership_from_object"), 1);
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::accept_ownership_from_object(&mut arg1.ownable_state, arg2, arg3);
    }

    public fun add_package_id(arg0: &mut OnRampState, arg1: &0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg2: address) {
        assert!(0x2::object::id<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg1) == 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::owner_cap_id(&arg0.ownable_state), 20);
        0x1::vector::push_back<address>(&mut arg0.package_ids, arg2);
    }

    public fun apply_allowlist_updates(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg3: vector<u64>, arg4: vector<bool>, arg5: vector<vector<address>>, arg6: vector<vector<address>>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2) == 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::owner_cap_id(&arg1.ownable_state), 20);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"apply_allowlist_updates"), 1);
        apply_allowlist_updates_internal(arg1, arg3, arg4, arg5, arg6);
    }

    public fun apply_allowlist_updates_by_admin(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: vector<u64>, arg3: vector<bool>, arg4: vector<vector<address>>, arg5: vector<vector<address>>, arg6: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"apply_allowlist_updates_by_admin"), 1);
        assert!(arg1.allowlist_admin == 0x2::tx_context::sender(arg6), 6);
        apply_allowlist_updates_internal(arg1, arg2, arg3, arg4, arg5);
    }

    fun apply_allowlist_updates_internal(arg0: &mut OnRampState, arg1: vector<u64>, arg2: vector<bool>, arg3: vector<vector<address>>, arg4: vector<vector<address>>) {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<bool>(&arg2), 1);
        assert!(v0 == 0x1::vector::length<vector<address>>(&arg3), 1);
        assert!(v0 == 0x1::vector::length<vector<address>>(&arg4), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            assert!(0x2::table::contains<u64, DestChainConfig>(&arg0.dest_chain_configs, v2), 3);
            let v3 = *0x1::vector::borrow<bool>(&arg2, v1);
            let v4 = *0x1::vector::borrow<vector<address>>(&arg3, v1);
            let v5 = *0x1::vector::borrow<vector<address>>(&arg4, v1);
            let v6 = 0x2::table::borrow_mut<u64, DestChainConfig>(&mut arg0.dest_chain_configs, v2);
            v6.allowlist_enabled = v3;
            if (0x1::vector::length<address>(&v4) > 0) {
                assert!(v3, 7);
                let v7 = &v4;
                let v8 = 0;
                while (v8 < 0x1::vector::length<address>(v7)) {
                    let v9 = *0x1::vector::borrow<address>(v7, v8);
                    assert!(v9 != @0x0, 8);
                    let (v10, _) = 0x1::vector::index_of<address>(&v6.allowed_senders, &v9);
                    if (!v10) {
                        0x1::vector::push_back<address>(&mut v6.allowed_senders, v9);
                    };
                    v8 = v8 + 1;
                };
                let v12 = AllowlistSendersAdded{
                    dest_chain_selector : v2,
                    senders             : v4,
                };
                0x2::event::emit<AllowlistSendersAdded>(v12);
            };
            if (0x1::vector::length<address>(&v5) > 0) {
                let v13 = &v5;
                let v14 = 0;
                while (v14 < 0x1::vector::length<address>(v13)) {
                    let (v15, v16) = 0x1::vector::index_of<address>(&v6.allowed_senders, 0x1::vector::borrow<address>(v13, v14));
                    if (v15) {
                        0x1::vector::swap_remove<address>(&mut v6.allowed_senders, v16);
                    };
                    v14 = v14 + 1;
                };
                let v17 = AllowlistSendersRemoved{
                    dest_chain_selector : v2,
                    senders             : v5,
                };
                0x2::event::emit<AllowlistSendersRemoved>(v17);
            };
            v1 = v1 + 1;
        };
    }

    public fun apply_dest_chain_config_updates(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg3: vector<u64>, arg4: vector<bool>, arg5: vector<address>) {
        assert!(0x2::object::id<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2) == 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::owner_cap_id(&arg1.ownable_state), 20);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"apply_dest_chain_config_updates"), 1);
        apply_dest_chain_config_updates_internal(arg1, arg3, arg4, arg5);
    }

    fun apply_dest_chain_config_updates_internal(arg0: &mut OnRampState, arg1: vector<u64>, arg2: vector<bool>, arg3: vector<address>) {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<bool>(&arg2), 1);
        assert!(v0 == 0x1::vector::length<address>(&arg3), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            assert!(v2 != 0, 2);
            let v3 = *0x1::vector::borrow<bool>(&arg2, v1);
            let v4 = *0x1::vector::borrow<address>(&arg3, v1);
            if (!0x2::table::contains<u64, DestChainConfig>(&arg0.dest_chain_configs, v2)) {
                let v5 = DestChainConfig{
                    sequence_number   : 0,
                    allowlist_enabled : false,
                    allowed_senders   : vector[],
                    router            : @0x0,
                };
                0x2::table::add<u64, DestChainConfig>(&mut arg0.dest_chain_configs, v2, v5);
            };
            let v6 = 0x2::table::borrow_mut<u64, DestChainConfig>(&mut arg0.dest_chain_configs, v2);
            v6.allowlist_enabled = v3;
            v6.router = v4;
            let v7 = DestChainConfigSet{
                dest_chain_selector : v2,
                sequence_number     : v6.sequence_number,
                allowlist_enabled   : v3,
                router              : v4,
            };
            0x2::event::emit<DestChainConfigSet>(v7);
            v1 = v1 + 1;
        };
    }

    public fun calculate_message_hash(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: vector<u8>, arg9: vector<u8>, arg10: address, arg11: u64, arg12: vector<address>, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: vector<u64>, arg16: vector<vector<u8>>, arg17: vector<u8>) : vector<u8> {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"calculate_message_hash"), 1);
        let v0 = 0x1::vector::length<address>(&arg12);
        let v1 = if (v0 == 0x1::vector::length<vector<u8>>(&arg13)) {
            if (v0 == 0x1::vector::length<vector<u8>>(&arg14)) {
                if (v0 == 0x1::vector::length<u64>(&arg15)) {
                    v0 == 0x1::vector::length<vector<u8>>(&arg16)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 16);
        let v2 = 0x1::vector::empty<Sui2AnyTokenTransfer>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = Sui2AnyTokenTransfer{
                source_pool_address : *0x1::vector::borrow<address>(&arg12, v3),
                dest_token_address  : *0x1::vector::borrow<vector<u8>>(&arg13, v3),
                extra_data          : *0x1::vector::borrow<vector<u8>>(&arg14, v3),
                amount              : *0x1::vector::borrow<u64>(&arg15, v3),
                dest_exec_data      : *0x1::vector::borrow<vector<u8>>(&arg16, v3),
            };
            0x1::vector::push_back<Sui2AnyTokenTransfer>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v5 = RampMessageHeader{
            message_id            : arg2,
            source_chain_selector : arg3,
            dest_chain_selector   : arg4,
            sequence_number       : arg5,
            nonce                 : arg6,
        };
        let v6 = Sui2AnyRampMessage{
            header           : v5,
            sender           : arg7,
            data             : arg9,
            receiver         : arg8,
            extra_args       : arg17,
            fee_token        : arg10,
            fee_token_amount : arg11,
            fee_value_juels  : 0,
            token_amounts    : v2,
        };
        calculate_message_hash_internal(&v6, calculate_metadata_hash(arg0, arg3, arg4, arg1))
    }

    fun calculate_message_hash_internal(arg0: &Sui2AnyRampMessage, arg1: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::merkle_proof::leaf_domain_separator());
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, arg1);
        let v1 = b"";
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_address(&mut v1, arg0.sender);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v1, arg0.header.sequence_number);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v1, arg0.header.nonce);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_address(&mut v1, arg0.fee_token);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v1, arg0.fee_token_amount);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&v1));
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&arg0.receiver));
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&arg0.data));
        let v2 = b"";
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u256(&mut v2, (0x1::vector::length<Sui2AnyTokenTransfer>(&arg0.token_amounts) as u256));
        let v3 = &arg0.token_amounts;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Sui2AnyTokenTransfer>(v3)) {
            let v5 = 0x1::vector::borrow<Sui2AnyTokenTransfer>(v3, v4);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_address(&mut v2, v5.source_pool_address);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_bytes(&mut v2, v5.dest_token_address);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_bytes(&mut v2, v5.extra_data);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v2, v5.amount);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_bytes(&mut v2, v5.dest_exec_data);
            v4 = v4 + 1;
        };
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&v2));
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&arg0.extra_args));
        0x2::hash::keccak256(&v0)
    }

    public fun calculate_metadata_hash(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: u64, arg2: u64, arg3: address) : vector<u8> {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"calculate_metadata_hash"), 1);
        let v0 = b"";
        let v1 = b"Sui2AnyMessageHashV1";
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&v1));
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v0, arg1);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v0, arg2);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_address(&mut v0, arg3);
        0x2::hash::keccak256(&v0)
    }

    public fun ccip_send<T0>(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::TokenTransferParams, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &mut 0x2::coin::Coin<T0>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"ccip_send"), 1);
        let v0 = 0x2::object::id_to_address(0x2::object::borrow_id<0x2::coin::CoinMetadata<T0>>(arg7));
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0x1::vector::empty<Sui2AnyTokenTransfer>();
        if (0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::has_token_transfer(&arg6)) {
            let (v6, v7, v8, v9, v10, v11) = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::get_source_token_transfer_data(&arg6);
            assert!(v6 == arg3, 17);
            assert!(v8 > 0, 14);
            assert!(0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::token_admin_registry::get_pool(arg0, v9) == v7, 22);
            let v12 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::get_token_receiver(&arg6);
            assert!(0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::get_token_receiver(arg0, arg3, arg9, v12) == v12, 21);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::address::assert_non_zero_address_vector(&v12);
            let v13 = Sui2AnyTokenTransfer{
                source_pool_address : v7,
                dest_token_address  : v10,
                extra_data          : v11,
                amount              : v8,
                dest_exec_data      : b"",
            };
            0x1::vector::push_back<Sui2AnyTokenTransfer>(&mut v5, v13);
            0x1::vector::push_back<u64>(&mut v1, v8);
            0x1::vector::push_back<address>(&mut v2, v9);
            0x1::vector::push_back<vector<u8>>(&mut v3, v10);
            0x1::vector::push_back<vector<u8>>(&mut v4, v11);
        };
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::deconstruct_token_params(0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::SourceTransferCap>(&arg1.source_transfer_cap), arg6);
        let v14 = get_fee_internal(arg0, arg2, arg3, arg4, arg5, v2, v1, v0, arg9);
        if (v14 != 0) {
            assert!(v14 <= 0x2::balance::value<T0>(0x2::coin::balance<T0>(arg8)), 10);
            if (0x2::bag::contains<address>(&arg1.fee_tokens, v0)) {
                0x2::coin::join<T0>(0x2::bag::borrow_mut<address, 0x2::coin::Coin<T0>>(&mut arg1.fee_tokens, v0), 0x2::coin::split<T0>(arg8, v14, arg10));
            } else {
                0x2::bag::add<address, 0x2::coin::Coin<T0>>(&mut arg1.fee_tokens, v0, 0x2::coin::split<T0>(arg8, v14, arg10));
            };
        };
        let v15 = 0x2::tx_context::sender(arg10);
        verify_sender(arg1, arg3, v15);
        let v16 = get_incremented_sequence_number(arg1, arg3);
        let (v17, v18, v19, v20) = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::process_message_args(arg0, arg3, v0, v14, arg9, v2, v3, v4);
        let v21 = v20;
        let v22 = &mut v5;
        let v23 = &mut v21;
        let v24 = 0x1::vector::length<Sui2AnyTokenTransfer>(v22);
        assert!(v24 == 0x1::vector::length<vector<u8>>(v23), 13906838026929045503);
        let v25 = 0;
        while (v25 < v24) {
            0x1::vector::borrow_mut<Sui2AnyTokenTransfer>(v22, v25).dest_exec_data = *0x1::vector::borrow_mut<vector<u8>>(v23, v25);
            v25 = v25 + 1;
        };
        let v26 = construct_message(arg0, arg1, arg3, v18, v15, v16, arg5, arg4, v19, v0, v14, v17, v5, arg10);
        let v27 = CCIPMessageSent{
            dest_chain_selector : arg3,
            sequence_number     : v16,
            message             : v26,
        };
        0x2::event::emit<CCIPMessageSent>(v27);
        v26.header.message_id
    }

    fun construct_message(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &OnRampState, arg2: u64, arg3: bool, arg4: address, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: address, arg10: u64, arg11: u256, arg12: vector<Sui2AnyTokenTransfer>, arg13: &mut 0x2::tx_context::TxContext) : Sui2AnyRampMessage {
        let v0 = 0;
        if (!arg3) {
            v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager::get_incremented_outbound_nonce(arg0, 0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager::NonceManagerCap>(&arg1.nonce_manager_cap), arg2, arg4, arg13);
        };
        let v1 = RampMessageHeader{
            message_id            : b"",
            source_chain_selector : arg1.chain_selector,
            dest_chain_selector   : arg2,
            sequence_number       : arg5,
            nonce                 : v0,
        };
        let v2 = Sui2AnyRampMessage{
            header           : v1,
            sender           : arg4,
            data             : arg6,
            receiver         : arg7,
            extra_args       : arg8,
            fee_token        : arg9,
            fee_token_amount : arg10,
            fee_value_juels  : arg11,
            token_amounts    : arg12,
        };
        v2.header.message_id = calculate_message_hash_internal(&v2, calculate_metadata_hash(arg0, arg1.chain_selector, arg2, 0x2::object::uid_to_address(&arg1.id)));
        v2
    }

    public fun execute_ownership_transfer(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg2: &mut OnRampState, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"execute_ownership_transfer"), 1);
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::execute_ownership_transfer(arg1, &mut arg2.ownable_state, arg3, arg4);
    }

    public fun execute_ownership_transfer_to_mcms(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg2: &mut OnRampState, arg3: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"execute_ownership_transfer_to_mcms"), 1);
        let v0 = McmsCallback{dummy_field: false};
        let v1 = McmsCallback{dummy_field: false};
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::execute_ownership_transfer_to_mcms<McmsCallback>(arg1, &mut arg2.ownable_state, arg3, arg4, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::create_publisher_wrapper<McmsCallback>(0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::borrow_publisher(&arg1), v0), v1, vector[b"onramp"], arg5);
    }

    public fun get_allowed_senders_list(arg0: &OnRampState, arg1: u64) : (bool, vector<address>) {
        assert!(0x2::table::contains<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1), 3);
        let v0 = 0x2::table::borrow<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1);
        (v0.allowlist_enabled, v0.allowed_senders)
    }

    public fun get_ccip_package_id() : address {
        @0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e
    }

    public fun get_dest_chain_config(arg0: &OnRampState, arg1: u64) : (u64, bool, address) {
        assert!(0x2::table::contains<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1), 3);
        let v0 = 0x2::table::borrow<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1);
        (v0.sequence_number, v0.allowlist_enabled, v0.router)
    }

    public fun get_dynamic_config(arg0: &OnRampState) : DynamicConfig {
        DynamicConfig{
            fee_aggregator  : arg0.fee_aggregator,
            allowlist_admin : arg0.allowlist_admin,
        }
    }

    public fun get_dynamic_config_fields(arg0: DynamicConfig) : (address, address) {
        (arg0.fee_aggregator, arg0.allowlist_admin)
    }

    public fun get_expected_next_sequence_number(arg0: &OnRampState, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1), 3);
        0x2::table::borrow<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1).sequence_number + 1
    }

    public fun get_fee<T0>(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<address>, arg6: vector<u64>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: vector<u8>) : u64 {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"get_fee"), 1);
        get_fee_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::object::id_to_address(0x2::object::borrow_id<0x2::coin::CoinMetadata<T0>>(arg7)), arg8)
    }

    fun get_fee_internal(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<address>, arg6: vector<u64>, arg7: address, arg8: vector<u8>) : u64 {
        assert!(!0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::rmn_remote::is_cursed_u128(arg0, (arg2 as u128)), 9);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::get_validated_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    fun get_incremented_sequence_number(arg0: &mut OnRampState, arg1: u64) : u64 {
        let v0 = 0x2::table::borrow_mut<u64, DestChainConfig>(&mut arg0.dest_chain_configs, arg1);
        v0.sequence_number = v0.sequence_number + 1;
        v0.sequence_number
    }

    public fun get_static_config(arg0: &OnRampState) : StaticConfig {
        StaticConfig{chain_selector: arg0.chain_selector}
    }

    public fun get_static_config_fields(arg0: StaticConfig) : u64 {
        arg0.chain_selector
    }

    public fun has_pending_transfer(arg0: &OnRampState) : bool {
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::has_pending_transfer(&arg0.ownable_state)
    }

    fun init(arg0: ONRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OnRampObject{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::new(&mut v0.id, arg1);
        let v3 = v2;
        let v4 = OnRampStatePointer{
            id                : 0x2::object::new(arg1),
            on_ramp_object_id : 0x2::object::id_address<OnRampObject>(&v0),
        };
        let v5 = OnRampState{
            id                  : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"OnRampState"),
            package_ids         : vector[],
            chain_selector      : 0,
            fee_aggregator      : @0x0,
            allowlist_admin     : @0x0,
            dest_chain_configs  : 0x2::table::new<u64, DestChainConfig>(arg1),
            fee_tokens          : 0x2::bag::new(arg1),
            nonce_manager_cap   : 0x1::option::none<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager::NonceManagerCap>(),
            source_transfer_cap : 0x1::option::none<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::SourceTransferCap>(),
            ownable_state       : v1,
        };
        let v6 = 0x1::type_name::with_original_ids<ONRAMP>();
        let v7 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v6));
        0x2::transfer::share_object<OnRampState>(v5);
        0x2::transfer::share_object<OnRampObject>(v0);
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::attach_publisher(&mut v3, 0x2::package::claim<ONRAMP>(arg0, arg1));
        0x2::transfer::public_transfer<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<OnRampStatePointer>(v4, 0x2::address::from_ascii_bytes(&v7));
    }

    public fun initialize(arg0: &mut OnRampState, arg1: &0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg2: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager::NonceManagerCap, arg3: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::SourceTransferCap, arg4: u64, arg5: address, arg6: address, arg7: vector<u64>, arg8: vector<bool>, arg9: vector<address>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg1) == 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::owner_cap_id(&arg0.ownable_state), 20);
        assert!(arg4 != 0, 15);
        arg0.chain_selector = arg4;
        assert!(0x1::option::is_none<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager::NonceManagerCap>(&arg0.nonce_manager_cap), 12);
        0x1::option::fill<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager::NonceManagerCap>(&mut arg0.nonce_manager_cap, arg2);
        assert!(0x1::option::is_none<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::SourceTransferCap>(&arg0.source_transfer_cap), 13);
        0x1::option::fill<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::onramp_state_helper::SourceTransferCap>(&mut arg0.source_transfer_cap, arg3);
        set_dynamic_config_internal(arg0, arg5, arg6);
        apply_dest_chain_config_updates_internal(arg0, arg7, arg8, arg9);
        let v0 = 0x1::type_name::with_original_ids<ONRAMP>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x1::vector::push_back<address>(&mut arg0.package_ids, 0x2::address::from_ascii_bytes(&v1));
    }

    public fun is_chain_supported(arg0: &OnRampState, arg1: u64) : bool {
        0x2::table::contains<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1)
    }

    public fun mcms_accept_ownership(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"mcms_accept_ownership"), 1);
        let v0 = McmsAcceptOwnershipProof{dummy_field: false};
        let v1 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_accept_ownership_data<McmsAcceptOwnershipProof>(arg2, arg3, v0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addr(0x2::object::id_address<OnRampState>(arg1), &mut v1);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v1);
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::mcms_accept_ownership(&mut arg1.ownable_state, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address(), arg4);
    }

    public fun mcms_add_allowed_modules(arg0: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg1: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (_, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg0, v0, arg1);
        assert!(v2 == 0x1::string::utf8(b"add_allowed_modules"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addr(0x2::object::id_address<0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry>(arg0), &mut v4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = 0;
        while (v6 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<vector<u8>>(&mut v5, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v4));
            v6 = v6 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        let v7 = McmsCallback{dummy_field: false};
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::add_allowed_modules<McmsCallback>(arg0, v7, v5, arg2);
    }

    public fun mcms_add_package_id(arg0: &mut OnRampState, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"add_package_id"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OnRampState>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        add_package_id(arg0, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4));
    }

    public fun mcms_apply_allowlist_updates(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"apply_allowlist_updates"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OnRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0;
        while (v8 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<u64>(&mut v7, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v4));
            v8 = v8 + 1;
        };
        let v9 = 0x1::vector::empty<bool>();
        let v10 = 0;
        while (v10 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<bool>(&mut v9, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_bool(&mut v4));
            v10 = v10 + 1;
        };
        let v11 = 0x1::vector::empty<vector<address>>();
        let v12 = 0;
        while (v12 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            let v13 = &mut v4;
            let v14 = 0x1::vector::empty<address>();
            let v15 = 0;
            while (v15 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(v13)) {
                0x1::vector::push_back<address>(&mut v14, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(v13));
                v15 = v15 + 1;
            };
            0x1::vector::push_back<vector<address>>(&mut v11, v14);
            v12 = v12 + 1;
        };
        let v16 = 0x1::vector::empty<vector<address>>();
        let v17 = 0;
        while (v17 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            let v18 = &mut v4;
            let v19 = 0x1::vector::empty<address>();
            let v20 = 0;
            while (v20 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(v18)) {
                0x1::vector::push_back<address>(&mut v19, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(v18));
                v20 = v20 + 1;
            };
            0x1::vector::push_back<vector<address>>(&mut v16, v19);
            v17 = v17 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        apply_allowlist_updates(arg0, arg1, v1, v7, v9, v11, v16, arg4);
    }

    public fun mcms_apply_dest_chain_config_updates(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"apply_dest_chain_config_updates"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OnRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0;
        while (v8 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<u64>(&mut v7, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v4));
            v8 = v8 + 1;
        };
        let v9 = 0x1::vector::empty<bool>();
        let v10 = 0;
        while (v10 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<bool>(&mut v9, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_bool(&mut v4));
            v10 = v10 + 1;
        };
        let v11 = 0x1::vector::empty<address>();
        let v12 = 0;
        while (v12 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<address>(&mut v11, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4));
            v12 = v12 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        apply_dest_chain_config_updates(arg0, arg1, v1, v7, v9, v11);
    }

    public fun mcms_execute_ownership_transfer(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::DeployerState, arg4: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2, v0, arg4);
        assert!(v2 == 0x1::string::utf8(b"execute_ownership_transfer"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OnRampState>(arg1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        let v7 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        let v8 = McmsCallback{dummy_field: false};
        if (0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::has_upgrade_cap(arg3, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4))) {
            let v9 = McmsCallback{dummy_field: false};
            0x2::transfer::public_transfer<0x2::package::UpgradeCap>(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::release_upgrade_cap<McmsCallback>(arg3, arg2, v9), v7);
        };
        execute_ownership_transfer(arg0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::release_cap<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2, v8), arg1, v7, arg5);
    }

    public fun mcms_register_upgrade_cap(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: 0x2::package::UpgradeCap, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::DeployerState, arg4: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"mcms_register_upgrade_cap"), 1);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::register_upgrade_cap(arg3, arg2, arg1, arg4);
    }

    public fun mcms_remove_allowed_modules(arg0: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg1: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (_, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg0, v0, arg1);
        assert!(v2 == 0x1::string::utf8(b"remove_allowed_modules"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addr(0x2::object::id_address<0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry>(arg0), &mut v4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = 0;
        while (v6 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<vector<u8>>(&mut v5, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v4));
            v6 = v6 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        let v7 = McmsCallback{dummy_field: false};
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::remove_allowed_modules<McmsCallback>(arg0, v7, v5, arg2);
    }

    public fun mcms_remove_package_id(arg0: &mut OnRampState, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"remove_package_id"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OnRampState>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        remove_package_id(arg0, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4));
    }

    public fun mcms_set_dynamic_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"set_dynamic_config"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OnRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        set_dynamic_config(arg0, arg1, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4));
    }

    public fun mcms_transfer_ownership(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"transfer_ownership"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OnRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        transfer_ownership(arg0, arg1, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4), arg4);
    }

    public fun mcms_withdraw_fee_tokens<T0>(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2, v0, arg4);
        assert!(v2 == 0x1::string::utf8(b"withdraw_fee_tokens"), 18);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OnRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(v1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(arg3));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        withdraw_fee_tokens<T0>(arg0, arg1, v1, arg3);
    }

    public fun owner(arg0: &OnRampState) : address {
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::owner(&arg0.ownable_state)
    }

    public fun pending_transfer_accepted(arg0: &OnRampState) : 0x1::option::Option<bool> {
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::pending_transfer_accepted(&arg0.ownable_state)
    }

    public fun pending_transfer_from(arg0: &OnRampState) : 0x1::option::Option<address> {
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::pending_transfer_from(&arg0.ownable_state)
    }

    public fun pending_transfer_to(arg0: &OnRampState) : 0x1::option::Option<address> {
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::pending_transfer_to(&arg0.ownable_state)
    }

    public fun remove_package_id(arg0: &mut OnRampState, arg1: &0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg2: address) {
        assert!(0x2::object::id<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg1) == 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::owner_cap_id(&arg0.ownable_state), 20);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.package_ids, &arg2);
        assert!(v0, 19);
        0x1::vector::remove<address>(&mut arg0.package_ids, v1);
    }

    public fun set_dynamic_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg3: address, arg4: address) {
        assert!(0x2::object::id<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2) == 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::owner_cap_id(&arg1.ownable_state), 20);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"set_dynamic_config"), 1);
        set_dynamic_config_internal(arg1, arg3, arg4);
    }

    fun set_dynamic_config_internal(arg0: &mut OnRampState, arg1: address, arg2: address) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::address::assert_non_zero_address(arg1);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::address::assert_non_zero_address(arg2);
        arg0.fee_aggregator = arg1;
        arg0.allowlist_admin = arg2;
        let v0 = StaticConfig{chain_selector: arg0.chain_selector};
        let v1 = DynamicConfig{
            fee_aggregator  : arg1,
            allowlist_admin : arg2,
        };
        let v2 = ConfigSet{
            static_config  : v0,
            dynamic_config : v1,
        };
        0x2::event::emit<ConfigSet>(v2);
    }

    public fun transfer_ownership(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"transfer_ownership"), 1);
        0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::transfer_ownership(arg2, &mut arg1.ownable_state, arg3, arg4);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"OnRamp 1.6.0")
    }

    fun verify_sender(arg0: &OnRampState, arg1: u64, arg2: address) {
        assert!(0x2::table::contains<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1), 3);
        let v0 = 0x2::table::borrow<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1);
        assert!(v0.router != @0x0, 4);
        if (v0.allowlist_enabled) {
            assert!(0x1::vector::contains<address>(&v0.allowed_senders, &arg2), 5);
        };
    }

    public fun withdraw_fee_tokens<T0>(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OnRampState, arg2: &0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap, arg3: &0x2::coin::CoinMetadata<T0>) {
        assert!(arg1.fee_aggregator != @0x0, 11);
        assert!(0x2::object::id<0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::OwnerCap>(arg2) == 0xc1b49120265895f33a26dddd25e15b1442b4134452c08ac8a530ad2e6ce965af::ownable::owner_cap_id(&arg1.ownable_state), 20);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"onramp"), 0x1::string::utf8(b"withdraw_fee_tokens"), 1);
        let v0 = 0x2::object::id_to_address(0x2::object::borrow_id<0x2::coin::CoinMetadata<T0>>(arg3));
        let v1 = 0x2::bag::remove<address, 0x2::coin::Coin<T0>>(&mut arg1.fee_tokens, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1.fee_aggregator);
        let v2 = FeeTokenWithdrawn{
            fee_aggregator : arg1.fee_aggregator,
            fee_token      : v0,
            amount         : 0x2::balance::value<T0>(0x2::coin::balance<T0>(&v1)),
        };
        0x2::event::emit<FeeTokenWithdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

