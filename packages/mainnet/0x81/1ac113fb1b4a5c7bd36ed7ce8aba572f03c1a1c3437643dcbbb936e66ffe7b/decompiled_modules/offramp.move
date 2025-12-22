module 0x811ac113fb1b4a5c7bd36ed7ce8aba572f03c1a1c3437643dcbbb936e66ffe7b::offramp {
    struct CCIPObjectRef has store, key {
        id: 0x2::object::UID,
    }

    struct OffRampState has store, key {
        id: 0x2::object::UID,
        package_ids: vector<address>,
    }

    struct OffRampObject has key {
        id: 0x2::object::UID,
    }

    struct OffRampStatePointer has store, key {
        id: 0x2::object::UID,
        off_ramp_state_id: address,
        owner_cap_id: address,
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

    public fun add_package_id(arg0: &mut OffRampState, arg1: address) {
        0x1::vector::push_back<address>(&mut arg0.package_ids, arg1);
    }

    public fun create_default_test_dynamic_config() : DynamicConfig {
        create_test_dynamic_config(@0x2, 3600)
    }

    public fun create_default_test_source_chain_config() : SourceChainConfig {
        create_test_source_chain_config(@0x1, true, 1, false, x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef")
    }

    public fun create_test_any2sui_ramp_message(arg0: RampMessageHeader, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u256, arg5: vector<Any2SuiTokenTransfer>) : Any2SuiRampMessage {
        Any2SuiRampMessage{
            header        : arg0,
            sender        : arg1,
            data          : arg2,
            receiver      : arg3,
            gas_limit     : arg4,
            token_amounts : arg5,
        }
    }

    public fun create_test_any2sui_token_transfer(arg0: vector<u8>, arg1: address, arg2: u32, arg3: vector<u8>, arg4: u256) : Any2SuiTokenTransfer {
        Any2SuiTokenTransfer{
            source_pool_address : arg0,
            dest_token_address  : arg1,
            dest_gas_amount     : arg2,
            extra_data          : arg3,
            amount              : arg4,
        }
    }

    public fun create_test_chain_selectors() : vector<u64> {
        vector[1, 137, 42161, 10]
    }

    public fun create_test_dynamic_config(arg0: address, arg1: u32) : DynamicConfig {
        DynamicConfig{
            fee_quoter                                 : arg0,
            permissionless_execution_threshold_seconds : arg1,
        }
    }

    public fun create_test_gas_price_update(arg0: u64, arg1: u256) : GasPriceUpdate {
        GasPriceUpdate{
            dest_chain_selector : arg0,
            usd_per_unit_gas    : arg1,
        }
    }

    public fun create_test_merkle_root(arg0: u64, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>) : MerkleRoot {
        MerkleRoot{
            source_chain_selector : arg0,
            on_ramp_address       : arg1,
            min_seq_nr            : arg2,
            max_seq_nr            : arg3,
            merkle_root           : arg4,
        }
    }

    public fun create_test_message_ids() : vector<vector<u8>> {
        vector[x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef", x"2234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdea"]
    }

    public fun create_test_on_ramp_addresses() : vector<vector<u8>> {
        vector[x"3234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdeb", x"4234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdec"]
    }

    public fun create_test_price_updates(arg0: vector<TokenPriceUpdate>, arg1: vector<GasPriceUpdate>) : PriceUpdates {
        PriceUpdates{
            token_price_updates : arg0,
            gas_price_updates   : arg1,
        }
    }

    public fun create_test_ramp_message_header(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : RampMessageHeader {
        RampMessageHeader{
            message_id            : arg0,
            source_chain_selector : arg1,
            dest_chain_selector   : arg2,
            sequence_number       : arg3,
            nonce                 : arg4,
        }
    }

    public fun create_test_source_chain_config(arg0: address, arg1: bool, arg2: u64, arg3: bool, arg4: vector<u8>) : SourceChainConfig {
        SourceChainConfig{
            router                       : arg0,
            is_enabled                   : arg1,
            min_seq_nr                   : arg2,
            is_rmn_verification_disabled : arg3,
            on_ramp                      : arg4,
        }
    }

    public fun create_test_token_price_update(arg0: address, arg1: u256) : TokenPriceUpdate {
        TokenPriceUpdate{
            source_token  : arg0,
            usd_per_token : arg1,
        }
    }

    public fun emit_commit_report_accepted_event(arg0: vector<MerkleRoot>, arg1: vector<MerkleRoot>, arg2: PriceUpdates) {
        let v0 = CommitReportAccepted{
            blessed_merkle_roots   : arg0,
            unblessed_merkle_roots : arg1,
            price_updates          : arg2,
        };
        0x2::event::emit<CommitReportAccepted>(v0);
    }

    public fun emit_dynamic_config_set_event(arg0: DynamicConfig) {
        let v0 = DynamicConfigSet{dynamic_config: arg0};
        0x2::event::emit<DynamicConfigSet>(v0);
    }

    public fun emit_execution_state_changed_event(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u8) {
        let v0 = ExecutionStateChanged{
            source_chain_selector : arg0,
            sequence_number       : arg1,
            message_id            : arg2,
            message_hash          : arg3,
            state                 : arg4,
        };
        0x2::event::emit<ExecutionStateChanged>(v0);
    }

    public fun emit_sample_execution_state_changed_event() {
        emit_execution_state_changed_event(24, 12, x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef", x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef", 1);
    }

    public fun emit_skipped_already_executed_event(arg0: u64, arg1: u64) {
        let v0 = SkippedAlreadyExecuted{
            source_chain_selector : arg0,
            sequence_number       : arg1,
        };
        0x2::event::emit<SkippedAlreadyExecuted>(v0);
    }

    public fun emit_skipped_report_execution_event(arg0: u64) {
        let v0 = SkippedReportExecution{source_chain_selector: arg0};
        0x2::event::emit<SkippedReportExecution>(v0);
    }

    public fun emit_source_chain_config_set_event(arg0: u64, arg1: SourceChainConfig) {
        let v0 = SourceChainConfigSet{
            source_chain_selector : arg0,
            source_chain_config   : arg1,
        };
        0x2::event::emit<SourceChainConfigSet>(v0);
    }

    public fun emit_static_config_set_event(arg0: u64) {
        let v0 = StaticConfigSet{chain_selector: arg0};
        0x2::event::emit<StaticConfigSet>(v0);
    }

    public fun finish_execute() {
        abort 1
    }

    public fun get_all_source_chain_configs() : (vector<u64>, vector<SourceChainConfig>) {
        let v0 = vector[];
        let v1 = 0x1::vector::empty<SourceChainConfig>();
        0x1::vector::push_back<u64>(&mut v0, 16015286);
        0x1::vector::push_back<SourceChainConfig>(&mut v1, create_default_test_source_chain_config());
        (v0, v1)
    }

    fun init(arg0: OFFRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get_with_original_ids<OFFRAMP>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::get_address(&v0));
        let v2 = 0x2::address::from_ascii_bytes(&v1);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, v2);
        let v4 = OffRampState{
            id          : 0x2::object::new(arg1),
            package_ids : v3,
        };
        let v5 = CCIPObjectRef{id: 0x2::object::new(arg1)};
        let v6 = SourceChainConfig{
            router                       : 0x2::tx_context::sender(arg1),
            is_enabled                   : true,
            min_seq_nr                   : 0,
            is_rmn_verification_disabled : true,
            on_ramp                      : x"0000000000000000000000000000000000000000000000000000000001010101",
        };
        let v7 = SourceChainConfigSet{
            source_chain_selector : 16015286601757825753,
            source_chain_config   : v6,
        };
        0x2::event::emit<SourceChainConfigSet>(v7);
        let v8 = OffRampObject{id: 0x2::object::new(arg1)};
        let v9 = OffRampStatePointer{
            id                 : 0x2::object::new(arg1),
            off_ramp_state_id  : 0x2::object::uid_to_address(&v4.id),
            owner_cap_id       : @0x0,
            off_ramp_object_id : 0x2::object::id_address<OffRampObject>(&v8),
        };
        let v10 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v10, v2);
        let v11 = OffRampState{
            id          : 0x2::derived_object::claim<vector<u8>>(&mut v8.id, b"OffRampState"),
            package_ids : v10,
        };
        0x2::transfer::share_object<OffRampState>(v4);
        0x2::transfer::share_object<OffRampState>(v11);
        0x2::transfer::share_object<OffRampObject>(v8);
        0x2::transfer::public_share_object<CCIPObjectRef>(v5);
        0x2::transfer::transfer<OffRampStatePointer>(v9, v2);
    }

    public fun init_execute(arg0: &CCIPObjectRef, arg1: &mut OffRampState, arg2: &0x2::clock::Clock, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
    }

    public fun remove_package_id(arg0: &mut OffRampState, arg1: address) {
        0x1::vector::remove<address>(&mut arg0.package_ids, 0);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"OffRamp 1.6.0")
    }

    // decompiled from Move bytecode v6
}

