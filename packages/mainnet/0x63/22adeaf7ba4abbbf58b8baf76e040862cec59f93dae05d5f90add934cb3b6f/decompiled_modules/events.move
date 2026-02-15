module 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::events {
    struct OrderCreated has copy, drop {
        nonce: u64,
        sender: address,
        recipient: address,
        amount: u64,
        destination_domain: u32,
        created_at: u64,
    }

    struct OrderCancelled has copy, drop {
        nonce: u64,
        cancelled_by: address,
    }

    struct OrderSettled has copy, drop {
        nonce: u64,
    }

    public(friend) fun emit_order_cancelled(arg0: u64, arg1: address) {
        let v0 = OrderCancelled{
            nonce        : arg0,
            cancelled_by : arg1,
        };
        0x2::event::emit<OrderCancelled>(v0);
    }

    public(friend) fun emit_order_created(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: u32, arg5: u64) {
        let v0 = OrderCreated{
            nonce              : arg0,
            sender             : arg1,
            recipient          : arg2,
            amount             : arg3,
            destination_domain : arg4,
            created_at         : arg5,
        };
        0x2::event::emit<OrderCreated>(v0);
    }

    public(friend) fun emit_order_settled(arg0: u64) {
        let v0 = OrderSettled{nonce: arg0};
        0x2::event::emit<OrderSettled>(v0);
    }

    // decompiled from Move bytecode v6
}

