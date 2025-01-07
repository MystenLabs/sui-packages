module 0x9c402b6dd551e052f24086e9e3533e0879f010527c0cfe3e4e2b153efa31ece7::task {
    struct TaskList has key {
        id: 0x2::object::UID,
        task_ids: vector<0x2::object::ID>,
        tasks: 0x2::table::Table<0x2::object::ID, Task>,
    }

    struct Task has store {
        in_task: u64,
        total_attempts: u64,
        reward: 0x2::balance::Balance<0x2::sui::SUI>,
        earned: 0x2::balance::Balance<0x2::sui::SUI>,
        task_publisher_address: address,
    }

    struct QueryTaskEvent has copy, drop {
        task_id: 0x2::object::ID,
        in_task: u64,
        total_attempts: u64,
        cur_reward: u64,
    }

    public fun value(arg0: &Task) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reward)
    }

    public fun contains(arg0: &TaskList, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Task>(&arg0.tasks, arg1)
    }

    public fun add_attempt(arg0: &mut Task) {
        arg0.in_task = arg0.in_task + 1;
        arg0.total_attempts = arg0.total_attempts + 1;
    }

    public fun as_seed(arg0: &Task) : u64 {
        arg0.in_task + arg0.total_attempts
    }

    public fun borrow_task_mut(arg0: &mut TaskList, arg1: 0x2::object::ID) : &mut Task {
        0x2::table::borrow_mut<0x2::object::ID, Task>(&mut arg0.tasks, arg1)
    }

    public fun complete_task(arg0: &mut 0x9c402b6dd551e052f24086e9e3533e0879f010527c0cfe3e4e2b153efa31ece7::admin::GameCap, arg1: 0x2::object::ID, arg2: &mut TaskList, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2.task_ids;
        let (_, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg1);
        0x1::vector::remove<0x2::object::ID>(v0, v2);
        let Task {
            in_task                : _,
            total_attempts         : _,
            reward                 : v5,
            earned                 : v6,
            task_publisher_address : v7,
        } = 0x2::table::remove<0x2::object::ID, Task>(&mut arg2.tasks, arg1);
        let v8 = v6;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3), 0x2::tx_context::sender(arg3));
        let v9 = 0x9c402b6dd551e052f24086e9e3533e0879f010527c0cfe3e4e2b153efa31ece7::admin::borrow_balance_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(v9, 0x2::balance::split<0x2::sui::SUI>(&mut v8, 0x2::balance::value<0x2::sui::SUI>(&v8) / 3));
        if (0x2::balance::value<0x2::sui::SUI>(v9) >= 10000000000) {
            0x9c402b6dd551e052f24086e9e3533e0879f010527c0cfe3e4e2b153efa31ece7::admin::withdraw_(arg0, arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v8, arg3), v7);
    }

    entry fun create_task(arg0: &mut TaskList, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2 && arg2 >= 1998, 1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v0 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg3));
        let v1 = Task{
            in_task                : 0,
            total_attempts         : 0,
            reward                 : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg3)),
            earned                 : 0x2::balance::zero<0x2::sui::SUI>(),
            task_publisher_address : 0x2::tx_context::sender(arg3),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.task_ids, v0);
        0x2::table::add<0x2::object::ID, Task>(&mut arg0.tasks, v0, v1);
    }

    public fun failed_attempt(arg0: &mut Task) {
        arg0.in_task = arg0.in_task - 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TaskList{
            id       : 0x2::object::new(arg0),
            task_ids : 0x1::vector::empty<0x2::object::ID>(),
            tasks    : 0x2::table::new<0x2::object::ID, Task>(arg0),
        };
        0x2::transfer::share_object<TaskList>(v0);
    }

    entry fun query_task(arg0: 0x2::object::ID, arg1: &TaskList) {
        assert!(0x2::table::contains<0x2::object::ID, Task>(&arg1.tasks, arg0), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, Task>(&arg1.tasks, arg0);
        let v1 = QueryTaskEvent{
            task_id        : arg0,
            in_task        : v0.in_task,
            total_attempts : v0.total_attempts,
            cur_reward     : 0x2::balance::value<0x2::sui::SUI>(&v0.reward),
        };
        0x2::event::emit<QueryTaskEvent>(v1);
    }

    public fun update(arg0: &mut Task, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.reward;
        let v1 = &mut arg0.earned;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(v0) / 2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 4);
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        0x2::balance::join<0x2::sui::SUI>(v1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v2 / 2, arg2)));
        0x2::balance::join<0x2::sui::SUI>(v0, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
    }

    // decompiled from Move bytecode v6
}

