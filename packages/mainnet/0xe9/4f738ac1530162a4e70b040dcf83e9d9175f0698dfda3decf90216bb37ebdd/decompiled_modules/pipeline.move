module 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::pipeline {
    struct Pipeline has store, key {
        id: 0x2::object::UID,
        document_id: 0x2::object::ID,
        creator: address,
        mode: u8,
        steps: vector<PipelineStep>,
        status: u8,
        created_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        completed_at_ms: u64,
    }

    struct PipelineStep has copy, drop, store {
        actor: address,
        action_type: u8,
        status: u8,
        permissions: 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::ActionPermissions,
        completed_at_ms: u64,
        result_data: vector<u8>,
        order: u64,
    }

    struct PipelineCreated has copy, drop {
        pipeline_id: 0x2::object::ID,
        document_id: 0x2::object::ID,
        creator: address,
        mode: u8,
        step_count: u64,
        created_at_ms: u64,
    }

    struct StepCompleted has copy, drop {
        pipeline_id: 0x2::object::ID,
        step_index: u64,
        actor: address,
        action_type: u8,
        timestamp: u64,
    }

    struct PipelineCompleted has copy, drop {
        pipeline_id: 0x2::object::ID,
        document_id: 0x2::object::ID,
        completed_at_ms: u64,
    }

    struct PipelineRejected has copy, drop {
        pipeline_id: 0x2::object::ID,
        rejector: address,
        timestamp: u64,
    }

    struct PipelineCancelled has copy, drop {
        pipeline_id: 0x2::object::ID,
        cancelled_by: address,
        timestamp: u64,
    }

    struct PipelineExpired has copy, drop {
        pipeline_id: 0x2::object::ID,
        expired_at_ms: u64,
    }

    public fun status_completed() : u8 {
        1
    }

    public fun cancel_pipeline(arg0: &mut Pipeline, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.status == 0, 4);
        arg0.status = 4;
        let v0 = PipelineCancelled{
            pipeline_id  : 0x2::object::id<Pipeline>(arg0),
            cancelled_by : 0x2::tx_context::sender(arg1),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<PipelineCancelled>(v0);
    }

    fun check_all_steps_completed(arg0: &Pipeline) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PipelineStep>(&arg0.steps)) {
            if (0x1::vector::borrow<PipelineStep>(&arg0.steps, v0).status != 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::status_completed()) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun check_and_mark_expired(arg0: &mut Pipeline, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_some<u64>(&arg0.expires_at_ms)) {
            let v0 = 0x2::clock::timestamp_ms(arg1);
            if (v0 > *0x1::option::borrow<u64>(&arg0.expires_at_ms) && arg0.status == 0) {
                arg0.status = 3;
                let v1 = PipelineExpired{
                    pipeline_id   : 0x2::object::id<Pipeline>(arg0),
                    expired_at_ms : v0,
                };
                0x2::event::emit<PipelineExpired>(v1);
            };
        };
    }

    public fun create_pipeline(arg0: 0x2::object::ID, arg1: u8, arg2: vector<address>, arg3: vector<u8>, arg4: vector<0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::ActionPermissions>, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : Pipeline {
        assert!(arg1 == 0 || arg1 == 1, 7);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 <= 50, 8);
        assert!(v0 == 0x1::vector::length<u8>(&arg3) && v0 == 0x1::vector::length<0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::ActionPermissions>(&arg4), 1);
        let v1 = 0x1::vector::empty<PipelineStep>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = PipelineStep{
                actor           : *0x1::vector::borrow<address>(&arg2, v2),
                action_type     : *0x1::vector::borrow<u8>(&arg3, v2),
                status          : 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::status_pending(),
                permissions     : *0x1::vector::borrow<0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::ActionPermissions>(&arg4, v2),
                completed_at_ms : 0,
                result_data     : 0x1::vector::empty<u8>(),
                order           : v2,
            };
            0x1::vector::push_back<PipelineStep>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = 0x2::object::new(arg6);
        let v5 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v6 = PipelineCreated{
            pipeline_id   : 0x2::object::uid_to_inner(&v4),
            document_id   : arg0,
            creator       : 0x2::tx_context::sender(arg6),
            mode          : arg1,
            step_count    : v0,
            created_at_ms : v5,
        };
        0x2::event::emit<PipelineCreated>(v6);
        Pipeline{
            id              : v4,
            document_id     : arg0,
            creator         : 0x2::tx_context::sender(arg6),
            mode            : arg1,
            steps           : v1,
            status          : 0,
            created_at_ms   : v5,
            expires_at_ms   : arg5,
            completed_at_ms : 0,
        }
    }

    public fun error_sequential_order_violation() : u64 {
        3
    }

    public fun execute_step(arg0: &mut Pipeline, arg1: u64, arg2: 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::ActionResult, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        check_and_mark_expired(arg0, arg3);
        assert!(arg0.status != 3, 6);
        assert!(arg1 < 0x1::vector::length<PipelineStep>(&arg0.steps), 1);
        if (arg0.mode == 0) {
            validate_sequential_order(arg0, arg1);
        };
        let v0 = 0x1::vector::borrow_mut<PipelineStep>(&mut arg0.steps, arg1);
        assert!(v0.status != 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::status_completed(), 2);
        assert!(v0.actor == 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::get_result_actor(&arg2), 1);
        v0.status = 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::get_result_status(&arg2);
        v0.completed_at_ms = 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::get_result_timestamp(&arg2);
        v0.result_data = 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::get_result_data(&arg2);
        let v1 = StepCompleted{
            pipeline_id : 0x2::object::id<Pipeline>(arg0),
            step_index  : arg1,
            actor       : v0.actor,
            action_type : v0.action_type,
            timestamp   : v0.completed_at_ms,
        };
        0x2::event::emit<StepCompleted>(v1);
        if (check_all_steps_completed(arg0)) {
            arg0.status = 1;
            arg0.completed_at_ms = 0x2::tx_context::epoch_timestamp_ms(arg4);
            let v2 = PipelineCompleted{
                pipeline_id     : 0x2::object::id<Pipeline>(arg0),
                document_id     : arg0.document_id,
                completed_at_ms : arg0.completed_at_ms,
            };
            0x2::event::emit<PipelineCompleted>(v2);
        };
    }

    public fun get_created_at(arg0: &Pipeline) : u64 {
        arg0.created_at_ms
    }

    public fun get_creator(arg0: &Pipeline) : address {
        arg0.creator
    }

    public fun get_document_id(arg0: &Pipeline) : 0x2::object::ID {
        arg0.document_id
    }

    public fun get_expires_at(arg0: &Pipeline) : 0x1::option::Option<u64> {
        arg0.expires_at_ms
    }

    public fun get_mode(arg0: &Pipeline) : u8 {
        arg0.mode
    }

    public fun get_pipeline_id(arg0: &Pipeline) : 0x2::object::ID {
        0x2::object::id<Pipeline>(arg0)
    }

    public fun get_status(arg0: &Pipeline) : u8 {
        arg0.status
    }

    public fun get_step(arg0: &Pipeline, arg1: u64) : PipelineStep {
        *0x1::vector::borrow<PipelineStep>(&arg0.steps, arg1)
    }

    public fun get_step_action_type(arg0: &PipelineStep) : u8 {
        arg0.action_type
    }

    public fun get_step_actor(arg0: &PipelineStep) : address {
        arg0.actor
    }

    public fun get_step_count(arg0: &Pipeline) : u64 {
        0x1::vector::length<PipelineStep>(&arg0.steps)
    }

    public fun get_step_order(arg0: &PipelineStep) : u64 {
        arg0.order
    }

    public fun get_step_status(arg0: &PipelineStep) : u8 {
        arg0.status
    }

    public fun is_expired(arg0: &Pipeline, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<u64>(&arg0.expires_at_ms) && 0x2::clock::timestamp_ms(arg1) > *0x1::option::borrow<u64>(&arg0.expires_at_ms)
    }

    public fun mode_parallel() : u8 {
        1
    }

    public fun mode_sequential() : u8 {
        0
    }

    public fun reject_pipeline(arg0: &mut Pipeline, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        assert!(arg1 < 0x1::vector::length<PipelineStep>(&arg0.steps), 1);
        let v0 = 0x1::vector::borrow<PipelineStep>(&arg0.steps, arg1);
        assert!(v0.actor == 0x2::tx_context::sender(arg2), 0);
        assert!(0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::get_permission_can_reject(&v0.permissions), 0);
        arg0.status = 2;
        let v1 = PipelineRejected{
            pipeline_id : 0x2::object::id<Pipeline>(arg0),
            rejector    : 0x2::tx_context::sender(arg2),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<PipelineRejected>(v1);
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_cancelled() : u8 {
        4
    }

    public fun status_expired() : u8 {
        3
    }

    public fun status_rejected() : u8 {
        2
    }

    fun validate_sequential_order(arg0: &Pipeline, arg1: u64) {
        let v0 = 0;
        while (v0 < arg1) {
            assert!(0x1::vector::borrow<PipelineStep>(&arg0.steps, v0).status == 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::actions::status_completed(), 3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

