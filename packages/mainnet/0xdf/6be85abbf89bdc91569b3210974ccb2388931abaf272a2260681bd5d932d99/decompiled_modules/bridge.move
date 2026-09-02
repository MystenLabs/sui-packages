module 0xdf6be85abbf89bdc91569b3210974ccb2388931abaf272a2260681bd5d932d99::bridge {
    struct BridgeMessageKey has copy, drop, store {
        source_chain: u8,
        message_type: u8,
        bridge_seq_num: u64,
    }

    struct TokenTransferClaimed has copy, drop {
        message_key: BridgeMessageKey,
    }

    struct TokenTransferApproved has copy, drop {
        message_key: BridgeMessageKey,
    }

    public entry fun emit_token_transfer_approved(arg0: u8, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeMessageKey{
            source_chain   : arg0,
            message_type   : arg1,
            bridge_seq_num : arg2,
        };
        let v1 = TokenTransferApproved{message_key: v0};
        0x2::event::emit<TokenTransferApproved>(v1);
    }

    public entry fun emit_token_transfer_claimed(arg0: u8, arg1: u8, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeMessageKey{
            source_chain   : arg0,
            message_type   : arg1,
            bridge_seq_num : arg2,
        };
        let v1 = TokenTransferClaimed{message_key: v0};
        0x2::event::emit<TokenTransferClaimed>(v1);
    }

    // decompiled from Move bytecode v7
}

