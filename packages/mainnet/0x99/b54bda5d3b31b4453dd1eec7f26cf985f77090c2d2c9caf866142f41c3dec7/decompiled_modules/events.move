module 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::events {
    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        sender: address,
        coin_type: vector<u8>,
        amount: u64,
        protocol_fee: u64,
        rate: u64,
        institution_code: vector<u8>,
        message_hash: 0x1::string::String,
    }

    struct OrderSettled has copy, drop {
        split_order_id: vector<u8>,
        order_id: 0x2::object::ID,
        liquidity_provider: address,
        settle_percent: u64,
        amount_released: u64,
    }

    struct OrderRefunded has copy, drop {
        fee: u64,
        order_id: 0x2::object::ID,
        amount_refunded: u64,
    }

    struct SenderFeeTransferred has copy, drop {
        sender_fee_recipient: address,
        amount: u64,
    }

    struct CardDebited has copy, drop {
        cap_id: 0x2::object::ID,
        owner: address,
        merchant_recipient: address,
        amount_subunit: u64,
        fiat_reference: vector<u8>,
        timestamp_ms: u64,
        coin_type: vector<u8>,
    }

    public(friend) fun emit_card_debited(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) {
        let v0 = CardDebited{
            cap_id             : arg0,
            owner              : arg1,
            merchant_recipient : arg2,
            amount_subunit     : arg3,
            fiat_reference     : arg4,
            timestamp_ms       : arg5,
            coin_type          : arg6,
        };
        0x2::event::emit<CardDebited>(v0);
    }

    public(friend) fun emit_order_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x1::string::String) {
        let v0 = OrderCreated{
            order_id         : arg0,
            sender           : arg1,
            coin_type        : arg2,
            amount           : arg3,
            protocol_fee     : arg4,
            rate             : arg5,
            institution_code : arg6,
            message_hash     : arg7,
        };
        0x2::event::emit<OrderCreated>(v0);
    }

    public(friend) fun emit_order_refunded(arg0: u64, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = OrderRefunded{
            fee             : arg0,
            order_id        : arg1,
            amount_refunded : arg2,
        };
        0x2::event::emit<OrderRefunded>(v0);
    }

    public(friend) fun emit_order_settled(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = OrderSettled{
            split_order_id     : arg0,
            order_id           : arg1,
            liquidity_provider : arg2,
            settle_percent     : arg3,
            amount_released    : arg4,
        };
        0x2::event::emit<OrderSettled>(v0);
    }

    public(friend) fun emit_sender_fee_transferred(arg0: address, arg1: u64) {
        let v0 = SenderFeeTransferred{
            sender_fee_recipient : arg0,
            amount               : arg1,
        };
        0x2::event::emit<SenderFeeTransferred>(v0);
    }

    // decompiled from Move bytecode v7
}

