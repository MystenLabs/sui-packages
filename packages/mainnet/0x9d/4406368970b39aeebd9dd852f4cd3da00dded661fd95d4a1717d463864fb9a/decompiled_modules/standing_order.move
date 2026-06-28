module 0xf6190d582f88dc3301e060820ebe81b656d96f6bf71c0f6f2e0cf23cbde0339c::standing_order {
    struct AutomationRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        worker_addresses: vector<address>,
        paused: bool,
        orders_total: u64,
    }

    struct AutomationAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StandingOrder<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        recipient: address,
        pot: 0x2::balance::Balance<T0>,
        amount_per: u64,
        interval_ms: u64,
        next_due_ms: u64,
        released_total: u64,
        releases_done: u64,
        paused: bool,
        cancelled: bool,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        recipient: address,
        amount_per: u64,
        interval_ms: u64,
        first_due_ms: u64,
        funded: u64,
    }

    struct OrderExecuted has copy, drop {
        order_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        release_index: u64,
        ts_ms: u64,
    }

    struct OrderToppedUp has copy, drop {
        order_id: 0x2::object::ID,
        added: u64,
        pot: u64,
    }

    struct OrderPaused has copy, drop {
        order_id: 0x2::object::ID,
    }

    struct OrderResumed has copy, drop {
        order_id: 0x2::object::ID,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        refunded: u64,
        released_total: u64,
    }

    struct WorkerAdded has copy, drop {
        worker: address,
    }

    struct WorkerRemoved has copy, drop {
        worker: address,
    }

    public fun add_worker(arg0: &mut AutomationRegistry, arg1: &AutomationAdminCap, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg0.worker_addresses, &arg2), 409);
        0x1::vector::push_back<address>(&mut arg0.worker_addresses, arg2);
        let v0 = WorkerAdded{worker: arg2};
        0x2::event::emit<WorkerAdded>(v0);
    }

    public fun amount_per<T0>(arg0: &StandingOrder<T0>) : u64 {
        arg0.amount_per
    }

    public fun cancel<T0>(arg0: &mut StandingOrder<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 402);
        assert!(!arg0.cancelled, 404);
        arg0.cancelled = true;
        let v0 = OrderCancelled{
            order_id       : 0x2::object::id<StandingOrder<T0>>(arg0),
            refunded       : 0x2::balance::value<T0>(&arg0.pot),
            released_total : arg0.released_total,
        };
        0x2::event::emit<OrderCancelled>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pot), arg1)
    }

    public fun create<T0>(arg0: &mut AutomationRegistry, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg3 > 0, 408);
        assert!(arg4 > 0, 405);
        assert!(arg2 != 0x2::tx_context::sender(arg6), 411);
        assert!(0x2::balance::value<T0>(&arg1) >= arg3, 407);
        let v0 = StandingOrder<T0>{
            id             : 0x2::object::new(arg6),
            owner          : 0x2::tx_context::sender(arg6),
            recipient      : arg2,
            pot            : arg1,
            amount_per     : arg3,
            interval_ms    : arg4,
            next_due_ms    : arg5,
            released_total : 0,
            releases_done  : 0,
            paused         : false,
            cancelled      : false,
        };
        let v1 = 0x2::object::id<StandingOrder<T0>>(&v0);
        arg0.orders_total = arg0.orders_total + 1;
        let v2 = OrderCreated{
            order_id     : v1,
            owner        : v0.owner,
            recipient    : arg2,
            amount_per   : arg3,
            interval_ms  : arg4,
            first_due_ms : arg5,
            funded       : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<OrderCreated>(v2);
        0x2::transfer::share_object<StandingOrder<T0>>(v0);
        v1
    }

    public fun execute_due<T0>(arg0: &AutomationRegistry, arg1: &mut StandingOrder<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 401);
        assert!(!arg1.cancelled, 404);
        assert!(!arg1.paused, 403);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.next_due_ms, 406);
        assert!(0x2::balance::value<T0>(&arg1.pot) >= arg1.amount_per, 407);
        let v0 = arg1.amount_per;
        arg1.released_total = arg1.released_total + v0;
        arg1.releases_done = arg1.releases_done + 1;
        arg1.next_due_ms = arg1.next_due_ms + arg1.interval_ms;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pot, v0), arg3), arg1.recipient);
        let v1 = OrderExecuted{
            order_id      : 0x2::object::id<StandingOrder<T0>>(arg1),
            recipient     : arg1.recipient,
            amount        : v0,
            release_index : arg1.releases_done,
            ts_ms         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OrderExecuted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AutomationRegistry{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            worker_addresses : vector[],
            paused           : false,
            orders_total     : 0,
        };
        0x2::transfer::share_object<AutomationRegistry>(v0);
        let v1 = AutomationAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AutomationAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_cancelled<T0>(arg0: &StandingOrder<T0>) : bool {
        arg0.cancelled
    }

    public fun is_paused<T0>(arg0: &StandingOrder<T0>) : bool {
        arg0.paused
    }

    public fun next_due_ms<T0>(arg0: &StandingOrder<T0>) : u64 {
        arg0.next_due_ms
    }

    public fun owner<T0>(arg0: &StandingOrder<T0>) : address {
        arg0.owner
    }

    public fun pause<T0>(arg0: &mut StandingOrder<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 402);
        arg0.paused = true;
        let v0 = OrderPaused{order_id: 0x2::object::id<StandingOrder<T0>>(arg0)};
        0x2::event::emit<OrderPaused>(v0);
    }

    public fun pot_value<T0>(arg0: &StandingOrder<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    public fun recipient<T0>(arg0: &StandingOrder<T0>) : address {
        arg0.recipient
    }

    public fun releases_done<T0>(arg0: &StandingOrder<T0>) : u64 {
        arg0.releases_done
    }

    public fun remove_worker(arg0: &mut AutomationRegistry, arg1: &AutomationAdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.worker_addresses, &arg2);
        assert!(v0, 410);
        0x1::vector::remove<address>(&mut arg0.worker_addresses, v1);
        let v2 = WorkerRemoved{worker: arg2};
        0x2::event::emit<WorkerRemoved>(v2);
    }

    public fun resume<T0>(arg0: &mut StandingOrder<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 402);
        arg0.paused = false;
        let v0 = OrderResumed{order_id: 0x2::object::id<StandingOrder<T0>>(arg0)};
        0x2::event::emit<OrderResumed>(v0);
    }

    public fun set_paused(arg0: &mut AutomationRegistry, arg1: &AutomationAdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun top_up<T0>(arg0: &mut StandingOrder<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 402);
        assert!(!arg0.cancelled, 404);
        0x2::balance::join<T0>(&mut arg0.pot, arg1);
        let v0 = OrderToppedUp{
            order_id : 0x2::object::id<StandingOrder<T0>>(arg0),
            added    : 0x2::balance::value<T0>(&arg1),
            pot      : 0x2::balance::value<T0>(&arg0.pot),
        };
        0x2::event::emit<OrderToppedUp>(v0);
    }

    // decompiled from Move bytecode v7
}

