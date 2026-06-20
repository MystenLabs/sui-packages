module 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::workspace {
    struct Workspace has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        owner: address,
        tasks_blob: 0x1::string::String,
        bus_blob: 0x1::string::String,
        loops_blob: 0x1::string::String,
        delegates: 0x2::vec_set::VecSet<address>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct WorkspaceCreated has copy, drop {
        workspace_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct WorkspaceTasksSet has copy, drop {
        workspace_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct WorkspaceBusSet has copy, drop {
        workspace_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct WorkspaceLoopsSet has copy, drop {
        workspace_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct DelegateGranted has copy, drop {
        workspace_id: 0x2::object::ID,
        delegate: address,
        timestamp_ms: u64,
    }

    struct DelegateRevoked has copy, drop {
        workspace_id: 0x2::object::ID,
        delegate: address,
        timestamp_ms: u64,
    }

    public fun bus_blob(arg0: &Workspace) : 0x1::string::String {
        arg0.bus_blob
    }

    public fun can_access(arg0: &Workspace, arg1: address) : bool {
        arg1 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.delegates, &arg1)
    }

    public fun create_workspace(arg0: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::Account, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::object::id<0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::Account>(arg0);
        let v2 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account::owner(arg0);
        let v3 = Workspace{
            id            : 0x2::object::new(arg2),
            account_id    : v1,
            owner         : v2,
            tasks_blob    : 0x1::string::utf8(b""),
            bus_blob      : 0x1::string::utf8(b""),
            loops_blob    : 0x1::string::utf8(b""),
            delegates     : 0x2::vec_set::empty<address>(),
            created_at_ms : v0,
            updated_at_ms : v0,
        };
        let v4 = WorkspaceCreated{
            workspace_id : 0x2::object::id<Workspace>(&v3),
            account_id   : v1,
            owner        : v2,
        };
        0x2::event::emit<WorkspaceCreated>(v4);
        0x2::transfer::share_object<Workspace>(v3);
    }

    public fun executor_set_bus(arg0: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::AccessRegistry, arg1: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::ExecutorCap, arg2: &mut Workspace, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::assert_executor(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.bus_blob = arg3;
        arg2.updated_at_ms = v0;
        let v1 = WorkspaceBusSet{
            workspace_id : 0x2::object::id<Workspace>(arg2),
            timestamp_ms : v0,
        };
        0x2::event::emit<WorkspaceBusSet>(v1);
    }

    public fun executor_set_loops(arg0: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::AccessRegistry, arg1: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::ExecutorCap, arg2: &mut Workspace, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::assert_executor(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.loops_blob = arg3;
        arg2.updated_at_ms = v0;
        let v1 = WorkspaceLoopsSet{
            workspace_id : 0x2::object::id<Workspace>(arg2),
            timestamp_ms : v0,
        };
        0x2::event::emit<WorkspaceLoopsSet>(v1);
    }

    public fun executor_set_tasks(arg0: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::AccessRegistry, arg1: &0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::ExecutorCap, arg2: &mut Workspace, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access::assert_executor(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.tasks_blob = arg3;
        arg2.updated_at_ms = v0;
        let v1 = WorkspaceTasksSet{
            workspace_id : 0x2::object::id<Workspace>(arg2),
            timestamp_ms : v0,
        };
        0x2::event::emit<WorkspaceTasksSet>(v1);
    }

    public fun grant_delegate(arg0: &mut Workspace, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_insert<address>(&mut arg0.delegates, arg1)) {
            let v0 = 0x2::clock::timestamp_ms(arg2);
            arg0.updated_at_ms = v0;
            let v1 = DelegateGranted{
                workspace_id : 0x2::object::id<Workspace>(arg0),
                delegate     : arg1,
                timestamp_ms : v0,
            };
            0x2::event::emit<DelegateGranted>(v1);
        };
    }

    public fun is_delegate(arg0: &Workspace, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.delegates, &arg1)
    }

    public fun loops_blob(arg0: &Workspace) : 0x1::string::String {
        arg0.loops_blob
    }

    public fun owner_set_bus(arg0: &mut Workspace, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.bus_blob = arg1;
        arg0.updated_at_ms = v0;
        let v1 = WorkspaceBusSet{
            workspace_id : 0x2::object::id<Workspace>(arg0),
            timestamp_ms : v0,
        };
        0x2::event::emit<WorkspaceBusSet>(v1);
    }

    public fun owner_set_loops(arg0: &mut Workspace, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.loops_blob = arg1;
        arg0.updated_at_ms = v0;
        let v1 = WorkspaceLoopsSet{
            workspace_id : 0x2::object::id<Workspace>(arg0),
            timestamp_ms : v0,
        };
        0x2::event::emit<WorkspaceLoopsSet>(v1);
    }

    public fun owner_set_tasks(arg0: &mut Workspace, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.tasks_blob = arg1;
        arg0.updated_at_ms = v0;
        let v1 = WorkspaceTasksSet{
            workspace_id : 0x2::object::id<Workspace>(arg0),
            timestamp_ms : v0,
        };
        0x2::event::emit<WorkspaceTasksSet>(v1);
    }

    public fun revoke_delegate(arg0: &mut Workspace, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_remove<address>(&mut arg0.delegates, arg1)) {
            let v0 = 0x2::clock::timestamp_ms(arg2);
            arg0.updated_at_ms = v0;
            let v1 = DelegateRevoked{
                workspace_id : 0x2::object::id<Workspace>(arg0),
                delegate     : arg1,
                timestamp_ms : v0,
            };
            0x2::event::emit<DelegateRevoked>(v1);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Workspace, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.owner || 0x2::vec_set::contains<address>(&arg1.delegates, &v0), 2);
        let v1 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::id_bytes(0x2::object::id<Workspace>(arg1));
        assert!(0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::bytes_start_with(&arg0, &v1), 3);
    }

    public fun tasks_blob(arg0: &Workspace) : 0x1::string::String {
        arg0.tasks_blob
    }

    public fun ws_account(arg0: &Workspace) : 0x2::object::ID {
        arg0.account_id
    }

    public fun ws_owner(arg0: &Workspace) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

