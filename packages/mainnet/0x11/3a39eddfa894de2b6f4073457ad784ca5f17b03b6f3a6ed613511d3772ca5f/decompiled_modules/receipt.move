module 0x113a39eddfa894de2b6f4073457ad784ca5f17b03b6f3a6ed613511d3772ca5f::receipt {
    struct SproutReceipt has copy, drop {
        user: address,
        summary: 0x1::string::String,
        risk: 0x1::string::String,
        actions: vector<0x1::string::String>,
        nonce: u64,
        agent_sig: vector<u8>,
    }

    struct SproutPayReceipt has copy, drop {
        payer: address,
        paid_to: address,
        title: 0x1::string::String,
        requested_token: 0x1::string::String,
        requested_amount: u64,
        paid_token: 0x1::string::String,
        paid_amount: u64,
        actions: vector<0x1::string::String>,
        nonce: u64,
        agent_sig: vector<u8>,
    }

    struct ChatMsg has copy, drop {
        user: address,
        summary: 0x1::string::String,
        risk: 0x1::string::String,
        actions: vector<0x1::string::String>,
        nonce: u64,
    }

    struct PayMsg has copy, drop {
        payer: address,
        paid_to: address,
        title: 0x1::string::String,
        requested_token: 0x1::string::String,
        requested_amount: u64,
        paid_token: 0x1::string::String,
        paid_amount: u64,
        actions: vector<0x1::string::String>,
        nonce: u64,
    }

    public fun emit_chat_receipt(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: u64, arg5: vector<u8>) {
        let v0 = ChatMsg{
            user    : arg0,
            summary : arg1,
            risk    : arg2,
            actions : arg3,
            nonce   : arg4,
        };
        let v1 = 0x1::bcs::to_bytes<ChatMsg>(&v0);
        let v2 = x"4ea59a72230ebf9ba7ef06a7b908907b1947fdb54230517fe167fdd6ab21c2cd";
        assert!(0x2::ed25519::ed25519_verify(&arg5, &v2, &v1), 0);
        let v3 = SproutReceipt{
            user      : arg0,
            summary   : arg1,
            risk      : arg2,
            actions   : arg3,
            nonce     : arg4,
            agent_sig : arg5,
        };
        0x2::event::emit<SproutReceipt>(v3);
    }

    public fun emit_pay_receipt(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: vector<0x1::string::String>, arg8: u64, arg9: vector<u8>) {
        let v0 = PayMsg{
            payer            : arg0,
            paid_to          : arg1,
            title            : arg2,
            requested_token  : arg3,
            requested_amount : arg4,
            paid_token       : arg5,
            paid_amount      : arg6,
            actions          : arg7,
            nonce            : arg8,
        };
        let v1 = 0x1::bcs::to_bytes<PayMsg>(&v0);
        let v2 = x"4ea59a72230ebf9ba7ef06a7b908907b1947fdb54230517fe167fdd6ab21c2cd";
        assert!(0x2::ed25519::ed25519_verify(&arg9, &v2, &v1), 0);
        let v3 = SproutPayReceipt{
            payer            : arg0,
            paid_to          : arg1,
            title            : arg2,
            requested_token  : arg3,
            requested_amount : arg4,
            paid_token       : arg5,
            paid_amount      : arg6,
            actions          : arg7,
            nonce            : arg8,
            agent_sig        : arg9,
        };
        0x2::event::emit<SproutPayReceipt>(v3);
    }

    // decompiled from Move bytecode v7
}

