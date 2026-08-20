module 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events {
    struct ExecutorCreated has copy, drop {
        executor_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct QuoteUpdated has copy, drop {
        executor_id: 0x2::object::ID,
        price: u64,
        orders: vector<LimitOrder>,
    }

    struct LimitOrder has copy, drop {
        order_id: u128,
        price: u64,
        quantity: u64,
        is_bid: bool,
    }

    struct ExecutorPaused has copy, drop {
        executor_id: 0x2::object::ID,
    }

    struct ExecutorUnpaused has copy, drop {
        executor_id: 0x2::object::ID,
    }

    struct ExecutorConfigUpdated has copy, drop {
        executor_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        executor_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        executor_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun emit_deposited(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = Deposited{
            executor_id : arg0,
            coin_type   : arg1,
            amount      : arg2,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_executor_config_updated(arg0: 0x2::object::ID) {
        let v0 = ExecutorConfigUpdated{executor_id: arg0};
        0x2::event::emit<ExecutorConfigUpdated>(v0);
    }

    public(friend) fun emit_executor_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ExecutorCreated{
            executor_id  : arg0,
            admin_cap_id : arg1,
        };
        0x2::event::emit<ExecutorCreated>(v0);
    }

    public(friend) fun emit_executor_paused(arg0: 0x2::object::ID) {
        let v0 = ExecutorPaused{executor_id: arg0};
        0x2::event::emit<ExecutorPaused>(v0);
    }

    public(friend) fun emit_executor_unpaused(arg0: 0x2::object::ID) {
        let v0 = ExecutorUnpaused{executor_id: arg0};
        0x2::event::emit<ExecutorUnpaused>(v0);
    }

    public(friend) fun emit_quote_updated(arg0: 0x2::object::ID, arg1: u64, arg2: vector<LimitOrder>) {
        let v0 = QuoteUpdated{
            executor_id : arg0,
            price       : arg1,
            orders      : arg2,
        };
        0x2::event::emit<QuoteUpdated>(v0);
    }

    public(friend) fun emit_withdrawn(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = Withdrawn{
            executor_id : arg0,
            coin_type   : arg1,
            amount      : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    public(friend) fun new_order(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : LimitOrder {
        LimitOrder{
            order_id : arg0,
            price    : arg1,
            quantity : arg2,
            is_bid   : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

