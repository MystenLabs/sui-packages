module 0xb6ed2640fd7cc65f7e758c672bf02da6ff4a6c00481eb817fb4bcc1c31704492::events {
    struct OrderCreated has copy, drop {
        order_hash: vector<u8>,
        order: 0xb6ed2640fd7cc65f7e758c672bf02da6ff4a6c00481eb817fb4bcc1c31704492::order::Order,
    }

    struct OrderRefunded has copy, drop {
        order_hash: vector<u8>,
    }

    struct OrderFilled has copy, drop {
        order_hash: vector<u8>,
        order: 0xb6ed2640fd7cc65f7e758c672bf02da6ff4a6c00481eb817fb4bcc1c31704492::order::Order,
    }

    struct SettlementForwarded has copy, drop {
        order_hash: vector<u8>,
    }

    struct OrderReleased has copy, drop {
        order_hash: vector<u8>,
    }

    struct FeeCollected has copy, drop {
        fee_collector: address,
        coin: 0x1::ascii::String,
        value: u64,
    }

    struct ReceivedReleaseBatch has copy, drop {
        message_id: 0x1::ascii::String,
        order_hashes: vector<vector<u8>>,
    }

    public(friend) fun fee_collected(arg0: address, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = FeeCollected{
            fee_collector : arg0,
            coin          : arg1,
            value         : arg2,
        };
        0x2::event::emit<FeeCollected>(v0);
    }

    public(friend) fun order_created(arg0: vector<u8>, arg1: 0xb6ed2640fd7cc65f7e758c672bf02da6ff4a6c00481eb817fb4bcc1c31704492::order::Order) {
        let v0 = OrderCreated{
            order_hash : arg0,
            order      : arg1,
        };
        0x2::event::emit<OrderCreated>(v0);
    }

    public(friend) fun order_filled(arg0: vector<u8>, arg1: 0xb6ed2640fd7cc65f7e758c672bf02da6ff4a6c00481eb817fb4bcc1c31704492::order::Order) {
        let v0 = OrderFilled{
            order_hash : arg0,
            order      : arg1,
        };
        0x2::event::emit<OrderFilled>(v0);
    }

    public(friend) fun order_refunded(arg0: vector<u8>) {
        let v0 = OrderRefunded{order_hash: arg0};
        0x2::event::emit<OrderRefunded>(v0);
    }

    public(friend) fun order_released(arg0: vector<u8>) {
        let v0 = OrderReleased{order_hash: arg0};
        0x2::event::emit<OrderReleased>(v0);
    }

    public(friend) fun received_release_batch(arg0: 0x1::ascii::String, arg1: vector<vector<u8>>) {
        let v0 = ReceivedReleaseBatch{
            message_id   : arg0,
            order_hashes : arg1,
        };
        0x2::event::emit<ReceivedReleaseBatch>(v0);
    }

    public(friend) fun settlement_forwarded(arg0: vector<u8>) {
        let v0 = SettlementForwarded{order_hash: arg0};
        0x2::event::emit<SettlementForwarded>(v0);
    }

    // decompiled from Move bytecode v6
}

