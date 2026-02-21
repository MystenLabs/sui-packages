module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::task {
    struct Task has store, key {
        id: 0x2::object::UID,
        creator: address,
        agent: address,
        title: vector<u8>,
        description: vector<u8>,
        reward: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_amount: u64,
        status: u8,
        deadline: u64,
        created_at: u64,
    }

    struct TaskCreated has copy, drop {
        task_id: address,
        creator: address,
        reward_amount: u64,
        deadline: u64,
    }

    struct TaskAccepted has copy, drop {
        task_id: address,
        agent: address,
    }

    struct TaskCompleted has copy, drop {
        task_id: address,
        agent: address,
        reward_amount: u64,
    }

    struct TaskCancelled has copy, drop {
        task_id: address,
        creator: address,
        refund_amount: u64,
    }

    entry fun accept_task(arg0: &mut Task, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 0);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.deadline, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.agent = v0;
        arg0.status = 1;
        let v1 = TaskAccepted{
            task_id : 0x2::object::uid_to_address(&arg0.id),
            agent   : v0,
        };
        0x2::event::emit<TaskAccepted>(v1);
    }

    public fun agent(arg0: &Task) : address {
        arg0.agent
    }

    entry fun cancel_task(arg0: &mut Task, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 0);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        arg0.status = 4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward, arg0.reward_amount), arg1), arg0.creator);
        let v0 = TaskCancelled{
            task_id       : 0x2::object::uid_to_address(&arg0.id),
            creator       : arg0.creator,
            refund_amount : arg0.reward_amount,
        };
        0x2::event::emit<TaskCancelled>(v0);
    }

    entry fun complete_task(arg0: &mut Task, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 0);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        arg0.status = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward, arg0.reward_amount), arg1), arg0.agent);
        let v0 = TaskCompleted{
            task_id       : 0x2::object::uid_to_address(&arg0.id),
            agent         : arg0.agent,
            reward_amount : arg0.reward_amount,
        };
        0x2::event::emit<TaskCompleted>(v0);
    }

    entry fun create_task(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 1000000, 3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 > v1, 4);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = Task{
            id            : 0x2::object::new(arg5),
            creator       : v2,
            agent         : @0x0,
            title         : arg0,
            description   : arg1,
            reward        : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            reward_amount : v0,
            status        : 0,
            deadline      : arg3,
            created_at    : v1,
        };
        let v4 = TaskCreated{
            task_id       : 0x2::object::uid_to_address(&v3.id),
            creator       : v2,
            reward_amount : v0,
            deadline      : arg3,
        };
        0x2::event::emit<TaskCreated>(v4);
        0x2::transfer::share_object<Task>(v3);
    }

    public fun creator(arg0: &Task) : address {
        arg0.creator
    }

    public fun deadline(arg0: &Task) : u64 {
        arg0.deadline
    }

    entry fun dispute_task(arg0: &mut Task, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.creator || v0 == arg0.agent, 1);
        arg0.status = 3;
    }

    public fun is_active(arg0: &Task) : bool {
        arg0.status == 0 || arg0.status == 1
    }

    public fun reward_amount(arg0: &Task) : u64 {
        arg0.reward_amount
    }

    public fun status(arg0: &Task) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v6
}

