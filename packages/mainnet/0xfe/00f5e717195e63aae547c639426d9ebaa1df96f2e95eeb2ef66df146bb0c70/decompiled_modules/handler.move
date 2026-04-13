module 0xfe00f5e717195e63aae547c639426d9ebaa1df96f2e95eeb2ef66df146bb0c70::handler {
    struct TaskQueue has key {
        id: 0x2::object::UID,
        tasks: 0x2::table::Table<0x1::ascii::String, QueueConfig>,
        version: u8,
    }

    struct QueueConfig has store {
        owner: address,
        worker: address,
        status: u8,
        output_bin: address,
        retry_bin: address,
        priority_weight: u8,
        tasks: 0x2::table::Table<0x2::object::ID, TaskEntry>,
    }

    struct TaskEntry has copy, drop, store {
        task_type: 0x1::ascii::String,
        priority: u64,
        executed: bool,
    }

    struct QueueCreated has copy, drop {
        queue_id: 0x1::ascii::String,
        owner: address,
    }

    struct TaskEnqueued has copy, drop {
        queue_id: 0x1::ascii::String,
        task_id: 0x2::object::ID,
        task_type: 0x1::ascii::String,
        priority: u64,
    }

    struct ExecutionCompleted has copy, drop {
        queue_id: 0x1::ascii::String,
        task_id: 0x2::object::ID,
        result_priority: u64,
    }

    public entry fun activate_queue(arg0: &mut TaskQueue, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QueueConfig>(&mut arg0.tasks, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun archive_completed(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut TaskQueue, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg1.tasks, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QueueConfig>(&mut arg1.tasks, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.worker, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, TaskEntry>(&v0.tasks, arg3);
            !v3.executed && v3.priority > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, TaskEntry>(&mut v0.tasks, arg3).executed = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.priority_weight as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.retry_bin);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.output_bin);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.output_bin);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.retry_bin);
        };
        let v7 = ExecutionCompleted{
            queue_id        : arg2,
            task_id         : arg3,
            result_priority : v5,
        };
        0x2::event::emit<ExecutionCompleted>(v7);
    }

    public entry fun create_queue(arg0: &mut TaskQueue, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = QueueConfig{
            owner           : 0x2::tx_context::sender(arg6),
            worker          : arg2,
            status          : 0,
            output_bin      : arg3,
            retry_bin       : arg4,
            priority_weight : arg5,
            tasks           : 0x2::table::new<0x2::object::ID, TaskEntry>(arg6),
        };
        0x2::table::add<0x1::ascii::String, QueueConfig>(&mut arg0.tasks, arg1, v0);
        let v1 = QueueCreated{
            queue_id : arg1,
            owner    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<QueueCreated>(v1);
    }

    public fun dispatch_batch<T0>(arg0: &mut TaskQueue, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QueueConfig>(&mut arg0.tasks, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.worker, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, TaskEntry>(&mut v0.tasks, arg2).executed = true;
        };
        let v3 = v2 * (v0.priority_weight as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.retry_bin);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.output_bin);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.output_bin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.retry_bin);
        };
        let v4 = ExecutionCompleted{
            queue_id        : arg1,
            task_id         : arg2,
            result_priority : v2,
        };
        0x2::event::emit<ExecutionCompleted>(v4);
    }

    public entry fun enqueue_task(arg0: &mut TaskQueue, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QueueConfig>(&mut arg0.tasks, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.worker, 100);
        let v2 = TaskEntry{
            task_type : arg3,
            priority  : arg4,
            executed  : false,
        };
        if (0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, TaskEntry>(&mut v0.tasks, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, TaskEntry>(&mut v0.tasks, arg2, v2);
        };
        let v3 = TaskEnqueued{
            queue_id  : arg1,
            task_id   : arg2,
            task_type : arg3,
            priority  : arg4,
        };
        0x2::event::emit<TaskEnqueued>(v3);
    }

    public fun execute_task<T0: store + key>(arg0: &mut TaskQueue, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QueueConfig>(&mut arg0.tasks, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.worker, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, TaskEntry>(&v0.tasks, arg2);
            !v3.executed && v3.priority > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, TaskEntry>(&mut v0.tasks, arg2).executed = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.output_bin);
        let v4 = ExecutionCompleted{
            queue_id        : arg1,
            task_id         : arg2,
            result_priority : 1,
        };
        0x2::event::emit<ExecutionCompleted>(v4);
    }

    public fun get_queue_info(arg0: &TaskQueue, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1);
        (v0.owner, v0.worker, v0.status & 1 != 0, v0.output_bin, v0.retry_bin, v0.priority_weight)
    }

    public fun get_task_info(arg0: &TaskQueue, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1);
        assert!(0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, TaskEntry>(&v0.tasks, arg2);
        (v1.task_type, v1.priority, v1.executed)
    }

    public fun get_task_priority(arg0: &TaskQueue, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, TaskEntry>(&v0.tasks, arg2);
        if (v1.executed) {
            return 0
        };
        v1.priority
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TaskQueue{
            id      : 0x2::object::new(arg0),
            tasks   : 0x2::table::new<0x1::ascii::String, QueueConfig>(arg0),
            version : 1,
        };
        0x2::transfer::share_object<TaskQueue>(v0);
    }

    public fun should_execute(arg0: &TaskQueue, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_task_priority(arg0, arg1, arg2) > 0
    }

    public entry fun update_priority(arg0: &mut TaskQueue, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QueueConfig>(&arg0.tasks, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QueueConfig>(&mut arg0.tasks, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.worker, 100);
        assert!(0x2::table::contains<0x2::object::ID, TaskEntry>(&v0.tasks, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, TaskEntry>(&mut v0.tasks, arg2).priority = arg3;
    }

    // decompiled from Move bytecode v6
}

