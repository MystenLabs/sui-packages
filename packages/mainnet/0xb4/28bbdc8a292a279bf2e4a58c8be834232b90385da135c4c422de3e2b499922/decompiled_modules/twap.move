module 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::twap {
    struct TWAPRegistry has key {
        id: 0x2::object::UID,
        orders: 0x2::table::Table<u64, 0x2::object::ID>,
        next_order_id: u64,
        total_orders: u64,
        active_orders: u64,
    }

    struct TWAPOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        order_id: u64,
        owner: address,
        total_amount: u64,
        remaining_amount: u64,
        deposited: 0x2::balance::Balance<T0>,
        num_chunks: u64,
        chunks_executed: u64,
        interval: u64,
        last_execution_time: u64,
        min_output_per_chunk: u64,
        total_output: u64,
        status: u8,
        created_at: u64,
        pool_address: address,
    }

    struct ExecutionRecord has copy, drop, store {
        chunk_number: u64,
        amount_in: u64,
        amount_out: u64,
        price: u64,
        timestamp: u64,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct TWAPOrderCreated has copy, drop {
        order_id: u64,
        owner: address,
        total_amount: u64,
        num_chunks: u64,
        interval: u64,
        created_at: u64,
    }

    struct ChunkExecuted has copy, drop {
        order_id: u64,
        chunk_number: u64,
        amount_in: u64,
        amount_out: u64,
        price: u64,
        timestamp: u64,
    }

    struct TWAPOrderCompleted has copy, drop {
        order_id: u64,
        total_amount_in: u64,
        total_amount_out: u64,
        average_price: u64,
        completed_at: u64,
    }

    struct TWAPOrderCancelled has copy, drop {
        order_id: u64,
        refund_amount: u64,
        chunks_executed: u64,
    }

    public entry fun cancel_order<T0, T1>(arg0: &mut TWAPRegistry, arg1: TWAPOrder<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(arg1.status == 1 || arg1.status == 4, 6);
        let TWAPOrder {
            id                   : v0,
            order_id             : v1,
            owner                : v2,
            total_amount         : _,
            remaining_amount     : _,
            deposited            : v5,
            num_chunks           : _,
            chunks_executed      : v7,
            interval             : _,
            last_execution_time  : _,
            min_output_per_chunk : _,
            total_output         : _,
            status               : _,
            created_at           : _,
            pool_address         : _,
        } = arg1;
        let v15 = v5;
        let v16 = 0x2::balance::value<T0>(&v15);
        if (v16 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v15, arg2), v2);
        } else {
            0x2::balance::destroy_zero<T0>(v15);
        };
        if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.orders, v1)) {
            0x2::table::remove<u64, 0x2::object::ID>(&mut arg0.orders, v1);
            arg0.active_orders = arg0.active_orders - 1;
        };
        let v17 = TWAPOrderCancelled{
            order_id        : v1,
            refund_amount   : v16,
            chunks_executed : v7,
        };
        0x2::event::emit<TWAPOrderCancelled>(v17);
        0x2::object::delete(v0);
    }

    public entry fun create_twap_order<T0, T1>(arg0: &mut TWAPRegistry, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 100, 7);
        assert!(arg3 >= 60, 2);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = arg0.next_order_id;
        let v2 = 0x2::object::new(arg7);
        let v3 = TWAPOrder<T0, T1>{
            id                   : v2,
            order_id             : v1,
            owner                : 0x2::tx_context::sender(arg7),
            total_amount         : v0,
            remaining_amount     : v0,
            deposited            : 0x2::coin::into_balance<T0>(arg1),
            num_chunks           : arg2,
            chunks_executed      : 0,
            interval             : arg3,
            last_execution_time  : arg6,
            min_output_per_chunk : arg4,
            total_output         : 0,
            status               : 1,
            created_at           : arg6,
            pool_address         : arg5,
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.orders, v1, 0x2::object::uid_to_inner(&v2));
        arg0.next_order_id = arg0.next_order_id + 1;
        arg0.total_orders = arg0.total_orders + 1;
        arg0.active_orders = arg0.active_orders + 1;
        let v4 = TWAPOrderCreated{
            order_id     : v1,
            owner        : 0x2::tx_context::sender(arg7),
            total_amount : v0,
            num_chunks   : arg2,
            interval     : arg3,
            created_at   : arg6,
        };
        0x2::event::emit<TWAPOrderCreated>(v4);
        0x2::transfer::share_object<TWAPOrder<T0, T1>>(v3);
    }

    public fun execute_chunk<T0, T1>(arg0: &KeeperCap, arg1: &mut TWAPOrder<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.status == 1, 5);
        assert!(arg1.chunks_executed < arg1.num_chunks, 5);
        assert!(arg3 >= arg1.last_execution_time + arg1.interval, 8);
        let v0 = arg1.remaining_amount / (arg1.num_chunks - arg1.chunks_executed);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 >= arg1.min_output_per_chunk, 1);
        arg1.remaining_amount = arg1.remaining_amount - v0;
        arg1.chunks_executed = arg1.chunks_executed + 1;
        arg1.last_execution_time = arg3;
        arg1.total_output = arg1.total_output + v1;
        let v2 = if (v0 > 0) {
            v1 * 1000000 / v0
        } else {
            0
        };
        let v3 = ChunkExecuted{
            order_id     : arg1.order_id,
            chunk_number : arg1.chunks_executed,
            amount_in    : v0,
            amount_out   : v1,
            price        : v2,
            timestamp    : arg3,
        };
        0x2::event::emit<ChunkExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, arg1.owner);
        if (arg1.chunks_executed >= arg1.num_chunks) {
            arg1.status = 2;
            let v4 = if (arg1.total_amount > 0) {
                arg1.total_output * 1000000 / arg1.total_amount
            } else {
                0
            };
            let v5 = TWAPOrderCompleted{
                order_id         : arg1.order_id,
                total_amount_in  : arg1.total_amount,
                total_amount_out : arg1.total_output,
                average_price    : v4,
                completed_at     : arg3,
            };
            0x2::event::emit<TWAPOrderCompleted>(v5);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.deposited, v0), arg4)
    }

    public fun get_average_price<T0, T1>(arg0: &TWAPOrder<T0, T1>) : u64 {
        let v0 = arg0.total_amount - arg0.remaining_amount;
        if (v0 > 0) {
            arg0.total_output * 1000000 / v0
        } else {
            0
        }
    }

    public fun get_next_execution_time<T0, T1>(arg0: &TWAPOrder<T0, T1>) : u64 {
        arg0.last_execution_time + arg0.interval
    }

    public fun get_order_progress<T0, T1>(arg0: &TWAPOrder<T0, T1>) : (u64, u64) {
        let v0 = if (arg0.num_chunks > 0) {
            arg0.chunks_executed * 100 / arg0.num_chunks
        } else {
            0
        };
        (arg0.chunks_executed, v0)
    }

    public fun get_order_state<T0, T1>(arg0: &TWAPOrder<T0, T1>) : (u64, u64, u64, u64, u64, u8) {
        (arg0.order_id, arg0.total_amount, arg0.remaining_amount, arg0.chunks_executed, arg0.num_chunks, arg0.status)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TWAPRegistry{
            id            : 0x2::object::new(arg0),
            orders        : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            next_order_id : 1,
            total_orders  : 0,
            active_orders : 0,
        };
        0x2::transfer::share_object<TWAPRegistry>(v0);
        let v1 = KeeperCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KeeperCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_chunk_ready<T0, T1>(arg0: &TWAPOrder<T0, T1>, arg1: u64) : bool {
        if (arg0.status == 1) {
            if (arg0.chunks_executed < arg0.num_chunks) {
                arg1 >= arg0.last_execution_time + arg0.interval
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun pause_order<T0, T1>(arg0: &mut TWAPOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        assert!(arg0.status == 1, 5);
        arg0.status = 4;
    }

    public entry fun resume_order<T0, T1>(arg0: &mut TWAPOrder<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(arg0.status == 4, 5);
        arg0.status = 1;
        arg0.last_execution_time = arg1;
    }

    // decompiled from Move bytecode v6
}

