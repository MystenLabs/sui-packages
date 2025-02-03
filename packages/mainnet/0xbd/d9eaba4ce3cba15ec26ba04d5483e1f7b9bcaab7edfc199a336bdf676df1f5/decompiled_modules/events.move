module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events {
    struct AggregatorInitEvent has copy, drop, store {
        aggregator_address: address,
    }

    struct AggregatorUpdateEvent has copy, drop, store {
        aggregator_address: address,
        old_value: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
        new_value: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
    }

    struct AggregatorResultEvent has copy, drop, store {
        aggregator_address: address,
        result_address: address,
    }

    struct AggregatorFastUpdateEvent has copy, drop, store {
        aggregator_address: address,
        aggregator_token_address: address,
        old_value: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
        new_value: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
        result_address: address,
    }

    struct AggregatorSaveResultEvent has copy, drop, store {
        aggregator_address: address,
        oracle_key: address,
        value: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
    }

    struct AggregatorOpenIntervalEvent has copy, drop, store {
        aggregator_address: address,
        queue_address: address,
    }

    struct AggregatorCrankEvictionEvent has copy, drop, store {
        aggregator_address: address,
        queue_address: address,
    }

    struct OracleRewardEvent has copy, drop, store {
        aggregator_address: address,
        oracle_address: address,
        amount: u64,
    }

    struct OracleEscrowWithdrawEvent has copy, drop, store {
        oracle_address: address,
        destination_address: address,
        amount: u64,
    }

    struct AggregatorEscrowWithdrawEvent has copy, drop, store {
        aggregator_address: address,
        destination_address: address,
        previous_amount: u64,
        new_amount: u64,
    }

    struct AggregatorEscrowFundEvent has copy, drop, store {
        aggregator_address: address,
        funder: address,
        amount: u64,
    }

    struct OracleBootedEvent has copy, drop, store {
        queue_address: address,
        oracle_address: address,
    }

    struct OraclePointerUpdateEvent has copy, drop, store {
        queue_address: address,
        oracle_idx: u64,
    }

    struct QuoteVerifyRequestEvent has copy, drop, store {
        quote: address,
        verifier: address,
        verifiee: address,
    }

    struct QueueSendRequestEvent has copy, drop, store {
        queue: address,
        requster: address,
        receiver: address,
        x25519_encrypted_data: vector<u8>,
        decrypt_hash: vector<u8>,
    }

    struct NodeBootedEvent has copy, drop, store {
        queue_address: address,
        node_address: address,
    }

    public(friend) fun emit_aggregator_crank_eviction_event(arg0: address, arg1: address) {
        let v0 = AggregatorCrankEvictionEvent{
            aggregator_address : arg0,
            queue_address      : arg1,
        };
        0x2::event::emit<AggregatorCrankEvictionEvent>(v0);
    }

    public(friend) fun emit_aggregator_escrow_fund_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = AggregatorEscrowFundEvent{
            aggregator_address : arg0,
            funder             : arg1,
            amount             : arg2,
        };
        0x2::event::emit<AggregatorEscrowFundEvent>(v0);
    }

    public(friend) fun emit_aggregator_escrow_withdraw_event(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = AggregatorEscrowWithdrawEvent{
            aggregator_address  : arg0,
            destination_address : arg1,
            previous_amount     : arg2,
            new_amount          : arg3,
        };
        0x2::event::emit<AggregatorEscrowWithdrawEvent>(v0);
    }

    public(friend) fun emit_aggregator_fast_update_event(arg0: address, arg1: address, arg2: address, arg3: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg4: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal) {
        let v0 = AggregatorFastUpdateEvent{
            aggregator_address       : arg0,
            aggregator_token_address : arg1,
            old_value                : arg3,
            new_value                : arg4,
            result_address           : arg2,
        };
        0x2::event::emit<AggregatorFastUpdateEvent>(v0);
    }

    public(friend) fun emit_aggregator_init_event(arg0: address) {
        let v0 = AggregatorInitEvent{aggregator_address: arg0};
        0x2::event::emit<AggregatorInitEvent>(v0);
    }

    public(friend) fun emit_aggregator_open_interval_event(arg0: address, arg1: address) {
        let v0 = AggregatorOpenIntervalEvent{
            aggregator_address : arg0,
            queue_address      : arg1,
        };
        0x2::event::emit<AggregatorOpenIntervalEvent>(v0);
    }

    public(friend) fun emit_aggregator_result_event(arg0: address, arg1: address) {
        let v0 = AggregatorResultEvent{
            aggregator_address : arg0,
            result_address     : arg1,
        };
        0x2::event::emit<AggregatorResultEvent>(v0);
    }

    public(friend) fun emit_aggregator_save_result_event(arg0: address, arg1: address, arg2: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal) {
        let v0 = AggregatorSaveResultEvent{
            aggregator_address : arg0,
            oracle_key         : arg1,
            value              : arg2,
        };
        0x2::event::emit<AggregatorSaveResultEvent>(v0);
    }

    public(friend) fun emit_aggregator_update_event(arg0: address, arg1: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg2: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal) {
        let v0 = AggregatorUpdateEvent{
            aggregator_address : arg0,
            old_value          : arg1,
            new_value          : arg2,
        };
        0x2::event::emit<AggregatorUpdateEvent>(v0);
    }

    public(friend) fun emit_node_booted_event(arg0: address, arg1: address) {
        let v0 = NodeBootedEvent{
            queue_address : arg0,
            node_address  : arg1,
        };
        0x2::event::emit<NodeBootedEvent>(v0);
    }

    public(friend) fun emit_oracle_booted_event(arg0: address, arg1: address) {
        let v0 = OracleBootedEvent{
            queue_address  : arg0,
            oracle_address : arg1,
        };
        0x2::event::emit<OracleBootedEvent>(v0);
    }

    public(friend) fun emit_oracle_pointer_update_event(arg0: address, arg1: u64) {
        let v0 = OraclePointerUpdateEvent{
            queue_address : arg0,
            oracle_idx    : arg1,
        };
        0x2::event::emit<OraclePointerUpdateEvent>(v0);
    }

    public(friend) fun emit_oracle_reward_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = OracleRewardEvent{
            aggregator_address : arg0,
            oracle_address     : arg1,
            amount             : arg2,
        };
        0x2::event::emit<OracleRewardEvent>(v0);
    }

    public(friend) fun emit_oracle_withdraw_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = OracleEscrowWithdrawEvent{
            oracle_address      : arg0,
            destination_address : arg1,
            amount              : arg2,
        };
        0x2::event::emit<OracleEscrowWithdrawEvent>(v0);
    }

    public(friend) fun emit_queue_send_request_event(arg0: address, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = QueueSendRequestEvent{
            queue                 : arg0,
            requster              : arg1,
            receiver              : arg2,
            x25519_encrypted_data : arg3,
            decrypt_hash          : arg4,
        };
        0x2::event::emit<QueueSendRequestEvent>(v0);
    }

    public(friend) fun emit_quote_verify_request_event(arg0: address, arg1: address, arg2: address) {
        let v0 = QuoteVerifyRequestEvent{
            quote    : arg0,
            verifier : arg1,
            verifiee : arg2,
        };
        0x2::event::emit<QuoteVerifyRequestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

