module 0x5d3b602c425ea58083d2f82092f325dc5e20cb8a4c49575a27bce31fc2acf3f0::offramp {
    struct OffRampObject has key {
        id: 0x2::object::UID,
    }

    struct OffRampStatePointer has store, key {
        id: 0x2::object::UID,
        off_ramp_object_id: address,
    }

    struct StaticConfigSet has copy, drop {
        chain_selector: u64,
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

    struct SourceChainConfig has copy, drop, store {
        router: address,
        is_enabled: bool,
        min_seq_nr: u64,
        is_rmn_verification_disabled: bool,
        on_ramp: vector<u8>,
    }

    struct DynamicConfigSet has copy, drop {
        dynamic_config: DynamicConfig,
    }

    struct SourceChainConfigSet has copy, drop {
        source_chain_selector: u64,
        source_chain_config: SourceChainConfig,
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

    struct OffRampState has store, key {
        id: 0x2::object::UID,
        package_ids: vector<address>,
    }

    struct OFFRAMP has drop {
        dummy_field: bool,
    }

    public fun add_package_id(arg0: &mut OffRampState, arg1: address) {
        0x1::vector::push_back<address>(&mut arg0.package_ids, arg1);
    }

    public fun drill_offramp_execute(arg0: &0x2::tx_context::TxContext) {
        emit_skipped_already_executed(17529533435026248318, 1);
        emit_skipped_report_execution(17529533435026248318);
        emit_execution_state_changed(17529533435026248318, 1, arg0);
    }

    public fun drill_offramp_initialize(arg0: &0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::state_object::CCIPObjectRef, arg1: &OffRampState) {
        emit_static_config_set();
        emit_dynamic_config_set(arg0, arg1);
        emit_source_chain_config_set();
    }

    public fun drill_pending_execution(arg0: &OffRampState, arg1: u8, arg2: u8) {
        assert!(arg1 <= arg2, 1);
        emit_commit_report_accepted((arg1 as u64), (arg2 as u64), @0x8e689a96a4adae51b756412fef471f350c909a7394b47f25bd9cf763965a644d, 17529533435026248318);
    }

    public fun emit_commit_report_accepted(arg0: u64, arg1: u64, arg2: address, arg3: u64) {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v1 = MerkleRoot{
            source_chain_selector : arg3,
            on_ramp_address       : 0x1::bcs::to_bytes<address>(&arg2),
            min_seq_nr            : arg0,
            max_seq_nr            : arg1,
            merkle_root           : v0,
        };
        let v2 = 0x1::vector::empty<MerkleRoot>();
        0x1::vector::push_back<MerkleRoot>(&mut v2, v1);
        let v3 = PriceUpdates{
            token_price_updates : 0x1::vector::empty<TokenPriceUpdate>(),
            gas_price_updates   : 0x1::vector::empty<GasPriceUpdate>(),
        };
        let v4 = CommitReportAccepted{
            blessed_merkle_roots   : 0x1::vector::empty<MerkleRoot>(),
            unblessed_merkle_roots : v2,
            price_updates          : v3,
        };
        0x2::event::emit<CommitReportAccepted>(v4);
    }

    public fun emit_dynamic_config_set(arg0: &0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::state_object::CCIPObjectRef, arg1: &OffRampState) {
        let v0 = DynamicConfigSet{dynamic_config: get_dynamic_config(arg0, arg1)};
        0x2::event::emit<DynamicConfigSet>(v0);
    }

    public fun emit_execution_state_changed(arg0: u64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v2 = b"";
        let v3 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg1));
        let v4 = ExecutionStateChanged{
            source_chain_selector : arg0,
            sequence_number       : arg1,
            message_id            : v0,
            message_hash          : v2,
            state                 : 2,
        };
        0x2::event::emit<ExecutionStateChanged>(v4);
    }

    public fun emit_execution_state_changed_failure(arg0: u64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v2 = b"";
        let v3 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg1));
        let v4 = ExecutionStateChanged{
            source_chain_selector : arg0,
            sequence_number       : arg1,
            message_id            : v0,
            message_hash          : v2,
            state                 : 3,
        };
        0x2::event::emit<ExecutionStateChanged>(v4);
    }

    public fun emit_execution_state_changed_in_progress(arg0: u64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v2 = b"";
        let v3 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg1));
        let v4 = ExecutionStateChanged{
            source_chain_selector : arg0,
            sequence_number       : arg1,
            message_id            : v0,
            message_hash          : v2,
            state                 : 1,
        };
        0x2::event::emit<ExecutionStateChanged>(v4);
    }

    public fun emit_execution_state_changed_untouched(arg0: u64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v2 = b"";
        let v3 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg1));
        let v4 = ExecutionStateChanged{
            source_chain_selector : arg0,
            sequence_number       : arg1,
            message_id            : v0,
            message_hash          : v2,
            state                 : 0,
        };
        0x2::event::emit<ExecutionStateChanged>(v4);
    }

    public fun emit_ocr3_base_config_set() {
        0x5d3b602c425ea58083d2f82092f325dc5e20cb8a4c49575a27bce31fc2acf3f0::ocr3_base::emit_config_set();
    }

    public fun emit_skipped_already_executed(arg0: u64, arg1: u64) {
        let v0 = SkippedAlreadyExecuted{
            source_chain_selector : arg0,
            sequence_number       : arg1,
        };
        0x2::event::emit<SkippedAlreadyExecuted>(v0);
    }

    public fun emit_skipped_report_execution(arg0: u64) {
        let v0 = SkippedReportExecution{source_chain_selector: arg0};
        0x2::event::emit<SkippedReportExecution>(v0);
    }

    public fun emit_source_chain_config_set() {
        let v0 = @0x8e689a96a4adae51b756412fef471f350c909a7394b47f25bd9cf763965a644d;
        let v1 = SourceChainConfig{
            router                       : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
            is_enabled                   : true,
            min_seq_nr                   : 0,
            is_rmn_verification_disabled : false,
            on_ramp                      : 0x1::bcs::to_bytes<address>(&v0),
        };
        let v2 = SourceChainConfigSet{
            source_chain_selector : 17529533435026248318,
            source_chain_config   : v1,
        };
        0x2::event::emit<SourceChainConfigSet>(v2);
    }

    public fun emit_static_config_set() {
        let v0 = StaticConfigSet{chain_selector: 17529533435026248318};
        0x2::event::emit<StaticConfigSet>(v0);
    }

    public fun get_all_source_chain_configs(arg0: &0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::state_object::CCIPObjectRef, arg1: &OffRampState) : (vector<u64>, vector<SourceChainConfig>) {
        let v0 = @0x8e689a96a4adae51b756412fef471f350c909a7394b47f25bd9cf763965a644d;
        let v1 = SourceChainConfig{
            router                       : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
            is_enabled                   : true,
            min_seq_nr                   : 2,
            is_rmn_verification_disabled : false,
            on_ramp                      : 0x1::bcs::to_bytes<address>(&v0),
        };
        let v2 = 0x1::vector::empty<SourceChainConfig>();
        0x1::vector::push_back<SourceChainConfig>(&mut v2, v1);
        (vector[17529533435026248318], v2)
    }

    public fun get_ccip_package_id() : address {
        @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217
    }

    public fun get_dynamic_config(arg0: &0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::state_object::CCIPObjectRef, arg1: &OffRampState) : DynamicConfig {
        DynamicConfig{
            fee_quoter                                 : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
            permissionless_execution_threshold_seconds : 10,
        }
    }

    public fun get_dynamic_config_fields(arg0: &0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::state_object::CCIPObjectRef, arg1: DynamicConfig) : (address, u32) {
        (arg1.fee_quoter, arg1.permissionless_execution_threshold_seconds)
    }

    public fun get_source_chain_config(arg0: &0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::state_object::CCIPObjectRef, arg1: &OffRampState, arg2: u64) : SourceChainConfig {
        let v0 = @0x8e689a96a4adae51b756412fef471f350c909a7394b47f25bd9cf763965a644d;
        SourceChainConfig{
            router                       : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
            is_enabled                   : true,
            min_seq_nr                   : 0,
            is_rmn_verification_disabled : false,
            on_ramp                      : 0x1::bcs::to_bytes<address>(&v0),
        }
    }

    public fun get_static_config(arg0: &0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::state_object::CCIPObjectRef, arg1: &OffRampState) : StaticConfig {
        StaticConfig{
            chain_selector       : 17529533435026248318,
            rmn_remote           : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
            token_admin_registry : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
            nonce_manager        : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
        }
    }

    public fun get_static_config_fields(arg0: &0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::state_object::CCIPObjectRef, arg1: StaticConfig) : (u64, address, address, address) {
        (arg1.chain_selector, arg1.rmn_remote, arg1.token_admin_registry, arg1.nonce_manager)
    }

    fun init(arg0: OFFRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OffRampObject{id: 0x2::object::new(arg1)};
        let v1 = OffRampStatePointer{
            id                 : 0x2::object::new(arg1),
            off_ramp_object_id : 0x2::object::id_address<OffRampObject>(&v0),
        };
        let v2 = 0x1::type_name::with_original_ids<OFFRAMP>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        let v4 = 0x2::address::from_ascii_bytes(&v3);
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v4);
        let v6 = OffRampState{
            id          : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"OffRampState"),
            package_ids : v5,
        };
        0x2::transfer::share_object<OffRampState>(v6);
        0x2::transfer::share_object<OffRampObject>(v0);
        0x2::transfer::transfer<OffRampStatePointer>(v1, v4);
    }

    public fun prepare_register() {
        emit_source_chain_config_set();
        emit_ocr3_base_config_set();
    }

    public fun remove_package_id(arg0: &mut OffRampState, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.package_ids, &arg1);
        assert!(v0, 1);
        0x1::vector::swap_remove<address>(&mut arg0.package_ids, v1);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"OffRamp 1.6.0")
    }

    // decompiled from Move bytecode v6
}

