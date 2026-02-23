module 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::onramp {
    struct ConfigSet has copy, drop {
        static_config: StaticConfig,
        dynamic_config: DynamicConfig,
    }

    struct DestChainConfigSet has copy, drop {
        dest_chain_selector: u64,
        is_enabled: bool,
        sequence_number: u64,
        allowlist_enabled: bool,
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

    struct OnRampState has store, key {
        id: 0x2::object::UID,
        chain_selector: u64,
        fee_aggregator: address,
        allowlist_admin: address,
    }

    struct StaticConfig has copy, drop {
        chain_selector: u64,
    }

    struct DynamicConfig has copy, drop {
        fee_aggregator: address,
        allowlist_admin: address,
    }

    struct DestChainConfig has drop, store {
        is_enabled: bool,
        sequence_number: u64,
        allowlist_enabled: bool,
        allowed_senders: vector<address>,
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

    public fun create_default_test_dest_chain_config() : DestChainConfig {
        create_test_dest_chain_config(true, 1, false, vector[])
    }

    public fun create_default_test_dynamic_config() : DynamicConfig {
        create_test_dynamic_config(@0x1, @0x2)
    }

    public fun create_test_amounts() : vector<u64> {
        vector[1000, 5000, 10000, 50000]
    }

    public fun create_test_chain_selectors() : vector<u64> {
        vector[1, 137, 42161, 10]
    }

    public fun create_test_dest_chain_config(arg0: bool, arg1: u64, arg2: bool, arg3: vector<address>) : DestChainConfig {
        DestChainConfig{
            is_enabled        : arg0,
            sequence_number   : arg1,
            allowlist_enabled : arg2,
            allowed_senders   : arg3,
        }
    }

    public fun create_test_dynamic_config(arg0: address, arg1: address) : DynamicConfig {
        DynamicConfig{
            fee_aggregator  : arg0,
            allowlist_admin : arg1,
        }
    }

    public fun create_test_fee_tokens() : vector<address> {
        vector[@0x7, @0x8, @0x9, @0xa]
    }

    public fun create_test_message_ids() : vector<vector<u8>> {
        vector[x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef", x"2234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdea"]
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

    public fun create_test_senders() : vector<address> {
        vector[@0x3, @0x4, @0x5, @0x6]
    }

    public fun create_test_static_config(arg0: u64) : StaticConfig {
        StaticConfig{chain_selector: arg0}
    }

    public fun create_test_sui2any_ramp_message(arg0: RampMessageHeader, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: u64, arg7: u256, arg8: vector<Sui2AnyTokenTransfer>) : Sui2AnyRampMessage {
        Sui2AnyRampMessage{
            header           : arg0,
            sender           : arg1,
            data             : arg2,
            receiver         : arg3,
            extra_args       : arg4,
            fee_token        : arg5,
            fee_token_amount : arg6,
            fee_value_juels  : arg7,
            token_amounts    : arg8,
        }
    }

    public fun create_test_sui2any_token_transfer(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>) : Sui2AnyTokenTransfer {
        Sui2AnyTokenTransfer{
            source_pool_address : arg0,
            dest_token_address  : arg1,
            extra_data          : arg2,
            amount              : arg3,
            dest_exec_data      : arg4,
        }
    }

    public fun emit_allowlist_senders_added_event(arg0: u64, arg1: vector<address>) {
        let v0 = AllowlistSendersAdded{
            dest_chain_selector : arg0,
            senders             : arg1,
        };
        0x2::event::emit<AllowlistSendersAdded>(v0);
    }

    public fun emit_allowlist_senders_removed_event(arg0: u64, arg1: vector<address>) {
        let v0 = AllowlistSendersRemoved{
            dest_chain_selector : arg0,
            senders             : arg1,
        };
        0x2::event::emit<AllowlistSendersRemoved>(v0);
    }

    public fun emit_ccip_message_sent_event(arg0: u64, arg1: u64, arg2: Sui2AnyRampMessage) {
        let v0 = CCIPMessageSent{
            dest_chain_selector : arg0,
            sequence_number     : arg1,
            message             : arg2,
        };
        0x2::event::emit<CCIPMessageSent>(v0);
    }

    public fun emit_config_set_event(arg0: StaticConfig, arg1: DynamicConfig) {
        let v0 = ConfigSet{
            static_config  : arg0,
            dynamic_config : arg1,
        };
        0x2::event::emit<ConfigSet>(v0);
    }

    public fun emit_dest_chain_config_set_event(arg0: u64, arg1: bool, arg2: u64, arg3: bool) {
        let v0 = DestChainConfigSet{
            dest_chain_selector : arg0,
            is_enabled          : arg1,
            sequence_number     : arg2,
            allowlist_enabled   : arg3,
        };
        0x2::event::emit<DestChainConfigSet>(v0);
    }

    public fun emit_fee_token_withdrawn_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = FeeTokenWithdrawn{
            fee_aggregator : arg0,
            fee_token      : arg1,
            amount         : arg2,
        };
        0x2::event::emit<FeeTokenWithdrawn>(v0);
    }

    public fun emit_sample_ccip_message_sent_event() {
        let v0 = RampMessageHeader{
            message_id            : x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef",
            source_chain_selector : 1,
            dest_chain_selector   : 137,
            sequence_number       : 1,
            nonce                 : 1,
        };
        let v1 = Sui2AnyTokenTransfer{
            source_pool_address : @0x123,
            dest_token_address  : x"456789abcdef",
            extra_data          : x"deadbeef",
            amount              : 1000,
            dest_exec_data      : x"cafebabe",
        };
        let v2 = 0x1::vector::empty<Sui2AnyTokenTransfer>();
        0x1::vector::push_back<Sui2AnyTokenTransfer>(&mut v2, v1);
        let v3 = Sui2AnyRampMessage{
            header           : v0,
            sender           : @0x789,
            data             : x"abcdef123456",
            receiver         : x"abcdef123456",
            extra_args       : x"abcdef123456",
            fee_token        : @0xabc,
            fee_token_amount : 500,
            fee_value_juels  : 1000000,
            token_amounts    : v2,
        };
        let v4 = CCIPMessageSent{
            dest_chain_selector : 137,
            sequence_number     : 1,
            message             : v3,
        };
        0x2::event::emit<CCIPMessageSent>(v4);
    }

    // decompiled from Move bytecode v6
}

