module 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::events {
    struct TokensSentEvent has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
        admin_fee: u64,
        sender: address,
        recipient: 0x1::ascii::String,
        recipient_wallet_address: 0x1::ascii::String,
        destination_chain_id: u8,
        nonce: u64,
    }

    struct TokensReceivedEvent has copy, drop {
        token: 0x1::ascii::String,
        message: 0x1::ascii::String,
        recipient: address,
        extra_gas_value: u64,
    }

    struct RecipientReplaced has copy, drop {
        token: 0x1::ascii::String,
        sender: address,
        nonce: u64,
        new_recipitne: 0x1::ascii::String,
    }

    struct ReceiveFeeEvent has copy, drop {
        user_pay_sui: u64,
        user_pay_stable: u64,
        total_pay_sui: u64,
        total_fee_sui: u64,
    }

    public(friend) fun receive_fee_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ReceiveFeeEvent{
            user_pay_sui    : arg0,
            user_pay_stable : arg1,
            total_pay_sui   : arg2,
            total_fee_sui   : arg3,
        };
        0x2::event::emit<ReceiveFeeEvent>(v0);
    }

    public(friend) fun recipient_replaced<T0>(arg0: address, arg1: u64, arg2: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        let v0 = RecipientReplaced{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sender        : arg0,
            nonce         : arg1,
            new_recipitne : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_ascii_hex(&arg2),
        };
        0x2::event::emit<RecipientReplaced>(v0);
    }

    public(friend) fun tokens_received_event<T0>(arg0: address, arg1: vector<u8>, arg2: u64) {
        let v0 = TokensReceivedEvent{
            token           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            message         : 0x1::ascii::string(0x2::hex::encode(arg1)),
            recipient       : arg0,
            extra_gas_value : arg2,
        };
        0x2::event::emit<TokensReceivedEvent>(v0);
    }

    public(friend) fun tokens_sent_event<T0>(arg0: u64, arg1: u64, arg2: address, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg4: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg5: u8, arg6: u64) {
        let v0 = TokensSentEvent{
            token                    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount                   : arg0,
            admin_fee                : arg1,
            sender                   : arg2,
            recipient                : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_ascii_hex(&arg3),
            recipient_wallet_address : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_ascii_hex(&arg4),
            destination_chain_id     : arg5,
            nonce                    : arg6,
        };
        0x2::event::emit<TokensSentEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

