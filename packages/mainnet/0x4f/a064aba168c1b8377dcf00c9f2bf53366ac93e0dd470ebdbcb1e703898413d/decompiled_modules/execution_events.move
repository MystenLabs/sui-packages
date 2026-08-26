module 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_events {
    struct AgentVertexAuthorizationRequiredEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        tool_fqn: 0x1::ascii::String,
        agent_id: 0x1::option::Option<0x2::object::ID>,
        skill_id: 0x1::option::Option<u64>,
    }

    struct InvocationAuthorizationRequiredEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
    }

    struct RequestWalkExecutionEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        invocation: 0x2::object::ID,
        invoker: address,
        walk_index: u64,
        next_vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        evaluations: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        skill_id: u64,
        interface_version: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion,
        task_id: 0x2::object::ID,
        occurrence_id: u64,
    }

    struct AgentSkillExecutionRequestedEvent has copy, drop {
        execution_id: address,
        agent_id: 0x2::object::ID,
        skill_id: u64,
        interface_revision: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion,
        payment_id: address,
    }

    struct EndStateReachedEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        variant: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant,
        variant_ports_to_data: 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>,
    }

    struct WalkAdvancedEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        variant: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant,
        variant_ports_to_data: 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>,
    }

    struct WalkFailedEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        reason: 0x1::ascii::String,
    }

    struct TerminalErrEvalRecordedEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        leader: address,
        failure_class: 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_failure::WorkflowFailureClass,
        outcome: 0x1::option::Option<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>,
        reason: 0x1::ascii::String,
        err_eval_hash: vector<u8>,
        duplicate: bool,
    }

    struct SubmissionFailureEvidenceRecordedEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        failed_leader: address,
        winning_leader: 0x1::option::Option<address>,
        reason: 0x1::ascii::String,
        err_eval_hash: vector<u8>,
    }

    struct ToolVerificationResolvedEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        leader_cap_id: 0x2::object::ID,
        tool_id: 0x2::object::ID,
        verifier_kind: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ToolVerifierMode,
        verifier_witness_id: 0x1::option::Option<0x2::object::ID>,
        decision: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerifierDecision,
    }

    struct CommittedToolResultEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        leader: 0x2::object::ID,
        has_primary_failure_evidence: bool,
        has_secondary_failure_evidence: bool,
    }

    struct WalkCancelledEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
    }

    struct WalkAbortedEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
    }

    struct WalkPendingAbortEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        walk_index: u64,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
    }

    struct ExecutionFinishedEvent has copy, drop {
        dag: 0x2::object::ID,
        execution: 0x2::object::ID,
        has_any_walk_failed: bool,
        has_any_walk_succeeded: bool,
        was_aborted: bool,
    }

    struct ExecutionPaymentInsufficientSettlementEvent has copy, drop {
        execution: 0x2::object::ID,
        walk_index: u64,
        required_shortfall: u64,
    }

    struct ExecutionPaymentRefilledEvent has copy, drop {
        execution_id: address,
        payment_id: address,
        source: address,
        refill_amount: u64,
    }

    public(friend) fun emit_agent_skill_execution_requested(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion, arg4: address) {
        let v0 = AgentSkillExecutionRequestedEvent{
            execution_id       : arg0,
            agent_id           : arg1,
            skill_id           : arg2,
            interface_revision : arg3,
            payment_id         : arg4,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<AgentSkillExecutionRequestedEvent>(v0);
    }

    public(friend) fun emit_agent_vertex_authorization_required(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x1::ascii::String, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<u64>) {
        let v0 = AgentVertexAuthorizationRequiredEvent{
            dag        : arg0,
            execution  : arg1,
            walk_index : arg2,
            vertex     : arg3,
            tool_fqn   : arg4,
            agent_id   : arg5,
            skill_id   : arg6,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<AgentVertexAuthorizationRequiredEvent>(v0);
    }

    public(friend) fun emit_committed_tool_result(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x2::object::ID, arg5: bool, arg6: bool) {
        let v0 = CommittedToolResultEvent{
            dag                            : arg0,
            execution                      : arg1,
            walk_index                     : arg2,
            vertex                         : arg3,
            leader                         : arg4,
            has_primary_failure_evidence   : arg5,
            has_secondary_failure_evidence : arg6,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<CommittedToolResultEvent>(v0);
    }

    public(friend) fun emit_end_state_reached(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant, arg5: 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>) {
        let v0 = EndStateReachedEvent{
            dag                   : arg0,
            execution             : arg1,
            walk_index            : arg2,
            vertex                : arg3,
            variant               : arg4,
            variant_ports_to_data : arg5,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<EndStateReachedEvent>(v0);
    }

    public(friend) fun emit_execution_finished(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: bool, arg4: bool) {
        let v0 = ExecutionFinishedEvent{
            dag                    : arg0,
            execution              : arg1,
            has_any_walk_failed    : arg2,
            has_any_walk_succeeded : arg3,
            was_aborted            : arg4,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<ExecutionFinishedEvent>(v0);
    }

    public(friend) fun emit_execution_payment_insufficient_settlement(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ExecutionPaymentInsufficientSettlementEvent{
            execution          : arg0,
            walk_index         : arg1,
            required_shortfall : arg2,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<ExecutionPaymentInsufficientSettlementEvent>(v0);
    }

    public(friend) fun emit_execution_payment_refilled(arg0: address, arg1: address, arg2: address, arg3: u64) {
        let v0 = ExecutionPaymentRefilledEvent{
            execution_id  : arg0,
            payment_id    : arg1,
            source        : arg2,
            refill_amount : arg3,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<ExecutionPaymentRefilledEvent>(v0);
    }

    public(friend) fun emit_submission_failure_evidence_recorded(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: address, arg5: 0x1::option::Option<address>, arg6: 0x1::ascii::String, arg7: vector<u8>) {
        let v0 = SubmissionFailureEvidenceRecordedEvent{
            dag            : arg0,
            execution      : arg1,
            walk_index     : arg2,
            vertex         : arg3,
            failed_leader  : arg4,
            winning_leader : arg5,
            reason         : arg6,
            err_eval_hash  : arg7,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<SubmissionFailureEvidenceRecordedEvent>(v0);
    }

    public(friend) fun emit_terminal_err_eval_recorded(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: address, arg5: 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_failure::WorkflowFailureClass, arg6: 0x1::option::Option<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>, arg7: 0x1::ascii::String, arg8: vector<u8>, arg9: bool) {
        let v0 = TerminalErrEvalRecordedEvent{
            dag           : arg0,
            execution     : arg1,
            walk_index    : arg2,
            vertex        : arg3,
            leader        : arg4,
            failure_class : arg5,
            outcome       : arg6,
            reason        : arg7,
            err_eval_hash : arg8,
            duplicate     : arg9,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<TerminalErrEvalRecordedEvent>(v0);
    }

    public(friend) fun emit_tool_verification_resolved(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ToolVerifierMode, arg7: 0x1::option::Option<0x2::object::ID>, arg8: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerifierDecision) {
        let v0 = ToolVerificationResolvedEvent{
            dag                 : arg0,
            execution           : arg1,
            walk_index          : arg2,
            vertex              : arg3,
            leader_cap_id       : arg4,
            tool_id             : arg5,
            verifier_kind       : arg6,
            verifier_witness_id : arg7,
            decision            : arg8,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<ToolVerificationResolvedEvent>(v0);
    }

    public(friend) fun emit_walk_aborted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex) {
        let v0 = WalkAbortedEvent{
            dag        : arg0,
            execution  : arg1,
            walk_index : arg2,
            vertex     : arg3,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<WalkAbortedEvent>(v0);
    }

    public(friend) fun emit_walk_advanced(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant, arg5: 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>) {
        let v0 = WalkAdvancedEvent{
            dag                   : arg0,
            execution             : arg1,
            walk_index            : arg2,
            vertex                : arg3,
            variant               : arg4,
            variant_ports_to_data : arg5,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<WalkAdvancedEvent>(v0);
    }

    public(friend) fun emit_walk_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex) {
        let v0 = WalkCancelledEvent{
            dag        : arg0,
            execution  : arg1,
            walk_index : arg2,
            vertex     : arg3,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<WalkCancelledEvent>(v0);
    }

    public(friend) fun emit_walk_failed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x1::ascii::String) {
        let v0 = WalkFailedEvent{
            dag        : arg0,
            execution  : arg1,
            walk_index : arg2,
            vertex     : arg3,
            reason     : arg4,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<WalkFailedEvent>(v0);
    }

    public(friend) fun emit_walk_pending_abort(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex) {
        let v0 = WalkPendingAbortEvent{
            dag        : arg0,
            execution  : arg1,
            walk_index : arg2,
            vertex     : arg3,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<WalkPendingAbortEvent>(v0);
    }

    public(friend) fun invocation_authorization_required_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex) : InvocationAuthorizationRequiredEvent {
        InvocationAuthorizationRequiredEvent{
            dag        : arg0,
            execution  : arg1,
            walk_index : arg2,
            vertex     : arg3,
        }
    }

    public(friend) fun request_walk_execution_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: u64, arg9: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion, arg10: 0x2::object::ID, arg11: u64) : RequestWalkExecutionEvent {
        RequestWalkExecutionEvent{
            dag               : arg0,
            execution         : arg1,
            invocation        : arg2,
            invoker           : arg3,
            walk_index        : arg4,
            next_vertex       : arg5,
            evaluations       : arg6,
            agent_id          : arg7,
            skill_id          : arg8,
            interface_version : arg9,
            task_id           : arg10,
            occurrence_id     : arg11,
        }
    }

    public fun request_walk_execution_event_dag_id(arg0: &RequestWalkExecutionEvent) : 0x2::object::ID {
        arg0.dag
    }

    public fun request_walk_execution_event_invocation(arg0: &RequestWalkExecutionEvent) : 0x2::object::ID {
        arg0.invocation
    }

    // decompiled from Move bytecode v7
}

