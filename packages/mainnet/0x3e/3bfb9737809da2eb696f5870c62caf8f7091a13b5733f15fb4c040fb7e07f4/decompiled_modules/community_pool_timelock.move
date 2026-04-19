module 0x900bca6461ad24c86b83c974788b457cb76c3f6f4fd7b061c5b58cb40d974bab::community_pool_timelock {
    struct TimelockAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProposerCap has store, key {
        id: 0x2::object::UID,
        proposer: address,
    }

    struct ExecutorCap has store, key {
        id: 0x2::object::UID,
        executor: address,
    }

    struct QueuedOperation has copy, drop, store {
        operation_id: vector<u8>,
        operation_type: u8,
        target_address: address,
        target_value: u64,
        data_hash: vector<u8>,
        proposer: address,
        scheduled_time: u64,
        ready_time: u64,
        expiry_time: u64,
        executed: bool,
        cancelled: bool,
    }

    struct TimelockState has key {
        id: 0x2::object::UID,
        min_delay: u64,
        pending_operations: 0x2::table::Table<vector<u8>, QueuedOperation>,
        operation_count: u64,
        created_at: u64,
        is_mainnet: bool,
        paused: bool,
        executed_count: u64,
        last_cleanup: u64,
    }

    struct TimelockCreated has copy, drop {
        timelock_id: 0x2::object::ID,
        min_delay: u64,
        is_mainnet: bool,
        timestamp: u64,
    }

    struct OperationScheduled has copy, drop {
        operation_id: vector<u8>,
        operation_type: u8,
        target_address: address,
        target_value: u64,
        ready_time: u64,
        proposer: address,
        timestamp: u64,
    }

    struct OperationExecuted has copy, drop {
        operation_id: vector<u8>,
        operation_type: u8,
        executor: address,
        timestamp: u64,
    }

    struct OperationCancelled has copy, drop {
        operation_id: vector<u8>,
        canceller: address,
        timestamp: u64,
    }

    struct MinDelayUpdated has copy, drop {
        old_delay: u64,
        new_delay: u64,
        timestamp: u64,
    }

    struct BatchScheduled has copy, drop {
        batch_id: vector<u8>,
        operation_count: u64,
        ready_time: u64,
        proposer: address,
        timestamp: u64,
    }

    struct BatchExecuted has copy, drop {
        batch_id: vector<u8>,
        operations_executed: u64,
        executor: address,
        timestamp: u64,
    }

    struct PauseStateChanged has copy, drop {
        paused: bool,
        admin: address,
        timestamp: u64,
    }

    public entry fun cancel_operation(arg0: &ProposerCap, arg1: &mut TimelockState, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, QueuedOperation>(&arg1.pending_operations, arg2), 3);
        let v0 = 0x2::table::borrow_mut<vector<u8>, QueuedOperation>(&mut arg1.pending_operations, arg2);
        assert!(!v0.executed, 6);
        v0.cancelled = true;
        let v1 = OperationCancelled{
            operation_id : arg2,
            canceller    : 0x2::tx_context::sender(arg4),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OperationCancelled>(v1);
    }

    public entry fun create_executor_cap(arg0: &TimelockAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutorCap{
            id       : 0x2::object::new(arg2),
            executor : arg1,
        };
        0x2::transfer::transfer<ExecutorCap>(v0, arg1);
    }

    public entry fun create_proposer_cap(arg0: &TimelockAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposerCap{
            id       : 0x2::object::new(arg2),
            proposer : arg1,
        };
        0x2::transfer::transfer<ProposerCap>(v0, arg1);
    }

    public entry fun create_timelock(arg0: &TimelockAdminCap, arg1: u64, arg2: bool, arg3: vector<address>, arg4: vector<address>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = if (arg2) {
            assert!(arg1 >= 172800000, 8);
            arg1
        } else if (arg1 < 300000) {
            300000
        } else {
            arg1
        };
        assert!(v1 <= 2592000000, 9);
        let v2 = TimelockState{
            id                 : 0x2::object::new(arg6),
            min_delay          : v1,
            pending_operations : 0x2::table::new<vector<u8>, QueuedOperation>(arg6),
            operation_count    : 0,
            created_at         : v0,
            is_mainnet         : arg2,
            paused             : false,
            executed_count     : 0,
            last_cleanup       : v0,
        };
        let v3 = TimelockCreated{
            timelock_id : 0x2::object::id<TimelockState>(&v2),
            min_delay   : v1,
            is_mainnet  : arg2,
            timestamp   : v0,
        };
        0x2::event::emit<TimelockCreated>(v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg3)) {
            let v5 = *0x1::vector::borrow<address>(&arg3, v4);
            let v6 = ProposerCap{
                id       : 0x2::object::new(arg6),
                proposer : v5,
            };
            0x2::transfer::transfer<ProposerCap>(v6, v5);
            v4 = v4 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&arg4)) {
            let v8 = *0x1::vector::borrow<address>(&arg4, v7);
            let v9 = ExecutorCap{
                id       : 0x2::object::new(arg6),
                executor : v8,
            };
            0x2::transfer::transfer<ExecutorCap>(v9, v8);
            v7 = v7 + 1;
        };
        0x2::transfer::share_object<TimelockState>(v2);
    }

    public entry fun execute_batch(arg0: &ExecutorCap, arg1: &mut TimelockState, arg2: vector<vector<u8>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 12);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 > 0, 10);
        assert!(v0 <= 10, 11);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&arg2, v3);
            assert!(0x2::table::contains<vector<u8>, QueuedOperation>(&arg1.pending_operations, v4), 3);
            let v5 = 0x2::table::borrow_mut<vector<u8>, QueuedOperation>(&mut arg1.pending_operations, v4);
            assert!(!v5.executed, 6);
            assert!(!v5.cancelled, 3);
            assert!(v1 >= v5.ready_time, 4);
            assert!(v1 <= v5.expiry_time, 5);
            v5.executed = true;
            arg1.executed_count = arg1.executed_count + 1;
            let v6 = OperationExecuted{
                operation_id   : v4,
                operation_type : v5.operation_type,
                executor       : v2,
                timestamp      : v1,
            };
            0x2::event::emit<OperationExecuted>(v6);
            v3 = v3 + 1;
        };
        let v7 = 0x2::bcs::to_bytes<u64>(&v1);
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<u64>(&v0));
        let v8 = BatchExecuted{
            batch_id            : 0x2::hash::keccak256(&v7),
            operations_executed : v0,
            executor            : v2,
            timestamp           : v1,
        };
        0x2::event::emit<BatchExecuted>(v8);
    }

    public fun execute_operation(arg0: &ExecutorCap, arg1: &mut TimelockState, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u8, address, u64, vector<u8>) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<vector<u8>, QueuedOperation>(&arg1.pending_operations, arg2), 3);
        let v1 = 0x2::table::borrow_mut<vector<u8>, QueuedOperation>(&mut arg1.pending_operations, arg2);
        assert!(!v1.executed, 6);
        assert!(!v1.cancelled, 3);
        assert!(v0 >= v1.ready_time, 4);
        assert!(v0 <= v1.expiry_time, 5);
        v1.executed = true;
        let v2 = OperationExecuted{
            operation_id   : arg2,
            operation_type : v1.operation_type,
            executor       : 0x2::tx_context::sender(arg4),
            timestamp      : v0,
        };
        0x2::event::emit<OperationExecuted>(v2);
        (v1.operation_type, v1.target_address, v1.target_value, v1.data_hash)
    }

    public fun get_operation_info(arg0: &TimelockState, arg1: vector<u8>) : (u8, address, u64, u64, u64, bool, bool) {
        assert!(0x2::table::contains<vector<u8>, QueuedOperation>(&arg0.pending_operations, arg1), 3);
        let v0 = 0x2::table::borrow<vector<u8>, QueuedOperation>(&arg0.pending_operations, arg1);
        (v0.operation_type, v0.target_address, v0.target_value, v0.ready_time, v0.expiry_time, v0.executed, v0.cancelled)
    }

    public fun get_pending_count(arg0: &TimelockState) : u64 {
        arg0.operation_count - arg0.executed_count
    }

    public fun get_timelock_info(arg0: &TimelockState) : (u64, u64, bool, bool, u64) {
        (arg0.min_delay, arg0.operation_count, arg0.is_mainnet, arg0.paused, arg0.executed_count)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TimelockAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TimelockAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_operation_pending(arg0: &TimelockState, arg1: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, QueuedOperation>(&arg0.pending_operations, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<vector<u8>, QueuedOperation>(&arg0.pending_operations, arg1);
        !v0.executed && !v0.cancelled
    }

    public fun is_operation_ready(arg0: &TimelockState, arg1: vector<u8>, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<vector<u8>, QueuedOperation>(&arg0.pending_operations, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<vector<u8>, QueuedOperation>(&arg0.pending_operations, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!v0.executed) {
            if (!v0.cancelled) {
                if (v1 >= v0.ready_time) {
                    v1 <= v0.expiry_time
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_paused(arg0: &TimelockState) : bool {
        arg0.paused
    }

    public entry fun pause(arg0: &TimelockAdminCap, arg1: &mut TimelockState, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        arg1.paused = true;
        let v0 = PauseStateChanged{
            paused    : true,
            admin     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PauseStateChanged>(v0);
    }

    public entry fun schedule_batch(arg0: &ProposerCap, arg1: &mut TimelockState, arg2: vector<u8>, arg3: vector<address>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 12);
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 > 0, 10);
        assert!(v0 <= 10, 11);
        assert!(v0 == 0x1::vector::length<address>(&arg3), 10);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 10);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = v1 + arg1.min_delay;
        let v4 = 0x2::bcs::to_bytes<u64>(&v1);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg1.operation_count));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v0));
        let v5 = 0x2::hash::keccak256(&v4);
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<u8>(&arg2, v6);
            let v8 = *0x1::vector::borrow<address>(&arg3, v6);
            let v9 = *0x1::vector::borrow<u64>(&arg4, v6);
            let v10 = 0x2::bcs::to_bytes<u64>(&v1);
            0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u8>(&v7));
            0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<address>(&v8));
            0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&v9));
            0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&arg1.operation_count));
            0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&v6));
            let v11 = 0x2::hash::keccak256(&v10);
            let v12 = QueuedOperation{
                operation_id   : v11,
                operation_type : v7,
                target_address : v8,
                target_value   : v9,
                data_hash      : v5,
                proposer       : v2,
                scheduled_time : v1,
                ready_time     : v3,
                expiry_time    : v3 + 604800000,
                executed       : false,
                cancelled      : false,
            };
            0x2::table::add<vector<u8>, QueuedOperation>(&mut arg1.pending_operations, v11, v12);
            arg1.operation_count = arg1.operation_count + 1;
            v6 = v6 + 1;
        };
        let v13 = BatchScheduled{
            batch_id        : v5,
            operation_count : v0,
            ready_time      : v3,
            proposer        : v2,
            timestamp       : v1,
        };
        0x2::event::emit<BatchScheduled>(v13);
    }

    public entry fun schedule_operation(arg0: &ProposerCap, arg1: &mut TimelockState, arg2: u8, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 12);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = v0 + arg1.min_delay;
        let v3 = 0x2::bcs::to_bytes<u64>(&v0);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg1.operation_count));
        let v4 = 0x2::hash::keccak256(&v3);
        assert!(!0x2::table::contains<vector<u8>, QueuedOperation>(&arg1.pending_operations, v4), 7);
        let v5 = QueuedOperation{
            operation_id   : v4,
            operation_type : arg2,
            target_address : arg3,
            target_value   : arg4,
            data_hash      : 0x2::hash::keccak256(&arg5),
            proposer       : v1,
            scheduled_time : v0,
            ready_time     : v2,
            expiry_time    : v2 + 604800000,
            executed       : false,
            cancelled      : false,
        };
        0x2::table::add<vector<u8>, QueuedOperation>(&mut arg1.pending_operations, v4, v5);
        arg1.operation_count = arg1.operation_count + 1;
        let v6 = OperationScheduled{
            operation_id   : v4,
            operation_type : arg2,
            target_address : arg3,
            target_value   : arg4,
            ready_time     : v2,
            proposer       : v1,
            timestamp      : v0,
        };
        0x2::event::emit<OperationScheduled>(v6);
    }

    public entry fun set_min_delay(arg0: &TimelockAdminCap, arg1: &mut TimelockState, arg2: u64, arg3: &0x2::clock::Clock) {
        if (arg1.is_mainnet) {
            assert!(arg2 >= 172800000, 8);
        } else {
            assert!(arg2 >= 300000, 8);
        };
        assert!(arg2 <= 2592000000, 9);
        arg1.min_delay = arg2;
        let v0 = MinDelayUpdated{
            old_delay : arg1.min_delay,
            new_delay : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MinDelayUpdated>(v0);
    }

    public entry fun unpause(arg0: &TimelockAdminCap, arg1: &mut TimelockState, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        arg1.paused = false;
        let v0 = PauseStateChanged{
            paused    : false,
            admin     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PauseStateChanged>(v0);
    }

    // decompiled from Move bytecode v7
}

