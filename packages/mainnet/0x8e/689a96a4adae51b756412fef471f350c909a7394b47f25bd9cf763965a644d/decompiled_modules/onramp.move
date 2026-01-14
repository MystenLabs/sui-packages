module 0x8e689a96a4adae51b756412fef471f350c909a7394b47f25bd9cf763965a644d::onramp {
    struct ONRAMP has drop {
        dummy_field: bool,
    }

    struct StaticConfig has drop, store {
        chain_selector: u64,
    }

    struct DynamicConfig has copy, drop, store {
        fee_aggregator: address,
        allowlist_admin: address,
    }

    struct OnRampState has store, key {
        id: 0x2::object::UID,
        package_ids: vector<address>,
        s_send_last: u64,
    }

    struct OnRampObject has key {
        id: 0x2::object::UID,
    }

    struct OnRampStatePointer has store, key {
        id: 0x2::object::UID,
        on_ramp_object_id: address,
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

    struct CCIPMessageSent has copy, drop {
        dest_chain_selector: u64,
        sequence_number: u64,
        message: Sui2AnyRampMessage,
    }

    struct DestChainConfigSet has copy, drop {
        dest_chain_selector: u64,
        sequence_number: u64,
        allowlist_enabled: bool,
        router: address,
    }

    struct AllowlistSendersAdded has copy, drop {
        dest_chain_selector: u64,
        senders: vector<address>,
    }

    struct AllowlistSendersRemoved has copy, drop {
        dest_chain_selector: u64,
        senders: vector<address>,
    }

    public fun drill_allowlist_senders_added_removed() {
        emit_allowlist_senders_added(17529533435026248318);
        emit_allowlist_senders_removed(17529533435026248318);
    }

    public fun drill_onramp_initialize(arg0: address) {
        emit_dest_chain_config_set(arg0);
    }

    public fun drill_pending_commit_pending_queue_tx_spike(arg0: &mut OnRampState, arg1: u8, arg2: u8, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 <= arg2, 1);
        assert!((arg1 as u64) > arg0.s_send_last, 2);
        while (arg1 <= arg2) {
            emit_ccip_message_sent((arg1 as u64), arg3, 0x2::tx_context::sender(arg4), arg4);
            arg1 = arg1 + 1;
        };
        arg0.s_send_last = (arg2 as u64);
    }

    public fun drill_pending_commit_pending_queue_tx_spike_1(arg0: &mut OnRampState, arg1: u8, arg2: u8, arg3: address, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1 <= arg2, 1);
        assert!((arg1 as u64) > arg0.s_send_last, 2);
        while (arg1 <= arg2) {
            emit_ccip_message_sent((arg1 as u64), arg3, arg4, arg5);
            arg1 = arg1 + 1;
        };
        arg0.s_send_last = (arg2 as u64);
    }

    public fun emit_allowlist_senders_added(arg0: u64) {
        let v0 = AllowlistSendersAdded{
            dest_chain_selector : arg0,
            senders             : vector[],
        };
        0x2::event::emit<AllowlistSendersAdded>(v0);
    }

    public fun emit_allowlist_senders_removed(arg0: u64) {
        let v0 = AllowlistSendersRemoved{
            dest_chain_selector : arg0,
            senders             : vector[],
        };
        0x2::event::emit<AllowlistSendersRemoved>(v0);
    }

    public fun emit_ccip_message_sent(arg0: u64, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x2::tx_context::sender(arg3);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        let v2 = RampMessageHeader{
            message_id            : v0,
            source_chain_selector : 17529533435026248318,
            dest_chain_selector   : 17529533435026248318,
            sequence_number       : arg0,
            nonce                 : 1,
        };
        let v3 = Sui2AnyRampMessage{
            header           : v2,
            sender           : 0x2::tx_context::sender(arg3),
            data             : b"123",
            receiver         : 0x1::bcs::to_bytes<address>(&arg2),
            extra_args       : b"123",
            fee_token        : arg1,
            fee_token_amount : 0,
            fee_value_juels  : 0,
            token_amounts    : 0x1::vector::empty<Sui2AnyTokenTransfer>(),
        };
        let v4 = CCIPMessageSent{
            dest_chain_selector : 17529533435026248318,
            sequence_number     : arg0,
            message             : v3,
        };
        0x2::event::emit<CCIPMessageSent>(v4);
    }

    public fun emit_dest_chain_config_set(arg0: address) {
        let v0 = DestChainConfigSet{
            dest_chain_selector : 17529533435026248318,
            sequence_number     : 0,
            allowlist_enabled   : false,
            router              : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
        };
        0x2::event::emit<DestChainConfigSet>(v0);
    }

    public fun get_ccip_package_id() : address {
        @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217
    }

    public fun get_dest_chain_config(arg0: &OnRampState, arg1: u64) : (u64, bool, address) {
        (1, false, @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217)
    }

    public fun get_dynamic_config(arg0: &OnRampState) : DynamicConfig {
        DynamicConfig{
            fee_aggregator  : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
            allowlist_admin : @0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217,
        }
    }

    public fun get_dynamic_config_fields(arg0: DynamicConfig) : (address, address) {
        (arg0.fee_aggregator, arg0.allowlist_admin)
    }

    public fun get_send_last(arg0: &OnRampState) : u64 {
        arg0.s_send_last
    }

    public fun get_static_config(arg0: &OnRampState) : StaticConfig {
        StaticConfig{chain_selector: 17529533435026248318}
    }

    public fun get_static_config_fields(arg0: StaticConfig) : u64 {
        arg0.chain_selector
    }

    fun init(arg0: ONRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OnRampObject{id: 0x2::object::new(arg1)};
        let v1 = OnRampStatePointer{
            id                : 0x2::object::new(arg1),
            on_ramp_object_id : 0x2::object::id_address<OnRampObject>(&v0),
        };
        let v2 = 0x1::type_name::with_original_ids<ONRAMP>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        let v4 = 0x2::address::from_ascii_bytes(&v3);
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v4);
        let v6 = OnRampState{
            id          : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"OnRampState"),
            package_ids : v5,
            s_send_last : 0,
        };
        0x2::transfer::share_object<OnRampState>(v6);
        0x2::transfer::share_object<OnRampObject>(v0);
        0x2::transfer::transfer<OnRampStatePointer>(v1, v4);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"OnRamp 1.6.0")
    }

    // decompiled from Move bytecode v6
}

