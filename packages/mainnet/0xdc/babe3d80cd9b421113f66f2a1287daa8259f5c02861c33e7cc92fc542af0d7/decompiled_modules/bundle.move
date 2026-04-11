module 0xdcbabe3d80cd9b421113f66f2a1287daa8259f5c02861c33e7cc92fc542af0d7::bundle {
    struct OrderSlot has copy, drop, store {
        venue: u8,
        pool_id: address,
        order_id: u128,
        recipient: address,
        status: u8,
    }

    struct OrderBundle has key {
        id: 0x2::object::UID,
        tag: u32,
        creator: address,
        created_ms: u64,
        settle_deadline_ms: u64,
        orders: vector<OrderSlot>,
        target_count: u8,
        filled_count: u8,
        status: u8,
    }

    struct OrderBundleCap has store, key {
        id: 0x2::object::UID,
        bundle_id: address,
    }

    struct BundleCreated has copy, drop {
        bundle_id: address,
        tag: u32,
        creator: address,
        target_count: u8,
        created_ms: u64,
        settle_deadline_ms: u64,
    }

    struct OrderRecorded has copy, drop {
        bundle_id: address,
        slot_idx: u8,
        order_id: u128,
    }

    struct SlotFilled has copy, drop {
        bundle_id: address,
        slot_idx: u8,
        filled_count: u8,
        target_count: u8,
    }

    struct BundleSettled has copy, drop {
        bundle_id: address,
        tag: u32,
        filled_count: u8,
        settled_ms: u64,
    }

    struct BundleRefunded has copy, drop {
        bundle_id: address,
        tag: u32,
        filled_count: u8,
        refunded_ms: u64,
    }

    struct SlotCancelled has copy, drop {
        bundle_id: address,
        slot_idx: u8,
    }

    public fun cancel_slot(arg0: &mut OrderBundle, arg1: &OrderBundleCap, arg2: u8) {
        assert!(arg1.bundle_id == 0x2::object::uid_to_address(&arg0.id), 5);
        assert!(arg0.status == 0, 0);
        let v0 = (arg2 as u64);
        assert!(v0 < 0x1::vector::length<OrderSlot>(&arg0.orders), 3);
        let v1 = 0x1::vector::borrow_mut<OrderSlot>(&mut arg0.orders, v0);
        assert!(v1.status != 2 && v1.status != 3, 3);
        v1.status = 3;
        if (arg0.target_count > 0) {
            arg0.target_count = arg0.target_count - 1;
        };
        let v2 = SlotCancelled{
            bundle_id : 0x2::object::uid_to_address(&arg0.id),
            slot_idx  : arg2,
        };
        0x2::event::emit<SlotCancelled>(v2);
    }

    public fun create_bundle(arg0: u32, arg1: u8, arg2: u64, arg3: vector<OrderSlot>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : OrderBundleCap {
        let v0 = 0x1::vector::length<OrderSlot>(&arg3);
        assert!(v0 > 0, 4);
        assert!(v0 <= (16 as u64), 4);
        assert!(arg1 > 0, 4);
        assert!((arg1 as u64) <= v0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg2 > v1, 6);
        let v2 = OrderBundle{
            id                 : 0x2::object::new(arg5),
            tag                : arg0,
            creator            : 0x2::tx_context::sender(arg5),
            created_ms         : v1,
            settle_deadline_ms : arg2,
            orders             : arg3,
            target_count       : arg1,
            filled_count       : 0,
            status             : 0,
        };
        let v3 = 0x2::object::uid_to_address(&v2.id);
        let v4 = BundleCreated{
            bundle_id          : v3,
            tag                : arg0,
            creator            : v2.creator,
            target_count       : arg1,
            created_ms         : v1,
            settle_deadline_ms : arg2,
        };
        0x2::event::emit<BundleCreated>(v4);
        let v5 = OrderBundleCap{
            id        : 0x2::object::new(arg5),
            bundle_id : v3,
        };
        0x2::transfer::share_object<OrderBundle>(v2);
        v5
    }

    public fun created_ms(arg0: &OrderBundle) : u64 {
        arg0.created_ms
    }

    public fun creator(arg0: &OrderBundle) : address {
        arg0.creator
    }

    public fun filled_count(arg0: &OrderBundle) : u8 {
        arg0.filled_count
    }

    public fun force_refund_bundle(arg0: OrderBundle, arg1: OrderBundleCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        assert!(arg1.bundle_id == v0, 5);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.settle_deadline_ms, 2);
        let OrderBundle {
            id                 : v1,
            tag                : v2,
            creator            : _,
            created_ms         : _,
            settle_deadline_ms : _,
            orders             : _,
            target_count       : _,
            filled_count       : v8,
            status             : _,
        } = arg0;
        0x2::object::delete(v1);
        let OrderBundleCap {
            id        : v10,
            bundle_id : _,
        } = arg1;
        0x2::object::delete(v10);
        let v12 = BundleRefunded{
            bundle_id    : v0,
            tag          : v2,
            filled_count : v8,
            refunded_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BundleRefunded>(v12);
    }

    public fun mark_slot_filled(arg0: &mut OrderBundle, arg1: u8) {
        assert!(arg0.status == 0, 0);
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<OrderSlot>(&arg0.orders), 3);
        let v1 = 0x1::vector::borrow_mut<OrderSlot>(&mut arg0.orders, v0);
        assert!(v1.status == 1, 3);
        v1.status = 2;
        arg0.filled_count = arg0.filled_count + 1;
        let v2 = SlotFilled{
            bundle_id    : 0x2::object::uid_to_address(&arg0.id),
            slot_idx     : arg1,
            filled_count : arg0.filled_count,
            target_count : arg0.target_count,
        };
        0x2::event::emit<SlotFilled>(v2);
        if (arg0.filled_count >= arg0.target_count) {
            arg0.status = 1;
        };
    }

    public fun new_slot(arg0: u8, arg1: address, arg2: address) : OrderSlot {
        OrderSlot{
            venue     : arg0,
            pool_id   : arg1,
            order_id  : 0,
            recipient : arg2,
            status    : 0,
        }
    }

    public fun orders(arg0: &OrderBundle) : &vector<OrderSlot> {
        &arg0.orders
    }

    public fun record_order_placed(arg0: &mut OrderBundle, arg1: u8, arg2: u128) {
        assert!(arg0.status == 0, 0);
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<OrderSlot>(&arg0.orders), 3);
        let v1 = 0x1::vector::borrow_mut<OrderSlot>(&mut arg0.orders, v0);
        assert!(v1.status == 0, 3);
        v1.order_id = arg2;
        v1.status = 1;
        let v2 = OrderRecorded{
            bundle_id : 0x2::object::uid_to_address(&arg0.id),
            slot_idx  : arg1,
            order_id  : arg2,
        };
        0x2::event::emit<OrderRecorded>(v2);
    }

    public fun settle_bundle(arg0: OrderBundle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 1);
        let OrderBundle {
            id                 : v0,
            tag                : v1,
            creator            : _,
            created_ms         : _,
            settle_deadline_ms : _,
            orders             : _,
            target_count       : _,
            filled_count       : v7,
            status             : _,
        } = arg0;
        let v9 = v0;
        0x2::object::delete(v9);
        let v10 = BundleSettled{
            bundle_id    : 0x2::object::uid_to_address(&v9),
            tag          : v1,
            filled_count : v7,
            settled_ms   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<BundleSettled>(v10);
    }

    public fun settle_deadline_ms(arg0: &OrderBundle) : u64 {
        arg0.settle_deadline_ms
    }

    public fun slot_cancelled() : u8 {
        3
    }

    public fun slot_filled() : u8 {
        2
    }

    public fun slot_order_id(arg0: &OrderSlot) : u128 {
        arg0.order_id
    }

    public fun slot_pending() : u8 {
        0
    }

    public fun slot_placed() : u8 {
        1
    }

    public fun slot_pool_id(arg0: &OrderSlot) : address {
        arg0.pool_id
    }

    public fun slot_recipient(arg0: &OrderSlot) : address {
        arg0.recipient
    }

    public fun slot_status(arg0: &OrderSlot) : u8 {
        arg0.status
    }

    public fun slot_venue(arg0: &OrderSlot) : u8 {
        arg0.venue
    }

    public fun status(arg0: &OrderBundle) : u8 {
        arg0.status
    }

    public fun status_complete() : u8 {
        1
    }

    public fun status_open() : u8 {
        0
    }

    public fun status_refunded() : u8 {
        3
    }

    public fun status_settled() : u8 {
        2
    }

    public fun tag(arg0: &OrderBundle) : u32 {
        arg0.tag
    }

    public fun target_count(arg0: &OrderBundle) : u8 {
        arg0.target_count
    }

    // decompiled from Move bytecode v7
}

