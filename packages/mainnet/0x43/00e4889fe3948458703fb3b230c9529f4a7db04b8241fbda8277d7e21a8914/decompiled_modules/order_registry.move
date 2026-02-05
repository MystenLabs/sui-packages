module 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry {
    struct StopOrder has store, key {
        id: 0x2::object::UID,
        owner: address,
        base_amount: u64,
        trigger_price: u64,
        direction: u8,
        status: u8,
        created_at: u64,
    }

    struct OrderRegistry has key {
        id: 0x2::object::UID,
        total_orders: u64,
        active_orders: u64,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        base_amount: u64,
        trigger_price: u64,
        direction: u8,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
    }

    struct OrderExecuted has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        execution_price: u64,
    }

    public fun cancel_order(arg0: &mut OrderRegistry, arg1: &mut StopOrder, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg1.status == 0, 1);
        arg1.status = 2;
        arg0.active_orders = arg0.active_orders - 1;
        let v0 = OrderCancelled{
            order_id : 0x2::object::uid_to_inner(&arg1.id),
            owner    : arg1.owner,
        };
        0x2::event::emit<OrderCancelled>(v0);
    }

    fun create_order_internal(arg0: &mut OrderRegistry, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : StopOrder {
        assert!(arg2 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = StopOrder{
            id            : 0x2::object::new(arg5),
            owner         : v0,
            base_amount   : arg1,
            trigger_price : arg2,
            direction     : arg3,
            status        : 0,
            created_at    : 0x2::clock::timestamp_ms(arg4),
        };
        arg0.total_orders = arg0.total_orders + 1;
        arg0.active_orders = arg0.active_orders + 1;
        let v2 = OrderCreated{
            order_id      : 0x2::object::uid_to_inner(&v1.id),
            owner         : v0,
            base_amount   : arg1,
            trigger_price : arg2,
            direction     : arg3,
        };
        0x2::event::emit<OrderCreated>(v2);
        v1
    }

    public fun create_stop_loss(arg0: &mut OrderRegistry, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StopOrder {
        create_order_internal(arg0, arg1, arg2, 0, arg3, arg4)
    }

    public fun create_take_profit(arg0: &mut OrderRegistry, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StopOrder {
        create_order_internal(arg0, arg1, arg2, 1, arg3, arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderRegistry{
            id            : 0x2::object::new(arg0),
            total_orders  : 0,
            active_orders : 0,
        };
        0x2::transfer::share_object<OrderRegistry>(v0);
    }

    public fun is_pending(arg0: &StopOrder) : bool {
        arg0.status == 0
    }

    public fun mark_executed(arg0: &mut OrderRegistry, arg1: &mut StopOrder, arg2: u64) {
        assert!(arg1.status == 0, 1);
        arg1.status = 1;
        arg0.active_orders = arg0.active_orders - 1;
        let v0 = OrderExecuted{
            order_id        : 0x2::object::uid_to_inner(&arg1.id),
            owner           : arg1.owner,
            execution_price : arg2,
        };
        0x2::event::emit<OrderExecuted>(v0);
    }

    public fun order_amount(arg0: &StopOrder) : u64 {
        arg0.base_amount
    }

    public fun order_direction(arg0: &StopOrder) : u8 {
        arg0.direction
    }

    public fun order_id(arg0: &StopOrder) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun order_owner(arg0: &StopOrder) : address {
        arg0.owner
    }

    public fun order_status(arg0: &StopOrder) : u8 {
        arg0.status
    }

    public fun order_trigger_price(arg0: &StopOrder) : u64 {
        arg0.trigger_price
    }

    public fun registry_stats(arg0: &OrderRegistry) : (u64, u64) {
        (arg0.total_orders, arg0.active_orders)
    }

    public fun share_order(arg0: StopOrder) {
        0x2::transfer::share_object<StopOrder>(arg0);
    }

    // decompiled from Move bytecode v6
}

