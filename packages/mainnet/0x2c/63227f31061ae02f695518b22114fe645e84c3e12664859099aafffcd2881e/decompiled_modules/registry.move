module 0x2c63227f31061ae02f695518b22114fe645e84c3e12664859099aafffcd2881e::registry {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        total_tasks: u64,
        total_executions: u64,
        total_bounty_paid: u64,
    }

    struct Task has key {
        id: 0x2::object::UID,
        owner: address,
        tag: vector<u8>,
        bounty_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        bounty_per_exec: u64,
        active: bool,
        total_executions: u64,
        total_paid: u64,
    }

    struct ExecutionReceipt {
        task_id: 0x2::object::ID,
        keeper: address,
        bounty_amount: u64,
    }

    struct TaskCreated has copy, drop {
        task_id: 0x2::object::ID,
        owner: address,
        tag: vector<u8>,
        bounty_per_exec: u64,
        initial_deposit: u64,
    }

    struct TaskExecuted has copy, drop {
        task_id: 0x2::object::ID,
        keeper: address,
        bounty_paid: u64,
        protocol_fee: u64,
        execution_number: u64,
    }

    struct TaskDeactivated has copy, drop {
        task_id: 0x2::object::ID,
        remaining_bounty: u64,
    }

    public fun create_task(arg0: &mut ProtocolConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = Task{
            id               : 0x2::object::new(arg4),
            owner            : 0x2::tx_context::sender(arg4),
            tag              : arg3,
            bounty_pool      : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            bounty_per_exec  : arg2,
            active           : true,
            total_executions : 0,
            total_paid       : 0,
        };
        arg0.total_tasks = arg0.total_tasks + 1;
        let v2 = TaskCreated{
            task_id         : 0x2::object::id<Task>(&v1),
            owner           : 0x2::tx_context::sender(arg4),
            tag             : v1.tag,
            bounty_per_exec : arg2,
            initial_deposit : v0,
        };
        0x2::event::emit<TaskCreated>(v2);
        0x2::transfer::share_object<Task>(v1);
    }

    public fun deactivate_task(arg0: &mut Task, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        arg0.active = false;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.bounty_pool);
        let v1 = TaskDeactivated{
            task_id          : 0x2::object::id<Task>(arg0),
            remaining_bounty : v0,
        };
        0x2::event::emit<TaskDeactivated>(v1);
        if (v0 > 0) {
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bounty_pool, v0), arg1)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg1)
        }
    }

    public fun deposit_bounty(arg0: &mut Task, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bounty_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun finish_execution(arg0: &mut ProtocolConfig, arg1: &mut Task, arg2: ExecutionReceipt, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let ExecutionReceipt {
            task_id       : v0,
            keeper        : v1,
            bounty_amount : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<Task>(arg1), 3);
        let v3 = v2 * 500 / 10000;
        let v4 = v2 - v3;
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v4), arg4), v1);
        };
        if (v3 > 0 && 0x2::balance::value<0x2::sui::SUI>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4), arg0.treasury);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        };
        arg1.total_executions = arg1.total_executions + 1;
        arg1.total_paid = arg1.total_paid + v2;
        arg0.total_executions = arg0.total_executions + 1;
        arg0.total_bounty_paid = arg0.total_bounty_paid + v2;
        let v6 = TaskExecuted{
            task_id          : v0,
            keeper           : v1,
            bounty_paid      : v4,
            protocol_fee     : v3,
            execution_number : arg1.total_executions,
        };
        0x2::event::emit<TaskExecuted>(v6);
    }

    public fun init_protocol(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id                : 0x2::object::new(arg0),
            treasury          : 0x2::tx_context::sender(arg0),
            total_tasks       : 0,
            total_executions  : 0,
            total_bounty_paid : 0,
        };
        0x2::transfer::share_object<ProtocolConfig>(v0);
    }

    public fun protocol_stats(arg0: &ProtocolConfig) : (u64, u64, u64) {
        (arg0.total_tasks, arg0.total_executions, arg0.total_bounty_paid)
    }

    public fun start_execution(arg0: &mut Task, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ExecutionReceipt) {
        assert!(arg0.active, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.bounty_pool) >= arg0.bounty_per_exec, 2);
        let v0 = ExecutionReceipt{
            task_id       : 0x2::object::id<Task>(arg0),
            keeper        : 0x2::tx_context::sender(arg1),
            bounty_amount : arg0.bounty_per_exec,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bounty_pool, arg0.bounty_per_exec), arg1), v0)
    }

    public fun task_bounty_per_exec(arg0: &Task) : u64 {
        arg0.bounty_per_exec
    }

    public fun task_bounty_remaining(arg0: &Task) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bounty_pool)
    }

    public fun task_is_active(arg0: &Task) : bool {
        arg0.active
    }

    public fun task_stats(arg0: &Task) : (u64, u64) {
        (arg0.total_executions, arg0.total_paid)
    }

    // decompiled from Move bytecode v6
}

