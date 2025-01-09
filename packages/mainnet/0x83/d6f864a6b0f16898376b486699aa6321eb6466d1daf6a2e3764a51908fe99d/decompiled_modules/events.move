module 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events {
    struct SwappedToVUsdEvent has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
        vusd_amount: u64,
        fee: u64,
    }

    struct SwappedFromVUsdEvent has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
        vusd_amount: u64,
        fee: u64,
    }

    struct TokensSentEvent has copy, drop {
        token: 0x1::ascii::String,
        vusd_amount: u64,
        sender: address,
        recipient: 0x1::ascii::String,
        destination_chain_id: u8,
        receive_token: 0x1::ascii::String,
        nonce: u256,
        messenger: u8,
    }

    struct TokensReceivedEvent has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
        extra_gas_amount: u64,
        recipient: address,
        nonce: u256,
        messenger: u8,
        message: 0x1::ascii::String,
    }

    struct ReceiveFeeEvent has copy, drop {
        user_pay_sui: u64,
        user_pay_stable: u64,
        total_pay_sui: u64,
        bridge_fee_sui: u64,
        messenger_fee_sui: u64,
        total_fee_sui: u64,
    }

    struct SwappedEvent has copy, drop {
        token_from: 0x1::ascii::String,
        token_to: 0x1::ascii::String,
        sent_amount: u64,
        received_amount: u64,
        sender: address,
    }

    struct DepositEvent has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
        lp_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
        lp_amount: u64,
    }

    struct RewardsClaimedEvent has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
    }

    public(friend) fun deposit_event<T0>(arg0: u64, arg1: u64) {
        let v0 = DepositEvent{
            token     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount    : arg0,
            lp_amount : arg1,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun receive_fee_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ReceiveFeeEvent{
            user_pay_sui      : arg0,
            user_pay_stable   : arg1,
            total_pay_sui     : arg2,
            bridge_fee_sui    : arg3,
            messenger_fee_sui : arg4,
            total_fee_sui     : arg5,
        };
        0x2::event::emit<ReceiveFeeEvent>(v0);
    }

    public(friend) fun rewards_claimed_event<T0>(arg0: u64) {
        let v0 = RewardsClaimedEvent{
            token  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : arg0,
        };
        0x2::event::emit<RewardsClaimedEvent>(v0);
    }

    public(friend) fun swapped_event<T0, T1>(arg0: u64, arg1: u64, arg2: address) {
        let v0 = SwappedEvent{
            token_from      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            token_to        : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            sent_amount     : arg0,
            received_amount : arg1,
            sender          : arg2,
        };
        0x2::event::emit<SwappedEvent>(v0);
    }

    public(friend) fun swapped_from_vusd_event<T0>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = SwappedFromVUsdEvent{
            token       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount      : arg0,
            vusd_amount : arg1,
            fee         : arg2,
        };
        0x2::event::emit<SwappedFromVUsdEvent>(v0);
    }

    public(friend) fun swapped_to_vusd_event<T0>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = SwappedToVUsdEvent{
            token       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount      : arg0,
            vusd_amount : arg1,
            fee         : arg2,
        };
        0x2::event::emit<SwappedToVUsdEvent>(v0);
    }

    public(friend) fun tokens_received_event<T0>(arg0: u64, arg1: u64, arg2: address, arg3: u256, arg4: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::MessengerProtocol, arg5: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) {
        let v0 = TokensReceivedEvent{
            token            : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount           : arg0,
            extra_gas_amount : arg1,
            recipient        : arg2,
            nonce            : arg3,
            messenger        : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::id(&arg4),
            message          : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::to_hex(&arg5),
        };
        0x2::event::emit<TokensReceivedEvent>(v0);
    }

    public(friend) fun tokens_sent_event<T0>(arg0: u64, arg1: address, arg2: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg3: u8, arg4: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg5: u256, arg6: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::MessengerProtocol) {
        let v0 = TokensSentEvent{
            token                : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            vusd_amount          : arg0,
            sender               : arg1,
            recipient            : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_ascii_hex(&arg2),
            destination_chain_id : arg3,
            receive_token        : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_ascii_hex(&arg4),
            nonce                : arg5,
            messenger            : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::id(&arg6),
        };
        0x2::event::emit<TokensSentEvent>(v0);
    }

    public(friend) fun withdraw_event<T0>(arg0: u64, arg1: u64) {
        let v0 = WithdrawEvent{
            token     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount    : arg0,
            lp_amount : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

