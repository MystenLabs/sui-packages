module 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::approve_interface {
    struct ApproveCap has store, key {
        id: 0x2::object::UID,
        module_id: 0x2::object::ID,
    }

    struct ApproveModuleCap has store, key {
        id: 0x2::object::UID,
    }

    struct ApproveModuleCapCreated has copy, drop {
        cap_holder_id: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct InitApproveModuleRequest {
        approve_cap_id: 0x2::object::ID,
        workspace_id: 0x2::object::ID,
        module_id: 0x2::object::ID,
        user_id: u16,
    }

    struct ApproveRequest {
        approve_cap_id: 0x2::object::ID,
        module_id: 0x2::object::ID,
        workspace_id: 0x2::object::ID,
        vault_id: u16,
        calling_user_id: u16,
        messages: vector<vector<u8>>,
    }

    public fun consume_approve_request(arg0: &ApproveModuleCap, arg1: ApproveRequest) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, u16, u16, vector<vector<u8>>) {
        let ApproveRequest {
            approve_cap_id  : v0,
            module_id       : v1,
            workspace_id    : v2,
            vault_id        : v3,
            calling_user_id : v4,
            messages        : v5,
        } = arg1;
        assert!(0x2::object::id<ApproveModuleCap>(arg0) == v1, 1);
        (v0, v1, v2, v3, v4, v5)
    }

    public fun consume_init_approve_module_request(arg0: &ApproveModuleCap, arg1: InitApproveModuleRequest) : (0x2::object::ID, 0x2::object::ID, u16) {
        let InitApproveModuleRequest {
            approve_cap_id : v0,
            workspace_id   : v1,
            module_id      : v2,
            user_id        : v3,
        } = arg1;
        assert!(0x2::object::id<ApproveModuleCap>(arg0) == v2, 1);
        (v0, v1, v3)
    }

    public(friend) fun create_approve_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : ApproveCap {
        ApproveCap{
            id        : 0x2::object::new(arg1),
            module_id : arg0,
        }
    }

    public fun create_approve_module_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : ApproveModuleCap {
        let v0 = ApproveModuleCap{id: 0x2::object::new(arg1)};
        let v1 = ApproveModuleCapCreated{
            cap_holder_id : arg0,
            cap           : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<ApproveModuleCapCreated>(v1);
        v0
    }

    public(friend) fun create_approve_request(arg0: &ApproveCap, arg1: 0x2::object::ID, arg2: u16, arg3: u16, arg4: vector<vector<u8>>) : ApproveRequest {
        ApproveRequest{
            approve_cap_id  : 0x2::object::id<ApproveCap>(arg0),
            module_id       : arg0.module_id,
            workspace_id    : arg1,
            vault_id        : arg2,
            calling_user_id : arg3,
            messages        : arg4,
        }
    }

    public(friend) fun create_init_approve_module_request(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u16) : InitApproveModuleRequest {
        InitApproveModuleRequest{
            approve_cap_id : arg0,
            workspace_id   : arg2,
            module_id      : arg1,
            user_id        : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

