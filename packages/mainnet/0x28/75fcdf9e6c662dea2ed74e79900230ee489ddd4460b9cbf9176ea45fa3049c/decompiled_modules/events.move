module 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::events {
    struct BuyOrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        recipient: address,
        quote_type: vector<u8>,
        bro_type: vector<u8>,
        locked: u64,
        min_out: u64,
        created_at_ms: u64,
        grace_until_ms: u64,
        expiry_ms: u64,
    }

    struct BuyOrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        recipient: address,
        out_amount: u64,
        quote_taken: u64,
        broker: address,
    }

    struct BuyOrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
    }

    struct BuyOrderRejected has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        broker: address,
    }

    struct SellOrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        recipient: address,
        bro_type: vector<u8>,
        quote_type: vector<u8>,
        locked: u64,
        min_out: u64,
        created_at_ms: u64,
        grace_until_ms: u64,
        expiry_ms: u64,
    }

    struct SellOrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        recipient: address,
        bro_burned: u64,
        quote_paid: u64,
        broker: address,
    }

    struct SellOrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
    }

    struct SellOrderRejected has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        broker: address,
    }

    public(friend) fun buy_order_cancelled(arg0: 0x2::object::ID, arg1: address) {
        let v0 = BuyOrderCancelled{
            order_id : arg0,
            owner    : arg1,
        };
        0x2::event::emit<BuyOrderCancelled>(v0);
    }

    public(friend) fun buy_order_created(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = BuyOrderCreated{
            order_id       : arg0,
            owner          : arg1,
            recipient      : arg2,
            quote_type     : arg3,
            bro_type       : arg4,
            locked         : arg5,
            min_out        : arg6,
            created_at_ms  : arg7,
            grace_until_ms : arg8,
            expiry_ms      : arg9,
        };
        0x2::event::emit<BuyOrderCreated>(v0);
    }

    public(friend) fun buy_order_filled(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: address) {
        let v0 = BuyOrderFilled{
            order_id    : arg0,
            recipient   : arg1,
            out_amount  : arg2,
            quote_taken : arg3,
            broker      : arg4,
        };
        0x2::event::emit<BuyOrderFilled>(v0);
    }

    public(friend) fun buy_order_rejected(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = BuyOrderRejected{
            order_id : arg0,
            owner    : arg1,
            broker   : arg2,
        };
        0x2::event::emit<BuyOrderRejected>(v0);
    }

    public(friend) fun sell_order_cancelled(arg0: 0x2::object::ID, arg1: address) {
        let v0 = SellOrderCancelled{
            order_id : arg0,
            owner    : arg1,
        };
        0x2::event::emit<SellOrderCancelled>(v0);
    }

    public(friend) fun sell_order_created(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = SellOrderCreated{
            order_id       : arg0,
            owner          : arg1,
            recipient      : arg2,
            bro_type       : arg3,
            quote_type     : arg4,
            locked         : arg5,
            min_out        : arg6,
            created_at_ms  : arg7,
            grace_until_ms : arg8,
            expiry_ms      : arg9,
        };
        0x2::event::emit<SellOrderCreated>(v0);
    }

    public(friend) fun sell_order_filled(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: address) {
        let v0 = SellOrderFilled{
            order_id   : arg0,
            recipient  : arg1,
            bro_burned : arg2,
            quote_paid : arg3,
            broker     : arg4,
        };
        0x2::event::emit<SellOrderFilled>(v0);
    }

    public(friend) fun sell_order_rejected(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = SellOrderRejected{
            order_id : arg0,
            owner    : arg1,
            broker   : arg2,
        };
        0x2::event::emit<SellOrderRejected>(v0);
    }

    // decompiled from Move bytecode v7
}

