module 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions {
    struct ActionCap has store, key {
        id: 0x2::object::UID,
        pipeline_id: 0x2::object::ID,
        actor: address,
        action_type: u8,
        step_index: u64,
    }

    struct ActionResult has copy, drop, store {
        actor: address,
        action_type: u8,
        status: u8,
        data: vector<u8>,
        timestamp: u64,
    }

    struct ActionPermissions has copy, drop, store {
        can_read: bool,
        can_comment: bool,
        can_reject: bool,
    }

    struct ActionCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        pipeline_id: 0x2::object::ID,
        actor: address,
        action_type: u8,
        step_index: u64,
    }

    struct ActionExecuted has copy, drop {
        pipeline_id: 0x2::object::ID,
        actor: address,
        action_type: u8,
        status: u8,
        timestamp: u64,
    }

    public fun action_approve() : u8 {
        1
    }

    public fun action_review() : u8 {
        2
    }

    public fun action_sign() : u8 {
        0
    }

    public fun create_permissions(arg0: u8, arg1: bool) : ActionPermissions {
        ActionPermissions{
            can_read    : true,
            can_comment : true,
            can_reject  : arg1,
        }
    }

    public fun error_invalid_action_type() : u64 {
        0
    }

    public fun error_invalid_actor() : u64 {
        3
    }

    public fun execute_approve(arg0: &ActionCap, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : ActionResult {
        assert!(arg0.action_type == 1, 0);
        assert!(arg0.actor == 0x2::tx_context::sender(arg2), 3);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = ActionExecuted{
            pipeline_id : arg0.pipeline_id,
            actor       : arg0.actor,
            action_type : 1,
            status      : 1,
            timestamp   : v0,
        };
        0x2::event::emit<ActionExecuted>(v1);
        ActionResult{
            actor       : arg0.actor,
            action_type : 1,
            status      : 1,
            data        : arg1,
            timestamp   : v0,
        }
    }

    public fun execute_review(arg0: &ActionCap, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : ActionResult {
        assert!(arg0.action_type == 2, 0);
        assert!(arg0.actor == 0x2::tx_context::sender(arg2), 3);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = ActionExecuted{
            pipeline_id : arg0.pipeline_id,
            actor       : arg0.actor,
            action_type : 2,
            status      : 1,
            timestamp   : v0,
        };
        0x2::event::emit<ActionExecuted>(v1);
        ActionResult{
            actor       : arg0.actor,
            action_type : 2,
            status      : 1,
            data        : arg1,
            timestamp   : v0,
        }
    }

    public fun execute_sign(arg0: &ActionCap, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : ActionResult {
        assert!(arg0.action_type == 0, 0);
        assert!(arg0.actor == 0x2::tx_context::sender(arg2), 3);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = ActionExecuted{
            pipeline_id : arg0.pipeline_id,
            actor       : arg0.actor,
            action_type : 0,
            status      : 1,
            timestamp   : v0,
        };
        0x2::event::emit<ActionExecuted>(v1);
        ActionResult{
            actor       : arg0.actor,
            action_type : 0,
            status      : 1,
            data        : arg1,
            timestamp   : v0,
        }
    }

    public fun get_action_type(arg0: &ActionCap) : u8 {
        arg0.action_type
    }

    public fun get_actor(arg0: &ActionCap) : address {
        arg0.actor
    }

    public fun get_permission_can_reject(arg0: &ActionPermissions) : bool {
        arg0.can_reject
    }

    public fun get_pipeline_id(arg0: &ActionCap) : 0x2::object::ID {
        arg0.pipeline_id
    }

    public fun get_result_actor(arg0: &ActionResult) : address {
        arg0.actor
    }

    public fun get_result_data(arg0: &ActionResult) : vector<u8> {
        arg0.data
    }

    public fun get_result_status(arg0: &ActionResult) : u8 {
        arg0.status
    }

    public fun get_result_timestamp(arg0: &ActionResult) : u64 {
        arg0.timestamp
    }

    public fun get_step_index(arg0: &ActionCap) : u64 {
        arg0.step_index
    }

    fun is_valid_action_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    public fun issue_action_cap(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : ActionCap {
        assert!(is_valid_action_type(arg2), 0);
        let v0 = 0x2::object::new(arg4);
        let v1 = ActionCapIssued{
            cap_id      : 0x2::object::uid_to_inner(&v0),
            pipeline_id : arg0,
            actor       : arg1,
            action_type : arg2,
            step_index  : arg3,
        };
        0x2::event::emit<ActionCapIssued>(v1);
        ActionCap{
            id          : v0,
            pipeline_id : arg0,
            actor       : arg1,
            action_type : arg2,
            step_index  : arg3,
        }
    }

    public fun status_completed() : u8 {
        1
    }

    public fun status_pending() : u8 {
        0
    }

    public fun status_rejected() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

