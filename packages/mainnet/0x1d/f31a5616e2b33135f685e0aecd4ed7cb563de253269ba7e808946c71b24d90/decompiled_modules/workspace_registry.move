module 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::workspace_registry {
    struct WorkspaceCap has store, key {
        id: 0x2::object::UID,
    }

    struct EjectWrapper has key {
        id: 0x2::object::UID,
        originating_workspace_cap_id: 0x2::object::ID,
        originating_workspace_id: 0x2::object::ID,
        new_workspace_cap_id: 0x2::object::ID,
        approve_caps: vector<0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::approve_interface::ApproveCap>,
    }

    public fun create_workspace_cap(arg0: &mut 0x2::tx_context::TxContext) : WorkspaceCap {
        WorkspaceCap{id: 0x2::object::new(arg0)}
    }

    public fun eject(arg0: &WorkspaceCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::approve_interface::ApproveCap>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = EjectWrapper{
            id                           : 0x2::object::new(arg4),
            originating_workspace_cap_id : 0x2::object::id<WorkspaceCap>(arg0),
            originating_workspace_id     : arg1,
            new_workspace_cap_id         : arg2,
            approve_caps                 : arg3,
        };
        0x2::transfer::share_object<EjectWrapper>(v0);
    }

    public fun finalize_eject(arg0: EjectWrapper, arg1: &WorkspaceCap) : vector<0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::approve_interface::ApproveCap> {
        assert!(arg0.new_workspace_cap_id == 0x2::object::id<WorkspaceCap>(arg1), 0);
        let EjectWrapper {
            id                           : v0,
            originating_workspace_cap_id : _,
            originating_workspace_id     : _,
            new_workspace_cap_id         : _,
            approve_caps                 : v4,
        } = arg0;
        0x2::object::delete(v0);
        v4
    }

    public fun get_originating_workspace_cap_id(arg0: &EjectWrapper) : 0x2::object::ID {
        arg0.originating_workspace_cap_id
    }

    public fun get_originating_workspace_id(arg0: &EjectWrapper) : 0x2::object::ID {
        arg0.originating_workspace_id
    }

    public fun revert_eject(arg0: EjectWrapper, arg1: &WorkspaceCap) : vector<0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::approve_interface::ApproveCap> {
        assert!(arg0.originating_workspace_cap_id == 0x2::object::id<WorkspaceCap>(arg1), 0);
        let EjectWrapper {
            id                           : v0,
            originating_workspace_cap_id : _,
            originating_workspace_id     : _,
            new_workspace_cap_id         : _,
            approve_caps                 : v4,
        } = arg0;
        0x2::object::delete(v0);
        v4
    }

    // decompiled from Move bytecode v6
}

