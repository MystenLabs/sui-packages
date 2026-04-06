module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::workflow {
    struct WorkflowAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WorkflowAgentCap has store, key {
        id: 0x2::object::UID,
        agent_name: 0x1::string::String,
        allowed_actions: u64,
    }

    struct WorkflowRecord has store, key {
        id: 0x2::object::UID,
        version: u64,
        template_id: 0x1::string::String,
        status: u8,
        step_count: u64,
        total_steps_planned: u64,
        owner: address,
        machine_id: 0x1::string::String,
        memwal_namespace: 0x1::string::String,
        commit_hash: 0x1::string::String,
        quilt_blob_id: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
        completed_at: u64,
        total_duration_ms: u64,
    }

    struct StepRecord has copy, drop, store {
        step_id: 0x1::string::String,
        agent_id: 0x1::string::String,
        status: u8,
        started_at: u64,
        completed_at: u64,
        duration_ms: u64,
        output_ref: 0x1::string::String,
        output_type: u8,
        output_size: u64,
        model_used: 0x1::string::String,
        error_message: 0x1::string::String,
    }

    struct WorkflowCreated has copy, drop {
        workflow_id: 0x2::object::ID,
        template_id: 0x1::string::String,
        owner: address,
        machine_id: 0x1::string::String,
        memwal_namespace: 0x1::string::String,
        total_steps_planned: u64,
        timestamp: u64,
    }

    struct StepRecorded has copy, drop {
        workflow_id: 0x2::object::ID,
        step_index: u64,
        step_id: 0x1::string::String,
        agent_id: 0x1::string::String,
        status: u8,
        output_ref: 0x1::string::String,
        output_type: u8,
        duration_ms: u64,
        model_used: 0x1::string::String,
        timestamp: u64,
    }

    struct WorkflowStatusChanged has copy, drop {
        workflow_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
        total_steps: u64,
        total_duration_ms: u64,
        commit_hash: 0x1::string::String,
        timestamp: u64,
    }

    struct WorkflowFailed has copy, drop {
        workflow_id: 0x2::object::ID,
        failed_step_index: u64,
        error_message: 0x1::string::String,
        timestamp: u64,
    }

    struct QuiltArchived has copy, drop {
        workflow_id: 0x2::object::ID,
        quilt_blob_id: 0x1::string::String,
        event_count: u64,
        timestamp: u64,
    }

    public fun agent_cap_name(arg0: &WorkflowAgentCap) : 0x1::string::String {
        arg0.agent_name
    }

    public fun complete_workflow(arg0: &mut WorkflowRecord, arg1: &WorkflowAgentCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(arg0.status == 1, 102);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.status = 2;
        arg0.commit_hash = arg2;
        arg0.completed_at = v0;
        arg0.updated_at = v0;
        arg0.total_duration_ms = v0 - arg0.created_at;
        let v1 = WorkflowStatusChanged{
            workflow_id       : 0x2::object::id<WorkflowRecord>(arg0),
            old_status        : arg0.status,
            new_status        : 2,
            total_steps       : arg0.step_count,
            total_duration_ms : arg0.total_duration_ms,
            commit_hash       : arg0.commit_hash,
            timestamp         : v0,
        };
        0x2::event::emit<WorkflowStatusChanged>(v1);
    }

    entry fun create_and_transfer_workflow(arg0: &WorkflowAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = create_workflow(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::transfer<WorkflowRecord>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun create_workflow(arg0: &WorkflowAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : WorkflowRecord {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = WorkflowRecord{
            id                  : 0x2::object::new(arg6),
            version             : 1,
            template_id         : arg1,
            status              : 1,
            step_count          : 0,
            total_steps_planned : arg4,
            owner               : v1,
            machine_id          : arg2,
            memwal_namespace    : arg3,
            commit_hash         : 0x1::string::utf8(b""),
            quilt_blob_id       : 0x1::string::utf8(b""),
            created_at          : v0,
            updated_at          : v0,
            completed_at        : 0,
            total_duration_ms   : 0,
        };
        let v3 = WorkflowCreated{
            workflow_id         : 0x2::object::id<WorkflowRecord>(&v2),
            template_id         : v2.template_id,
            owner               : v1,
            machine_id          : v2.machine_id,
            memwal_namespace    : v2.memwal_namespace,
            total_steps_planned : arg4,
            timestamp           : v0,
        };
        0x2::event::emit<WorkflowCreated>(v3);
        v2
    }

    public fun fail_workflow(arg0: &mut WorkflowRecord, arg1: &WorkflowAgentCap, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        assert!(arg0.status == 1, 102);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.status = 3;
        arg0.completed_at = v0;
        arg0.updated_at = v0;
        arg0.total_duration_ms = v0 - arg0.created_at;
        let v1 = WorkflowFailed{
            workflow_id       : 0x2::object::id<WorkflowRecord>(arg0),
            failed_step_index : arg2,
            error_message     : arg3,
            timestamp         : v0,
        };
        0x2::event::emit<WorkflowFailed>(v1);
        let v2 = WorkflowStatusChanged{
            workflow_id       : 0x2::object::id<WorkflowRecord>(arg0),
            old_status        : arg0.status,
            new_status        : 3,
            total_steps       : arg0.step_count,
            total_duration_ms : arg0.total_duration_ms,
            commit_hash       : arg0.commit_hash,
            timestamp         : v0,
        };
        0x2::event::emit<WorkflowStatusChanged>(v2);
    }

    public fun get_commit_hash(arg0: &WorkflowRecord) : 0x1::string::String {
        arg0.commit_hash
    }

    public fun get_completed_at(arg0: &WorkflowRecord) : u64 {
        arg0.completed_at
    }

    public fun get_created_at(arg0: &WorkflowRecord) : u64 {
        arg0.created_at
    }

    public fun get_machine_id(arg0: &WorkflowRecord) : 0x1::string::String {
        arg0.machine_id
    }

    public fun get_memwal_namespace(arg0: &WorkflowRecord) : 0x1::string::String {
        arg0.memwal_namespace
    }

    public fun get_owner(arg0: &WorkflowRecord) : address {
        arg0.owner
    }

    public fun get_quilt_blob_id(arg0: &WorkflowRecord) : 0x1::string::String {
        arg0.quilt_blob_id
    }

    public fun get_status(arg0: &WorkflowRecord) : u8 {
        arg0.status
    }

    public fun get_step(arg0: &WorkflowRecord, arg1: u64) : StepRecord {
        *0x2::dynamic_field::borrow<u64, StepRecord>(&arg0.id, arg1)
    }

    public fun get_step_count(arg0: &WorkflowRecord) : u64 {
        arg0.step_count
    }

    public fun get_template_id(arg0: &WorkflowRecord) : 0x1::string::String {
        arg0.template_id
    }

    public fun get_total_duration_ms(arg0: &WorkflowRecord) : u64 {
        arg0.total_duration_ms
    }

    public fun get_total_steps_planned(arg0: &WorkflowRecord) : u64 {
        arg0.total_steps_planned
    }

    public fun has_step(arg0: &WorkflowRecord, arg1: u64) : bool {
        0x2::dynamic_field::exists_<u64>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkflowAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<WorkflowAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_completed(arg0: &WorkflowRecord) : bool {
        arg0.status == 2
    }

    public fun is_failed(arg0: &WorkflowRecord) : bool {
        arg0.status == 3
    }

    public fun is_running(arg0: &WorkflowRecord) : bool {
        arg0.status == 1
    }

    public fun mint_agent_cap(arg0: &WorkflowAdminCap, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkflowAgentCap{
            id              : 0x2::object::new(arg4),
            agent_name      : arg1,
            allowed_actions : arg2,
        };
        0x2::transfer::transfer<WorkflowAgentCap>(v0, arg3);
    }

    entry fun mint_and_transfer_agent_cap(arg0: &WorkflowAdminCap, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        mint_agent_cap(arg0, arg1, arg2, arg3, arg4);
    }

    public fun record_quilt_archive(arg0: &mut WorkflowRecord, arg1: &WorkflowAdminCap, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.quilt_blob_id = arg2;
        arg0.updated_at = v0;
        let v1 = QuiltArchived{
            workflow_id   : 0x2::object::id<WorkflowRecord>(arg0),
            quilt_blob_id : arg2,
            event_count   : arg3,
            timestamp     : v0,
        };
        0x2::event::emit<QuiltArchived>(v1);
    }

    public fun record_step(arg0: &mut WorkflowRecord, arg1: &WorkflowAgentCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: u8, arg9: u64, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: &0x2::clock::Clock) {
        assert!(arg0.status == 1, 102);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = arg0.step_count;
        assert!(!0x2::dynamic_field::exists_<u64>(&arg0.id, v1), 103);
        let v2 = StepRecord{
            step_id       : arg2,
            agent_id      : arg3,
            status        : arg4,
            started_at    : arg5,
            completed_at  : v0,
            duration_ms   : arg6,
            output_ref    : arg7,
            output_type   : arg8,
            output_size   : arg9,
            model_used    : arg10,
            error_message : arg11,
        };
        0x2::dynamic_field::add<u64, StepRecord>(&mut arg0.id, v1, v2);
        arg0.step_count = v1 + 1;
        arg0.updated_at = v0;
        let v3 = StepRecorded{
            workflow_id : 0x2::object::id<WorkflowRecord>(arg0),
            step_index  : v1,
            step_id     : v2.step_id,
            agent_id    : v2.agent_id,
            status      : v2.status,
            output_ref  : v2.output_ref,
            output_type : v2.output_type,
            duration_ms : v2.duration_ms,
            model_used  : v2.model_used,
            timestamp   : v0,
        };
        0x2::event::emit<StepRecorded>(v3);
    }

    public fun step_agent_id(arg0: &StepRecord) : 0x1::string::String {
        arg0.agent_id
    }

    public fun step_duration_ms(arg0: &StepRecord) : u64 {
        arg0.duration_ms
    }

    public fun step_id(arg0: &StepRecord) : 0x1::string::String {
        arg0.step_id
    }

    public fun step_model_used(arg0: &StepRecord) : 0x1::string::String {
        arg0.model_used
    }

    public fun step_output_ref(arg0: &StepRecord) : 0x1::string::String {
        arg0.output_ref
    }

    public fun step_output_type(arg0: &StepRecord) : u8 {
        arg0.output_type
    }

    public fun step_status(arg0: &StepRecord) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v7
}

