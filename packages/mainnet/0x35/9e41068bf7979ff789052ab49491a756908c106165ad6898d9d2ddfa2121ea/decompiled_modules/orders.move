module 0x359e41068bf7979ff789052ab49491a756908c106165ad6898d9d2ddfa2121ea::orders {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_recipient: address,
        fee_bps: u64,
        paused: bool,
    }

    struct Order<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        kind: u8,
        funds: 0x2::balance::Balance<T0>,
        leg_min: u64,
        leg_max: u64,
        min_price: u128,
        trigger_price: u128,
        trail_bps: u64,
        interval_ms: u64,
        next_ms: u64,
        expires_ms: u64,
        executions: u64,
        max_executions: u64,
        total_in: u64,
        total_out: u64,
    }

    struct Ticket {
        order_id: 0x2::object::ID,
        amount_in: u64,
        min_out: u64,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        kind: u8,
        in_type: 0x1::string::String,
        out_type: 0x1::string::String,
        amount: u64,
        leg_min: u64,
        leg_max: u64,
        min_price: u128,
        trigger_price: u128,
        trail_bps: u64,
        interval_ms: u64,
        start_ms: u64,
        expires_ms: u64,
        max_executions: u64,
    }

    struct OrderExecuted has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        executions: u64,
        remaining: u64,
        timestamp_ms: u64,
    }

    struct OrderClosed has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        refunded: u64,
        cancelled: bool,
    }

    struct FloorRaised has copy, drop {
        order_id: 0x2::object::ID,
        min_price: u128,
        trigger_price: u128,
    }

    public fun begin<T0, T1>(arg0: &KeeperCap, arg1: &Config, arg2: &mut Order<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket) {
        assert!(arg1.version == 1, 0);
        assert!(!arg1.paused, 1);
        assert!(!is_finished<T0, T1>(arg2), 10);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg2.next_ms, 3);
        assert!(arg2.expires_ms == 0 || v0 < arg2.expires_ms, 4);
        let v1 = 0x2::balance::value<T0>(&arg2.funds);
        if (arg2.kind == 0) {
            let v2 = if (v1 < arg2.leg_min) {
                v1
            } else {
                arg2.leg_min
            };
            let v3 = if (v1 < arg2.leg_max) {
                v1
            } else {
                arg2.leg_max
            };
            assert!(arg3 >= v2 && arg3 <= v3, 5);
        } else {
            let v4 = if (v1 < arg2.leg_max) {
                v1
            } else {
                arg2.leg_max
            };
            assert!(arg3 == v4, 5);
        };
        let v5 = Ticket{
            order_id  : 0x2::object::id<Order<T0, T1>>(arg2),
            amount_in : arg3,
            min_out   : (((arg3 as u128) * arg2.min_price / 1000000000000000000) as u64),
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.funds, arg3), arg5), v5)
    }

    public fun cancel<T0, T1>(arg0: Order<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
        close<T0, T1>(arg0, true, arg1);
    }

    fun close<T0, T1>(arg0: Order<T0, T1>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let Order {
            id             : v0,
            owner          : v1,
            kind           : _,
            funds          : v3,
            leg_min        : _,
            leg_max        : _,
            min_price      : _,
            trigger_price  : _,
            trail_bps      : _,
            interval_ms    : _,
            next_ms        : _,
            expires_ms     : _,
            executions     : _,
            max_executions : _,
            total_in       : _,
            total_out      : _,
        } = arg0;
        let v16 = v3;
        let v17 = v0;
        let v18 = 0x2::balance::value<T0>(&v16);
        if (v18 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg2), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v16);
        };
        let v19 = OrderClosed{
            order_id  : 0x2::object::uid_to_inner(&v17),
            owner     : v1,
            refunded  : v18,
            cancelled : arg1,
        };
        0x2::event::emit<OrderClosed>(v19);
        0x2::object::delete(v17);
    }

    public fun close_finished<T0, T1>(arg0: Order<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_finished<T0, T1>(&arg0), 8);
        close<T0, T1>(arg0, false, arg1);
    }

    public fun create<T0, T1>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0 && arg2 <= 3, 8);
        assert!(arg3 > 0 && arg3 <= arg4, 8);
        assert!(arg5 > 0, 8);
        assert!(arg7 < 10000, 8);
        if (arg2 == 0) {
            assert!(arg8 > 0, 8);
        };
        if (arg10 > 0) {
            assert!(arg10 > 0x2::clock::timestamp_ms(arg12), 8);
        };
        let v1 = Order<T0, T1>{
            id             : 0x2::object::new(arg13),
            owner          : 0x2::tx_context::sender(arg13),
            kind           : arg2,
            funds          : 0x2::coin::into_balance<T0>(arg1),
            leg_min        : arg3,
            leg_max        : arg4,
            min_price      : arg5,
            trigger_price  : arg6,
            trail_bps      : arg7,
            interval_ms    : arg8,
            next_ms        : 0x1::u64::max(arg9, 0x2::clock::timestamp_ms(arg12)),
            expires_ms     : arg10,
            executions     : 0,
            max_executions : arg11,
            total_in       : 0,
            total_out      : 0,
        };
        let v2 = OrderCreated{
            order_id       : 0x2::object::id<Order<T0, T1>>(&v1),
            owner          : 0x2::tx_context::sender(arg13),
            kind           : arg2,
            in_type        : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            out_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())),
            amount         : v0,
            leg_min        : arg3,
            leg_max        : arg4,
            min_price      : arg5,
            trigger_price  : arg6,
            trail_bps      : arg7,
            interval_ms    : arg8,
            start_ms       : v1.next_ms,
            expires_ms     : arg10,
            max_executions : arg11,
        };
        0x2::event::emit<OrderCreated>(v2);
        0x2::transfer::share_object<Order<T0, T1>>(v1);
    }

    public fun executions<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.executions
    }

    public fun finish<T0, T1>(arg0: &Config, arg1: &mut Order<T0, T1>, arg2: Ticket, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            order_id  : v0,
            amount_in : v1,
            min_out   : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<Order<T0, T1>>(arg1), 7);
        let v3 = 0x2::coin::value<T1>(&arg3);
        assert!(v3 >= v2 && v3 > 0, 6);
        let v4 = (((v3 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v4, arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg1.owner);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        arg1.executions = arg1.executions + 1;
        arg1.total_in = arg1.total_in + v1;
        arg1.total_out = arg1.total_out + v3;
        arg1.next_ms = v5 + arg1.interval_ms;
        let v6 = OrderExecuted{
            order_id     : v0,
            owner        : arg1.owner,
            amount_in    : v1,
            amount_out   : v3 - v4,
            fee          : v4,
            executions   : arg1.executions,
            remaining    : 0x2::balance::value<T0>(&arg1.funds),
            timestamp_ms : v5,
        };
        0x2::event::emit<OrderExecuted>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = KeeperCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KeeperCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = Config{
            id            : 0x2::object::new(arg0),
            version       : 1,
            fee_recipient : 0x2::tx_context::sender(arg0),
            fee_bps       : 10,
            paused        : false,
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun is_finished<T0, T1>(arg0: &Order<T0, T1>) : bool {
        0x2::balance::value<T0>(&arg0.funds) == 0 || arg0.max_executions > 0 && arg0.executions >= arg0.max_executions
    }

    public fun kind<T0, T1>(arg0: &Order<T0, T1>) : u8 {
        arg0.kind
    }

    public fun min_price<T0, T1>(arg0: &Order<T0, T1>) : u128 {
        arg0.min_price
    }

    public fun new_keeper(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : KeeperCap {
        KeeperCap{id: 0x2::object::new(arg1)}
    }

    public fun next_ms<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.next_ms
    }

    public fun owner<T0, T1>(arg0: &Order<T0, T1>) : address {
        arg0.owner
    }

    public fun raise_floor<T0, T1>(arg0: &KeeperCap, arg1: &mut Order<T0, T1>, arg2: u128, arg3: u128) {
        assert!(arg1.kind == 3, 8);
        assert!(arg2 >= arg1.min_price && arg3 >= arg1.trigger_price, 11);
        arg1.min_price = arg2;
        arg1.trigger_price = arg3;
        let v0 = FloorRaised{
            order_id      : 0x2::object::id<Order<T0, T1>>(arg1),
            min_price     : arg2,
            trigger_price : arg3,
        };
        0x2::event::emit<FloorRaised>(v0);
    }

    public fun remaining<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address) {
        assert!(arg2 <= 100, 9);
        arg1.fee_bps = arg2;
        arg1.fee_recipient = arg3;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun top_up<T0, T1>(arg0: &mut Order<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v7
}

