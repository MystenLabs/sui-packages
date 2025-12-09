module 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::offramp {
    struct OffRampState has store, key {
        id: 0x2::object::UID,
        package_ids: vector<address>,
        ocr3_base_state: 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::OCR3BaseState,
        chain_selector: u64,
        permissionless_execution_threshold_seconds: u32,
        source_chain_configs: 0x2::vec_map::VecMap<u64, SourceChainConfig>,
        execution_states: 0x2::table::Table<u64, 0x2::table::Table<u64, u8>>,
        roots: 0x2::table::Table<vector<u8>, u64>,
        latest_price_sequence_number: u64,
        fee_quoter_cap: 0x1::option::Option<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::FeeQuoterCap>,
        dest_transfer_cap: 0x1::option::Option<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>,
        ownable_state: 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnableState,
    }

    struct OffRampObject has key {
        id: 0x2::object::UID,
    }

    struct OffRampStatePointer has store, key {
        id: 0x2::object::UID,
        off_ramp_object_id: address,
    }

    struct SourceChainConfig has copy, drop, store {
        router: address,
        is_enabled: bool,
        min_seq_nr: u64,
        is_rmn_verification_disabled: bool,
        on_ramp: vector<u8>,
    }

    struct RampMessageHeader has drop {
        message_id: vector<u8>,
        source_chain_selector: u64,
        dest_chain_selector: u64,
        sequence_number: u64,
        nonce: u64,
    }

    struct Any2SuiRampMessage has drop {
        header: RampMessageHeader,
        sender: vector<u8>,
        data: vector<u8>,
        receiver: address,
        gas_limit: u256,
        token_receiver: address,
        token_amounts: vector<Any2SuiTokenTransfer>,
    }

    struct Any2SuiTokenTransfer has drop {
        source_pool_address: vector<u8>,
        dest_token_address: address,
        dest_gas_amount: u32,
        extra_data: vector<u8>,
        amount: u256,
    }

    struct ExecutionReport has drop {
        source_chain_selector: u64,
        message: Any2SuiRampMessage,
        offchain_token_data: vector<vector<u8>>,
        proofs: vector<vector<u8>>,
    }

    struct CommitReport has copy, drop, store {
        price_updates: PriceUpdates,
        blessed_merkle_roots: vector<MerkleRoot>,
        unblessed_merkle_roots: vector<MerkleRoot>,
        rmn_signatures: vector<vector<u8>>,
    }

    struct PriceUpdates has copy, drop, store {
        token_price_updates: vector<TokenPriceUpdate>,
        gas_price_updates: vector<GasPriceUpdate>,
    }

    struct TokenPriceUpdate has copy, drop, store {
        source_token: address,
        usd_per_token: u256,
    }

    struct GasPriceUpdate has copy, drop, store {
        dest_chain_selector: u64,
        usd_per_unit_gas: u256,
    }

    struct MerkleRoot has copy, drop, store {
        source_chain_selector: u64,
        on_ramp_address: vector<u8>,
        min_seq_nr: u64,
        max_seq_nr: u64,
        merkle_root: vector<u8>,
    }

    struct StaticConfig has copy, drop, store {
        chain_selector: u64,
        rmn_remote: address,
        token_admin_registry: address,
        nonce_manager: address,
    }

    struct DynamicConfig has copy, drop, store {
        fee_quoter: address,
        permissionless_execution_threshold_seconds: u32,
    }

    struct StaticConfigSet has copy, drop {
        chain_selector: u64,
    }

    struct DynamicConfigSet has copy, drop {
        dynamic_config: DynamicConfig,
    }

    struct SourceChainConfigSet has copy, drop {
        source_chain_selector: u64,
        source_chain_config: SourceChainConfig,
    }

    struct SkippedAlreadyExecuted has copy, drop {
        source_chain_selector: u64,
        sequence_number: u64,
    }

    struct ExecutionStateChanged has copy, drop {
        source_chain_selector: u64,
        sequence_number: u64,
        message_id: vector<u8>,
        message_hash: vector<u8>,
        state: u8,
    }

    struct CommitReportAccepted has copy, drop {
        blessed_merkle_roots: vector<MerkleRoot>,
        unblessed_merkle_roots: vector<MerkleRoot>,
        price_updates: PriceUpdates,
    }

    struct SkippedReportExecution has copy, drop {
        source_chain_selector: u64,
    }

    struct OFFRAMP has drop {
        dummy_field: bool,
    }

    struct McmsCallback has drop {
        dummy_field: bool,
    }

    struct McmsAcceptOwnershipProof has drop {
        dummy_field: bool,
    }

    public fun config_signers(arg0: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::OCRConfig) : vector<vector<u8>> {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::config_signers(arg0)
    }

    public fun config_transmitters(arg0: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::OCRConfig) : vector<address> {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::config_transmitters(arg0)
    }

    public fun latest_config_details(arg0: &OffRampState, arg1: u8) : 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::OCRConfig {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::latest_config_details(&arg0.ocr3_base_state, arg1)
    }

    public fun set_ocr3_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg3: vector<u8>, arg4: u8, arg5: u8, arg6: bool, arg7: vector<vector<u8>>, arg8: vector<address>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"set_ocr3_config"), 1);
        assert!(0x2::object::id<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2) == 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::owner_cap_id(&arg1.ownable_state), 30);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::set_ocr3_config(arg0, &mut arg1.ocr3_base_state, arg3, arg4, arg5, arg6, arg7, arg8);
        after_ocr3_config_set(arg1, arg4, arg6);
    }

    public fun accept_ownership(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"accept_ownership"), 1);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::accept_ownership(&mut arg1.ownable_state, arg2);
    }

    public fun accept_ownership_from_object(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &mut 0x2::object::UID, arg3: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"accept_ownership_from_object"), 1);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::accept_ownership_from_object(&mut arg1.ownable_state, arg2, arg3);
    }

    public fun add_package_id(arg0: &mut OffRampState, arg1: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg2: address) {
        assert!(0x2::object::id<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg1) == 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::owner_cap_id(&arg0.ownable_state), 30);
        0x1::vector::push_back<address>(&mut arg0.package_ids, arg2);
    }

    fun after_ocr3_config_set(arg0: &mut OffRampState, arg1: u8, arg2: bool) {
        if (arg1 == 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::ocr_plugin_type_commit()) {
            assert!(arg2, 17);
            arg0.latest_price_sequence_number = 0;
        } else if (arg1 == 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::ocr_plugin_type_execution()) {
            assert!(!arg2, 18);
        };
    }

    public fun apply_source_chain_config_updates(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg3: vector<u64>, arg4: vector<bool>, arg5: vector<bool>, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"apply_source_chain_config_updates"), 1);
        assert!(0x2::object::id<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2) == 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::owner_cap_id(&arg1.ownable_state), 30);
        apply_source_chain_config_updates_internal(arg1, arg3, arg4, arg5, arg6, arg7);
    }

    fun apply_source_chain_config_updates_internal(arg0: &mut OffRampState, arg1: vector<u64>, arg2: vector<bool>, arg3: vector<bool>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<bool>(&arg2), 1);
        assert!(v0 == 0x1::vector::length<bool>(&arg3), 1);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg4), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg4, v1);
            assert!(v2 != 0, 2);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::address::assert_non_zero_address_vector(&v3);
            if (0x2::vec_map::contains<u64, SourceChainConfig>(&arg0.source_chain_configs, &v2)) {
                let v4 = 0x2::vec_map::get<u64, SourceChainConfig>(&arg0.source_chain_configs, &v2);
                assert!(v4.min_seq_nr == 1 || v4.on_ramp == v3, 23);
            } else {
                let v5 = SourceChainConfig{
                    router                       : @0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e,
                    is_enabled                   : false,
                    min_seq_nr                   : 1,
                    is_rmn_verification_disabled : false,
                    on_ramp                      : b"",
                };
                0x2::vec_map::insert<u64, SourceChainConfig>(&mut arg0.source_chain_configs, v2, v5);
                0x2::table::add<u64, 0x2::table::Table<u64, u8>>(&mut arg0.execution_states, v2, 0x2::table::new<u64, u8>(arg5));
            };
            let v6 = 0x2::vec_map::get_mut<u64, SourceChainConfig>(&mut arg0.source_chain_configs, &v2);
            v6.is_enabled = *0x1::vector::borrow<bool>(&arg2, v1);
            v6.on_ramp = v3;
            v6.is_rmn_verification_disabled = *0x1::vector::borrow<bool>(&arg3, v1);
            let v7 = SourceChainConfigSet{
                source_chain_selector : v2,
                source_chain_config   : *v6,
            };
            0x2::event::emit<SourceChainConfigSet>(v7);
            v1 = v1 + 1;
        };
    }

    fun assert_source_chain_enabled(arg0: &OffRampState, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, SourceChainConfig>(&arg0.source_chain_configs, &arg1), 3);
        assert!(0x2::vec_map::get<u64, SourceChainConfig>(&arg0.source_chain_configs, &arg1).is_enabled, 10);
    }

    public fun calculate_message_hash(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: vector<u8>, arg10: u256, arg11: address, arg12: vector<vector<u8>>, arg13: vector<address>, arg14: vector<u32>, arg15: vector<vector<u8>>, arg16: vector<u256>) : vector<u8> {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"calculate_message_hash"), 1);
        let v0 = 0x1::vector::length<vector<u8>>(&arg12);
        let v1 = if (v0 == 0x1::vector::length<address>(&arg13)) {
            if (v0 == 0x1::vector::length<u32>(&arg14)) {
                if (v0 == 0x1::vector::length<vector<u8>>(&arg15)) {
                    v0 == 0x1::vector::length<u256>(&arg16)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 25);
        let v2 = 0x1::vector::empty<Any2SuiTokenTransfer>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = Any2SuiTokenTransfer{
                source_pool_address : *0x1::vector::borrow<vector<u8>>(&arg12, v3),
                dest_token_address  : *0x1::vector::borrow<address>(&arg13, v3),
                dest_gas_amount     : *0x1::vector::borrow<u32>(&arg14, v3),
                extra_data          : *0x1::vector::borrow<vector<u8>>(&arg15, v3),
                amount              : *0x1::vector::borrow<u256>(&arg16, v3),
            };
            0x1::vector::push_back<Any2SuiTokenTransfer>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v5 = RampMessageHeader{
            message_id            : arg1,
            source_chain_selector : arg2,
            dest_chain_selector   : arg3,
            sequence_number       : arg4,
            nonce                 : arg5,
        };
        let v6 = Any2SuiRampMessage{
            header         : v5,
            sender         : arg6,
            data           : arg9,
            receiver       : arg7,
            gas_limit      : arg10,
            token_receiver : arg11,
            token_amounts  : v2,
        };
        calculate_message_hash_internal(&v6, calculate_metadata_hash(arg0, arg2, arg3, arg8))
    }

    fun calculate_message_hash_internal(arg0: &Any2SuiRampMessage, arg1: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::merkle_proof::leaf_domain_separator());
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, arg1);
        let v1 = b"";
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v1, arg0.header.message_id);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_address(&mut v1, arg0.receiver);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v1, arg0.header.sequence_number);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u256(&mut v1, arg0.gas_limit);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_address(&mut v1, arg0.token_receiver);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v1, arg0.header.nonce);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&v1));
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&arg0.sender));
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&arg0.data));
        let v2 = b"";
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u256(&mut v2, (0x1::vector::length<Any2SuiTokenTransfer>(&arg0.token_amounts) as u256));
        let v3 = &arg0.token_amounts;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Any2SuiTokenTransfer>(v3)) {
            let v5 = 0x1::vector::borrow<Any2SuiTokenTransfer>(v3, v4);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_bytes(&mut v2, v5.source_pool_address);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_address(&mut v2, v5.dest_token_address);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u32(&mut v2, v5.dest_gas_amount);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_bytes(&mut v2, v5.extra_data);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u256(&mut v2, v5.amount);
            v4 = v4 + 1;
        };
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&v2));
        0x2::hash::keccak256(&v0)
    }

    public fun calculate_metadata_hash(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: u64, arg2: u64, arg3: vector<u8>) : vector<u8> {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"calculate_metadata_hash"), 1);
        let v0 = b"";
        let v1 = b"Any2SuiMessageHashV1";
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&v1));
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v0, arg1);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_u64(&mut v0, arg2);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::encode_right_padded_bytes32(&mut v0, 0x2::hash::keccak256(&arg3));
        0x2::hash::keccak256(&v0)
    }

    public fun commit(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0x2::clock::Clock, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"commit"), 1);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 2, 32);
        let v0 = deserialize_commit_report(arg4);
        if (0x1::vector::length<TokenPriceUpdate>(&v0.price_updates.token_price_updates) > 0 || 0x1::vector::length<GasPriceUpdate>(&v0.price_updates.gas_price_updates) > 0) {
            let v1 = 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::deserialize_sequence_bytes(*0x1::vector::borrow<vector<u8>>(&arg3, 1));
            if (arg1.latest_price_sequence_number < v1) {
                arg1.latest_price_sequence_number = v1;
                let v2 = vector[];
                let v3 = vector[];
                let v4 = &v0.price_updates.token_price_updates;
                let v5 = 0;
                while (v5 < 0x1::vector::length<TokenPriceUpdate>(v4)) {
                    let v6 = 0x1::vector::borrow<TokenPriceUpdate>(v4, v5);
                    0x1::vector::push_back<address>(&mut v2, v6.source_token);
                    0x1::vector::push_back<u256>(&mut v3, v6.usd_per_token);
                    v5 = v5 + 1;
                };
                let v7 = vector[];
                let v8 = vector[];
                let v9 = &v0.price_updates.gas_price_updates;
                let v10 = 0;
                while (v10 < 0x1::vector::length<GasPriceUpdate>(v9)) {
                    let v11 = 0x1::vector::borrow<GasPriceUpdate>(v9, v10);
                    0x1::vector::push_back<u64>(&mut v7, v11.dest_chain_selector);
                    0x1::vector::push_back<u256>(&mut v8, v11.usd_per_unit_gas);
                    v10 = v10 + 1;
                };
                0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::update_prices(arg0, 0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::FeeQuoterCap>(&arg1.fee_quoter_cap), arg2, v2, v3, v7, v8, arg6);
            } else {
                assert!(0x1::vector::length<MerkleRoot>(&v0.unblessed_merkle_roots) > 0, 15);
            };
        };
        commit_merkle_roots(arg0, arg1, arg2, v0.unblessed_merkle_roots, false);
        let v12 = CommitReportAccepted{
            blessed_merkle_roots   : v0.blessed_merkle_roots,
            unblessed_merkle_roots : v0.unblessed_merkle_roots,
            price_updates          : v0.price_updates,
        };
        0x2::event::emit<CommitReportAccepted>(v12);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::transmit(&arg1.ocr3_base_state, 0x2::tx_context::sender(arg6), 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::ocr_plugin_type_commit(), arg3, arg4, arg5, arg6);
    }

    fun commit_merkle_roots(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0x2::clock::Clock, arg3: vector<MerkleRoot>, arg4: bool) {
        let v0 = &arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<MerkleRoot>(v0)) {
            let v2 = 0x1::vector::borrow<MerkleRoot>(v0, v1);
            let v3 = v2.source_chain_selector;
            assert!(!0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::rmn_remote::is_cursed_u128(arg0, (v3 as u128)), 16);
            assert_source_chain_enabled(arg1, v3);
            let v4 = 0x2::vec_map::get_mut<u64, SourceChainConfig>(&mut arg1.source_chain_configs, &v3);
            assert!(arg4 != v4.is_rmn_verification_disabled, 21);
            assert!(v4.on_ramp == v2.on_ramp_address, 11);
            assert!(v4.min_seq_nr == v2.min_seq_nr && v2.min_seq_nr <= v2.max_seq_nr, 12);
            let v5 = v2.merkle_root;
            assert!(0x1::vector::length<u8>(&v5) == 32 && v5 != x"0000000000000000000000000000000000000000000000000000000000000000", 13);
            assert!(!0x2::table::contains<vector<u8>, u64>(&arg1.roots, v5), 14);
            v4.min_seq_nr = v2.max_seq_nr + 1;
            0x2::table::add<vector<u8>, u64>(&mut arg1.roots, v5, 0x2::clock::timestamp_ms(arg2) / 1000);
            v1 = v1 + 1;
        };
    }

    fun create_dynamic_config(arg0: u32) : DynamicConfig {
        DynamicConfig{
            fee_quoter                                 : @0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e,
            permissionless_execution_threshold_seconds : arg0,
        }
    }

    fun create_static_config(arg0: u64) : StaticConfig {
        StaticConfig{
            chain_selector       : arg0,
            rmn_remote           : @0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e,
            token_admin_registry : @0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e,
            nonce_manager        : @0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e,
        }
    }

    fun deserialize_commit_report(arg0: vector<u8>) : CommitReport {
        let v0 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(arg0);
        let v1 = 0x1::vector::empty<TokenPriceUpdate>();
        let v2 = 0;
        while (v2 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v0)) {
            let v3 = &mut v0;
            let v4 = TokenPriceUpdate{
                source_token  : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(v3),
                usd_per_token : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u256(v3),
            };
            0x1::vector::push_back<TokenPriceUpdate>(&mut v1, v4);
            v2 = v2 + 1;
        };
        let v5 = 0x1::vector::empty<GasPriceUpdate>();
        let v6 = 0;
        while (v6 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v0)) {
            let v7 = &mut v0;
            let v8 = GasPriceUpdate{
                dest_chain_selector : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(v7),
                usd_per_unit_gas    : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u256(v7),
            };
            0x1::vector::push_back<GasPriceUpdate>(&mut v5, v8);
            v6 = v6 + 1;
        };
        let v9 = &mut v0;
        let v10 = &mut v0;
        let v11 = 0x1::vector::empty<vector<u8>>();
        let v12 = 0;
        while (v12 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v0)) {
            0x1::vector::push_back<vector<u8>>(&mut v11, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_fixed_vector_u8(&mut v0, 64));
            v12 = v12 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v0);
        let v13 = PriceUpdates{
            token_price_updates : v1,
            gas_price_updates   : v5,
        };
        CommitReport{
            price_updates          : v13,
            blessed_merkle_roots   : parse_merkle_root(v9),
            unblessed_merkle_roots : parse_merkle_root(v10),
            rmn_signatures         : v11,
        }
    }

    fun deserialize_execution_report(arg0: vector<u8>) : ExecutionReport {
        let v0 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(arg0);
        let v1 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v0);
        let v2 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v0);
        let v3 = RampMessageHeader{
            message_id            : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_fixed_vector_u8(&mut v0, 32),
            source_chain_selector : v2,
            dest_chain_selector   : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v0),
            sequence_number       : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v0),
            nonce                 : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v0),
        };
        assert!(v1 == v2, 5);
        let v4 = 0x1::vector::empty<Any2SuiTokenTransfer>();
        let v5 = 0;
        while (v5 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v0)) {
            let v6 = &mut v0;
            let v7 = Any2SuiTokenTransfer{
                source_pool_address : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(v6),
                dest_token_address  : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(v6),
                dest_gas_amount     : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u32(v6),
                extra_data          : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(v6),
                amount              : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u256(v6),
            };
            0x1::vector::push_back<Any2SuiTokenTransfer>(&mut v4, v7);
            v5 = v5 + 1;
        };
        let v8 = Any2SuiRampMessage{
            header         : v3,
            sender         : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v0),
            data           : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v0),
            receiver       : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v0),
            gas_limit      : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u256(&mut v0),
            token_receiver : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v0),
            token_amounts  : v4,
        };
        let v9 = 0x1::vector::empty<vector<u8>>();
        let v10 = 0;
        while (v10 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v0)) {
            0x1::vector::push_back<vector<u8>>(&mut v9, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v0));
            v10 = v10 + 1;
        };
        let v11 = 0x1::vector::empty<vector<u8>>();
        let v12 = 0;
        while (v12 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v0)) {
            0x1::vector::push_back<vector<u8>>(&mut v11, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_fixed_vector_u8(&mut v0, 32));
            v12 = v12 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v0);
        ExecutionReport{
            source_chain_selector : v1,
            message               : v8,
            offchain_token_data   : v9,
            proofs                : v11,
        }
    }

    public fun execute_ownership_transfer(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg2: &mut OffRampState, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"execute_ownership_transfer"), 1);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::execute_ownership_transfer(arg1, &mut arg2.ownable_state, arg3, arg4);
    }

    public fun execute_ownership_transfer_to_mcms(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg2: &mut OffRampState, arg3: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"execute_ownership_transfer_to_mcms"), 1);
        let v0 = McmsCallback{dummy_field: false};
        let v1 = McmsCallback{dummy_field: false};
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::execute_ownership_transfer_to_mcms<McmsCallback>(arg1, &mut arg2.ownable_state, arg3, arg4, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::create_publisher_wrapper<McmsCallback>(0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::borrow_publisher(&arg1), v0), v1, vector[b"offramp"], arg5);
    }

    public fun finish_execute(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::ReceiverParams) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"finish_execute"), 1);
        assert!(0x1::option::is_some<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), 24);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::deconstruct_receiver_params(0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), arg2);
    }

    public fun get_all_source_chain_configs(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &OffRampState) : (vector<u64>, vector<SourceChainConfig>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"get_all_source_chain_configs"), 1);
        let v0 = vector[];
        let v1 = 0x1::vector::empty<SourceChainConfig>();
        let v2 = 0x2::vec_map::keys<u64, SourceChainConfig>(&arg1.source_chain_configs);
        let v3 = &v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(v3)) {
            let v5 = 0x1::vector::borrow<u64>(v3, v4);
            0x1::vector::push_back<u64>(&mut v0, *v5);
            0x1::vector::push_back<SourceChainConfig>(&mut v1, *0x2::vec_map::get<u64, SourceChainConfig>(&arg1.source_chain_configs, v5));
            v4 = v4 + 1;
        };
        (v0, v1)
    }

    public fun get_ccip_package_id() : address {
        @0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e
    }

    public fun get_dynamic_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &OffRampState) : DynamicConfig {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"get_dynamic_config"), 1);
        create_dynamic_config(arg1.permissionless_execution_threshold_seconds)
    }

    public fun get_dynamic_config_fields(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: DynamicConfig) : (address, u32) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"get_dynamic_config_fields"), 1);
        (arg1.fee_quoter, arg1.permissionless_execution_threshold_seconds)
    }

    public fun get_execution_state(arg0: &OffRampState, arg1: u64, arg2: u64) : u8 {
        assert!(0x2::table::contains<u64, 0x2::table::Table<u64, u8>>(&arg0.execution_states, arg1), 3);
        let v0 = 0x2::table::borrow<u64, 0x2::table::Table<u64, u8>>(&arg0.execution_states, arg1);
        assert!(0x2::table::contains<u64, u8>(v0, arg2), 31);
        *0x2::table::borrow<u64, u8>(v0, arg2)
    }

    public fun get_latest_price_sequence_number(arg0: &OffRampState) : u64 {
        arg0.latest_price_sequence_number
    }

    public fun get_merkle_root(arg0: &OffRampState, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.roots, arg1), 13);
        *0x2::table::borrow<vector<u8>, u64>(&arg0.roots, arg1)
    }

    public fun get_ocr3_base(arg0: &OffRampState) : &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::OCR3BaseState {
        &arg0.ocr3_base_state
    }

    public fun get_source_chain_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &OffRampState, arg2: u64) : SourceChainConfig {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"get_source_chain_config"), 1);
        if (0x2::vec_map::contains<u64, SourceChainConfig>(&arg1.source_chain_configs, &arg2)) {
            *0x2::vec_map::get<u64, SourceChainConfig>(&arg1.source_chain_configs, &arg2)
        } else {
            SourceChainConfig{router: @0x0, is_enabled: false, min_seq_nr: 0, is_rmn_verification_disabled: false, on_ramp: b""}
        }
    }

    public fun get_source_chain_config_fields(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: SourceChainConfig) : (address, bool, u64, bool, vector<u8>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"get_source_chain_config_fields"), 1);
        (arg1.router, arg1.is_enabled, arg1.min_seq_nr, arg1.is_rmn_verification_disabled, arg1.on_ramp)
    }

    public fun get_static_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &OffRampState) : StaticConfig {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"get_static_config"), 1);
        create_static_config(arg1.chain_selector)
    }

    public fun get_static_config_fields(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: StaticConfig) : (u64, address, address, address) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"get_static_config_fields"), 1);
        (arg1.chain_selector, arg1.rmn_remote, arg1.token_admin_registry, arg1.nonce_manager)
    }

    public fun has_pending_transfer(arg0: &OffRampState) : bool {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::has_pending_transfer(&arg0.ownable_state)
    }

    fun init(arg0: OFFRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OffRampObject{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::new(&mut v0.id, arg1);
        let v3 = v2;
        let v4 = OffRampState{
            id                                         : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"OffRampState"),
            package_ids                                : vector[],
            ocr3_base_state                            : 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::new(arg1),
            chain_selector                             : 0,
            permissionless_execution_threshold_seconds : 0,
            source_chain_configs                       : 0x2::vec_map::empty<u64, SourceChainConfig>(),
            execution_states                           : 0x2::table::new<u64, 0x2::table::Table<u64, u8>>(arg1),
            roots                                      : 0x2::table::new<vector<u8>, u64>(arg1),
            latest_price_sequence_number               : 0,
            fee_quoter_cap                             : 0x1::option::none<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::FeeQuoterCap>(),
            dest_transfer_cap                          : 0x1::option::none<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(),
            ownable_state                              : v1,
        };
        let v5 = OffRampStatePointer{
            id                 : 0x2::object::new(arg1),
            off_ramp_object_id : 0x2::object::id_address<OffRampObject>(&v0),
        };
        let v6 = 0x1::type_name::with_original_ids<OFFRAMP>();
        let v7 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v6));
        0x2::transfer::share_object<OffRampState>(v4);
        0x2::transfer::share_object<OffRampObject>(v0);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::attach_publisher(&mut v3, 0x2::package::claim<OFFRAMP>(arg0, arg1));
        0x2::transfer::public_transfer<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<OffRampStatePointer>(v5, 0x2::address::from_ascii_bytes(&v7));
    }

    public fun init_execute(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0x2::clock::Clock, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::ReceiverParams {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"init_execute"), 1);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 2, 32);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::transmit(&arg1.ocr3_base_state, 0x2::tx_context::sender(arg5), 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::ocr_plugin_type_execution(), arg3, arg4, vector[], arg5);
        pre_execute_single_report(arg0, arg1, arg2, deserialize_execution_report(arg4), false)
    }

    public fun initialize(arg0: &mut OffRampState, arg1: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg2: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::FeeQuoterCap, arg3: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap, arg4: u64, arg5: u32, arg6: vector<u64>, arg7: vector<bool>, arg8: vector<bool>, arg9: vector<vector<u8>>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg1) == 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::owner_cap_id(&arg0.ownable_state), 30);
        assert!(arg4 != 0, 2);
        arg0.chain_selector = arg4;
        assert!(0x1::option::is_none<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::FeeQuoterCap>(&arg0.fee_quoter_cap), 19);
        0x1::option::fill<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::fee_quoter::FeeQuoterCap>(&mut arg0.fee_quoter_cap, arg2);
        assert!(0x1::option::is_none<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg0.dest_transfer_cap), 20);
        0x1::option::fill<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&mut arg0.dest_transfer_cap, arg3);
        let v0 = StaticConfigSet{chain_selector: arg4};
        0x2::event::emit<StaticConfigSet>(v0);
        set_dynamic_config_internal(arg0, arg5);
        apply_source_chain_config_updates_internal(arg0, arg6, arg7, arg8, arg9, arg10);
        let v1 = 0x1::type_name::with_original_ids<OFFRAMP>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x1::vector::push_back<address>(&mut arg0.package_ids, 0x2::address::from_ascii_bytes(&v2));
    }

    fun is_committed_root(arg0: &OffRampState, arg1: &0x2::clock::Clock, arg2: vector<u8>) : bool {
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.roots, arg2), 8);
        0x2::clock::timestamp_ms(arg1) / 1000 - *0x2::table::borrow<vector<u8>, u64>(&arg0.roots, arg2) > (arg0.permissionless_execution_threshold_seconds as u64)
    }

    public fun latest_config_digest_fields(arg0: 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::OCRConfig) : (vector<u8>, u8, u8, bool, vector<vector<u8>>, vector<address>) {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base::latest_config_details_fields(arg0)
    }

    public fun manually_init_execute(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0x2::clock::Clock, arg3: vector<u8>) : 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::ReceiverParams {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"manually_init_execute"), 1);
        pre_execute_single_report(arg0, arg1, arg2, deserialize_execution_report(arg3), true)
    }

    public fun mcms_accept_ownership(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"mcms_accept_ownership"), 1);
        let v0 = McmsAcceptOwnershipProof{dummy_field: false};
        let v1 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_accept_ownership_data<McmsAcceptOwnershipProof>(arg2, arg3, v0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addr(0x2::object::id_address<OffRampState>(arg1), &mut v1);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v1);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::mcms_accept_ownership(&mut arg1.ownable_state, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address(), arg4);
    }

    public fun mcms_add_allowed_modules(arg0: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg1: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (_, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg0, v0, arg1);
        assert!(v2 == 0x1::string::utf8(b"add_allowed_modules"), 26);
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

    public fun mcms_add_package_id(arg0: &mut OffRampState, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"add_package_id"), 26);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OffRampState>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        add_package_id(arg0, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4));
    }

    public fun mcms_apply_source_chain_config_updates(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"apply_source_chain_config_updates"), 26);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OffRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(v1));
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
        let v11 = 0x1::vector::empty<bool>();
        let v12 = 0;
        while (v12 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<bool>(&mut v11, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_bool(&mut v4));
            v12 = v12 + 1;
        };
        let v13 = 0x1::vector::empty<vector<u8>>();
        let v14 = 0;
        while (v14 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<vector<u8>>(&mut v13, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v4));
            v14 = v14 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        apply_source_chain_config_updates(arg0, arg1, v1, v7, v9, v11, v13, arg4);
    }

    public fun mcms_execute_ownership_transfer(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::DeployerState, arg4: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2, v0, arg4);
        assert!(v2 == 0x1::string::utf8(b"execute_ownership_transfer"), 26);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(v1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OffRampState>(arg1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        let v7 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        let v8 = McmsCallback{dummy_field: false};
        if (0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::has_upgrade_cap(arg3, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4))) {
            let v9 = McmsCallback{dummy_field: false};
            0x2::transfer::public_transfer<0x2::package::UpgradeCap>(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::release_upgrade_cap<McmsCallback>(arg3, arg2, v9), v7);
        };
        execute_ownership_transfer(arg0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::release_cap<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2, v8), arg1, v7, arg5);
    }

    public fun mcms_register_upgrade_cap(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: 0x2::package::UpgradeCap, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::DeployerState, arg4: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"mcms_register_upgrade_cap"), 1);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::register_upgrade_cap(arg3, arg2, arg1, arg4);
    }

    public fun mcms_remove_allowed_modules(arg0: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg1: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (_, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg0, v0, arg1);
        assert!(v2 == 0x1::string::utf8(b"remove_allowed_modules"), 26);
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

    public fun mcms_remove_package_id(arg0: &mut OffRampState, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"remove_package_id"), 26);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OffRampState>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        remove_package_id(arg0, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4));
    }

    public fun mcms_set_dynamic_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"set_dynamic_config"), 26);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OffRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        set_dynamic_config(arg0, arg1, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u32(&mut v4));
    }

    public fun mcms_set_ocr3_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"set_ocr3_config"), 26);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OffRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        let v7 = 0x1::vector::empty<vector<u8>>();
        let v8 = 0;
        while (v8 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<vector<u8>>(&mut v7, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v4));
            v8 = v8 + 1;
        };
        let v9 = 0x1::vector::empty<address>();
        let v10 = 0;
        while (v10 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<address>(&mut v9, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4));
            v10 = v10 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        set_ocr3_config(arg0, arg1, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v4), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u8(&mut v4), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u8(&mut v4), 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_bool(&mut v4), v7, v9);
    }

    public fun mcms_transfer_ownership(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"transfer_ownership"), 26);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<OffRampState>(arg1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(v1));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        transfer_ownership(arg0, arg1, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4), arg4);
    }

    public fun owner(arg0: &OffRampState) : address {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::owner(&arg0.ownable_state)
    }

    fun parse_merkle_root(arg0: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::BCSStream) : vector<MerkleRoot> {
        let v0 = 0x1::vector::empty<MerkleRoot>();
        let v1 = 0;
        while (v1 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(arg0)) {
            let v2 = MerkleRoot{
                source_chain_selector : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(arg0),
                on_ramp_address       : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(arg0),
                min_seq_nr            : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(arg0),
                max_seq_nr            : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(arg0),
                merkle_root           : 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_fixed_vector_u8(arg0, 32),
            };
            0x1::vector::push_back<MerkleRoot>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun pending_transfer_accepted(arg0: &OffRampState) : 0x1::option::Option<bool> {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::pending_transfer_accepted(&arg0.ownable_state)
    }

    public fun pending_transfer_from(arg0: &OffRampState) : 0x1::option::Option<address> {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::pending_transfer_from(&arg0.ownable_state)
    }

    public fun pending_transfer_to(arg0: &OffRampState) : 0x1::option::Option<address> {
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::pending_transfer_to(&arg0.ownable_state)
    }

    fun pre_execute_single_report(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0x2::clock::Clock, arg3: ExecutionReport, arg4: bool) : 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::ReceiverParams {
        let v0 = arg3.source_chain_selector;
        assert!(0x1::option::is_some<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), 24);
        if (0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::rmn_remote::is_cursed_u128(arg0, (v0 as u128))) {
            assert!(!arg4, 16);
            let v1 = SkippedReportExecution{source_chain_selector: v0};
            0x2::event::emit<SkippedReportExecution>(v1);
            return 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::create_receiver_params(0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), v0)
        };
        assert_source_chain_enabled(arg1, v0);
        assert!(arg3.message.header.dest_chain_selector == arg1.chain_selector, 6);
        let v2 = *0x2::vec_map::get<u64, SourceChainConfig>(&arg1.source_chain_configs, &v0);
        let v3 = calculate_message_hash_internal(&arg3.message, calculate_metadata_hash(arg0, v0, arg1.chain_selector, v2.on_ramp));
        if (arg4) {
            assert!(is_committed_root(arg1, arg2, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::merkle_proof::merkle_root(v3, arg3.proofs)), 9);
        };
        let v4 = 0x2::table::borrow_mut<u64, 0x2::table::Table<u64, u8>>(&mut arg1.execution_states, v0);
        let v5 = &arg3.message;
        let v6 = v5.header.sequence_number;
        if (!0x2::table::contains<u64, u8>(v4, v6)) {
            0x2::table::add<u64, u8>(v4, v6, 0);
        };
        let v7 = 0x2::table::borrow_mut<u64, u8>(v4, v6);
        if (*v7 != 0) {
            let v8 = SkippedAlreadyExecuted{
                source_chain_selector : v0,
                sequence_number       : v6,
            };
            0x2::event::emit<SkippedAlreadyExecuted>(v8);
            return 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::create_receiver_params(0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), v0)
        };
        assert!(v5.header.nonce == 0, 4);
        let v9 = 0x1::vector::length<Any2SuiTokenTransfer>(&v5.token_amounts);
        assert!(v9 <= 1, 28);
        assert!(v9 == 0x1::vector::length<vector<u8>>(&arg3.offchain_token_data), 7);
        assert!(v5.token_receiver == @0x0 && v9 == 0 || v5.token_receiver != @0x0 && v9 > 0, 27);
        let v10 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::create_receiver_params(0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), v0);
        let v11 = vector[];
        let v12 = vector[];
        if (v9 == 1) {
            let v13 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::token_admin_registry::get_pool(arg0, 0x1::vector::borrow<Any2SuiTokenTransfer>(&v5.token_amounts, 0).dest_token_address);
            assert!(v13 != @0x0, 22);
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::add_dest_token_transfer(0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), &mut v10, v5.token_receiver, v0, 0x1::vector::borrow<Any2SuiTokenTransfer>(&v5.token_amounts, 0).amount, 0x1::vector::borrow<Any2SuiTokenTransfer>(&v5.token_amounts, 0).dest_token_address, v13, 0x1::vector::borrow<Any2SuiTokenTransfer>(&v5.token_amounts, 0).source_pool_address, 0x1::vector::borrow<Any2SuiTokenTransfer>(&v5.token_amounts, 0).extra_data, *0x1::vector::borrow<vector<u8>>(&arg3.offchain_token_data, 0));
            0x1::vector::push_back<address>(&mut v11, 0x1::vector::borrow<Any2SuiTokenTransfer>(&v5.token_amounts, 0).dest_token_address);
            0x1::vector::push_back<u256>(&mut v12, 0x1::vector::borrow<Any2SuiTokenTransfer>(&v5.token_amounts, 0).amount);
        };
        if ((!0x1::vector::is_empty<u8>(&v5.data) || v5.gas_limit != 0) && 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::receiver_registry::is_registered_receiver(arg0, v5.receiver)) {
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::populate_message(0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), &mut v10, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::new_any2sui_message(0x1::option::borrow<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::offramp_state_helper::DestTransferCap>(&arg1.dest_transfer_cap), v5.header.message_id, v5.header.source_chain_selector, v5.sender, v5.data, v5.receiver, v5.token_receiver, v11, v12));
        };
        *v7 = 2;
        let v14 = ExecutionStateChanged{
            source_chain_selector : v0,
            sequence_number       : v6,
            message_id            : v5.header.message_id,
            message_hash          : v3,
            state                 : 2,
        };
        0x2::event::emit<ExecutionStateChanged>(v14);
        v10
    }

    public fun remove_package_id(arg0: &mut OffRampState, arg1: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg2: address) {
        assert!(0x2::object::id<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg1) == 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::owner_cap_id(&arg0.ownable_state), 30);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.package_ids, &arg2);
        assert!(v0, 29);
        0x1::vector::remove<address>(&mut arg0.package_ids, v1);
    }

    public fun set_dynamic_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg3: u32) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"set_dynamic_config"), 1);
        assert!(0x2::object::id<0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap>(arg2) == 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::owner_cap_id(&arg1.ownable_state), 30);
        set_dynamic_config_internal(arg1, arg3);
    }

    fun set_dynamic_config_internal(arg0: &mut OffRampState, arg1: u32) {
        arg0.permissionless_execution_threshold_seconds = arg1;
        let v0 = DynamicConfigSet{dynamic_config: create_dynamic_config(arg1)};
        0x2::event::emit<DynamicConfigSet>(v0);
    }

    public fun transfer_ownership(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OffRampState, arg2: &0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::OwnerCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp"), 0x1::string::utf8(b"transfer_ownership"), 1);
        0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ownable::transfer_ownership(arg2, &mut arg1.ownable_state, arg3, arg4);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"OffRamp 1.6.0")
    }

    // decompiled from Move bytecode v6
}

