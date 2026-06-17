module 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::task {
    struct Task has key {
        id: 0x2::object::UID,
        poster: address,
        assigned_to: address,
        title: 0x1::string::String,
        spec_blob: 0x1::string::String,
        primary_capability: 0x1::string::String,
        bounty: 0x2::balance::Balance<0x2::sui::SUI>,
        posted_at_ms: u64,
        deadline_ms: u64,
        status: u8,
        deliverable_id: 0x1::option::Option<0x2::object::ID>,
        parent_policy: 0x1::option::Option<0x2::object::ID>,
    }

    struct TaskPosted has copy, drop {
        task_id: 0x2::object::ID,
        poster: address,
        assigned_to: address,
        title: 0x1::string::String,
        primary_capability: 0x1::string::String,
        bounty_amount: u64,
        deadline_ms: u64,
        parent_policy: 0x1::option::Option<0x2::object::ID>,
        posted_at_ms: u64,
    }

    struct TaskAccepted has copy, drop {
        task_id: 0x2::object::ID,
        agent: address,
        accepted_at_ms: u64,
    }

    struct TaskSubmitted has copy, drop {
        task_id: 0x2::object::ID,
        agent: address,
        deliverable_id: 0x2::object::ID,
        submitted_at_ms: u64,
    }

    struct TaskApproved has copy, drop {
        task_id: 0x2::object::ID,
        poster: address,
        agent: address,
        deliverable_id: 0x2::object::ID,
        bounty_amount: u64,
        primary_capability: 0x1::string::String,
        parent_policy: 0x1::option::Option<0x2::object::ID>,
        approved_at_ms: u64,
    }

    struct TaskExpired has copy, drop {
        task_id: 0x2::object::ID,
        poster: address,
        bounty_returned: u64,
        expired_at_ms: u64,
    }

    public fun accept(arg0: &mut Task, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.assigned_to, 2);
        assert!(arg0.status == 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 < arg0.deadline_ms, 4);
        arg0.status = 1;
        let v1 = TaskAccepted{
            task_id        : 0x2::object::id<Task>(arg0),
            agent          : arg0.assigned_to,
            accepted_at_ms : v0,
        };
        0x2::event::emit<TaskAccepted>(v1);
    }

    public fun approve_direct(arg0: &mut Task, arg1: &mut 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::AgentRegistration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.poster, 1);
        assert!(arg0.status == 2, 3);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.parent_policy), 10);
        assert!(0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::agent_address(arg1) == arg0.assigned_to, 7);
        settle_internal(arg0, arg1, arg2, arg3);
    }

    public fun approve_with_policy(arg0: &mut Task, arg1: &mut 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::operator_policy::OperatorPolicy, arg2: &mut 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::AgentRegistration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.poster, 1);
        assert!(arg0.status == 2, 3);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.parent_policy), 9);
        assert!(0x2::object::id<0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::operator_policy::OperatorPolicy>(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.parent_policy), 8);
        assert!(0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::agent_address(arg2) == arg0.assigned_to, 7);
        0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::operator_policy::record_spend(arg1, 0x2::balance::value<0x2::sui::SUI>(&arg0.bounty), arg0.primary_capability, arg3, arg4);
        settle_internal(arg0, arg2, arg3, arg4);
    }

    public fun assigned_to(arg0: &Task) : address {
        arg0.assigned_to
    }

    public fun bounty_amount(arg0: &Task) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bounty)
    }

    public fun deadline_ms(arg0: &Task) : u64 {
        arg0.deadline_ms
    }

    public fun deliverable_id(arg0: &Task) : &0x1::option::Option<0x2::object::ID> {
        &arg0.deliverable_id
    }

    public fun expire(arg0: &mut Task, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.status == 0) {
            true
        } else if (arg0.status == 1) {
            true
        } else {
            arg0.status == 2
        };
        assert!(v0, 3);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.deadline_ms, 5);
        let v2 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bounty);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg2), arg0.poster);
        arg0.status = 4;
        let v3 = TaskExpired{
            task_id         : 0x2::object::id<Task>(arg0),
            poster          : arg0.poster,
            bounty_returned : 0x2::balance::value<0x2::sui::SUI>(&v2),
            expired_at_ms   : v1,
        };
        0x2::event::emit<TaskExpired>(v3);
    }

    public fun parent_policy(arg0: &Task) : &0x1::option::Option<0x2::object::ID> {
        &arg0.parent_policy
    }

    public fun post(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg5 > v1, 6);
        let v2 = Task{
            id                 : 0x2::object::new(arg8),
            poster             : 0x2::tx_context::sender(arg8),
            assigned_to        : arg1,
            title              : arg2,
            spec_blob          : arg3,
            primary_capability : arg4,
            bounty             : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            posted_at_ms       : v1,
            deadline_ms        : arg5,
            status             : 0,
            deliverable_id     : 0x1::option::none<0x2::object::ID>(),
            parent_policy      : arg6,
        };
        let v3 = 0x2::object::id<Task>(&v2);
        let v4 = TaskPosted{
            task_id            : v3,
            poster             : v2.poster,
            assigned_to        : arg1,
            title              : v2.title,
            primary_capability : v2.primary_capability,
            bounty_amount      : v0,
            deadline_ms        : arg5,
            parent_policy      : arg6,
            posted_at_ms       : v1,
        };
        0x2::event::emit<TaskPosted>(v4);
        0x2::transfer::share_object<Task>(v2);
        v3
    }

    public fun posted_at_ms(arg0: &Task) : u64 {
        arg0.posted_at_ms
    }

    public fun poster(arg0: &Task) : address {
        arg0.poster
    }

    public fun primary_capability(arg0: &Task) : &0x1::string::String {
        &arg0.primary_capability
    }

    fun settle_internal(arg0: &mut Task, arg1: &mut 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::AgentRegistration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.bounty);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bounty), arg3), arg0.assigned_to);
        0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::settle_reputation_bump(arg1, v1, v0);
        arg0.status = 3;
        let v2 = TaskApproved{
            task_id            : 0x2::object::id<Task>(arg0),
            poster             : arg0.poster,
            agent              : arg0.assigned_to,
            deliverable_id     : *0x1::option::borrow<0x2::object::ID>(&arg0.deliverable_id),
            bounty_amount      : v1,
            primary_capability : arg0.primary_capability,
            parent_policy      : arg0.parent_policy,
            approved_at_ms     : v0,
        };
        0x2::event::emit<TaskApproved>(v2);
    }

    public fun spec_blob(arg0: &Task) : &0x1::string::String {
        &arg0.spec_blob
    }

    public fun status(arg0: &Task) : u8 {
        arg0.status
    }

    public fun status_accepted() : u8 {
        1
    }

    public fun status_approved() : u8 {
        3
    }

    public fun status_delivered() : u8 {
        2
    }

    public fun status_expired() : u8 {
        4
    }

    public fun status_open() : u8 {
        0
    }

    public fun submit(arg0: &mut Task, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.assigned_to, 2);
        assert!(arg0.status == 1, 3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg0.deadline_ms, 4);
        arg0.status = 2;
        arg0.deliverable_id = 0x1::option::some<0x2::object::ID>(arg1);
        let v1 = TaskSubmitted{
            task_id         : 0x2::object::id<Task>(arg0),
            agent           : arg0.assigned_to,
            deliverable_id  : arg1,
            submitted_at_ms : v0,
        };
        0x2::event::emit<TaskSubmitted>(v1);
    }

    public fun title(arg0: &Task) : &0x1::string::String {
        &arg0.title
    }

    // decompiled from Move bytecode v7
}

