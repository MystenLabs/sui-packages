module 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::invocation_adapter {
    struct InvocationLockedEvent has copy, drop {
        execution: 0x2::object::ID,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        tool: 0x2::object::ID,
        tool_fqn: 0x1::ascii::String,
        cashier: 0x2::object::ID,
        invocation: 0x2::object::ID,
        beneficiary: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind,
        policy: 0x1::type_name::TypeName,
        sources: vector<0x2::object::ID>,
        amount: u64,
    }

    struct InvocationSettledEvent has copy, drop {
        execution: 0x2::object::ID,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex,
        tool: 0x2::object::ID,
        tool_fqn: 0x1::ascii::String,
        cashier: 0x2::object::ID,
        invocation: 0x2::object::ID,
        beneficiary: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind,
        policy: 0x1::type_name::TypeName,
        sources: vector<0x2::object::ID>,
        amount: u64,
        was_refunded: bool,
    }

    fun resolve(arg0: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg1: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg3: 0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>, arg4: bool) {
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_is_for(arg1, arg0);
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_runtime_vertex_tool_fqn(arg0, arg2);
        let v1 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_id(arg0, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg2));
        let v2 = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::payment_vertex_key(arg1, arg2, v0);
        let v3 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::receive(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::uid_mut(arg1), arg3);
        let v4 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::id(&v3);
        let v5 = 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg1);
        let v6 = if (0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::execution_id(&v3) == 0x2::object::id_to_address(&v5)) {
            if (0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::vertex_key(&v3) == v2) {
                0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::tool(&v3) == v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 13906835273855270917);
        let (v7, v8) = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::settle_invocation(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_payment_mut_ref(arg1), v2, v4, arg4);
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::resolve(v3, v7, v8);
        let v9 = InvocationSettledEvent{
            execution    : 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg1),
            vertex       : arg2,
            tool         : v1,
            tool_fqn     : v0,
            cashier      : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::cashier(&v3),
            invocation   : v4,
            beneficiary  : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::beneficiary(&v3),
            policy       : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::policy(&v3),
            sources      : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::sources(&v3),
            amount       : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::amount(&v3),
            was_refunded : arg4,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<InvocationSettledEvent>(v9);
    }

    public fun abort_expired<T0>(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimePermit<T0>, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::expired_active_walk_vertices_for_tool(arg2, arg1, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_runtime_vertex_tool_fqn(arg1, arg3), arg5);
        assert!(0x1::vector::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex>(&v0, &arg3), 13906835149301481481);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::pop_pending_payment_settlement(arg2, arg3);
        resolve(arg1, arg2, arg3, arg4, true);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::apply_abort_expired_execution_for_unlocked_vertex(arg1, arg2, arg3, arg5, arg6);
    }

    fun assert_cashier_is_for_vertex(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex) {
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::tool_fqn(arg0) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_runtime_vertex_tool_fqn(arg1, arg2) && 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::tool(arg0) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_id(arg1, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg2)), 13906835458538733571);
    }

    fun assert_vertex_can_authorize(arg0: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg1: &0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex) {
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_is_for(arg1, arg0);
        assert!(!0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_is_finished(arg1), 13906835424178864129);
        assert!(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_is_vertex_invoked(arg1, &arg2), 13906835428474486795);
    }

    public fun is_locked(arg0: &0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg2: 0x1::ascii::String) : bool {
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::invocation_locked(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_payment_ref(arg0), 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::payment_vertex_key(arg0, arg1, arg2))
    }

    fun lock(arg0: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg1: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg3: 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation) {
        assert_vertex_can_authorize(arg0, arg1, arg2);
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_runtime_vertex_tool_fqn(arg0, arg2);
        let v1 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_id(arg0, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg2));
        let v2 = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::payment_vertex_key(arg1, arg2, v0);
        let v3 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::id(&arg3);
        let v4 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::amount(&arg3);
        let v5 = 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg1);
        let v6 = if (0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::execution_id(&arg3) == 0x2::object::id_to_address(&v5)) {
            if (0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::vertex_key(&arg3) == v2) {
                0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::tool(&arg3) == v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 13906834835768606725);
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::place(arg3, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::lock_invocation(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_payment_mut_ref(arg1), v2, v3, v4));
        let v7 = InvocationLockedEvent{
            execution   : 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg1),
            vertex      : arg2,
            tool        : v1,
            tool_fqn    : v0,
            cashier     : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::cashier(&arg3),
            invocation  : v3,
            beneficiary : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::beneficiary(&arg3),
            policy      : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::policy(&arg3),
            sources     : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::sources(&arg3),
            amount      : v4,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<InvocationLockedEvent>(v7);
    }

    public fun lock_and_request<T0>(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimePermit<T0>, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg4: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg5: u64, arg6: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg7: 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_current_leader_cap(arg3, arg4);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_active(arg3, 0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg4));
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_transaction_budget(arg3, arg8);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_network_matches_leader_cap(arg2, arg4);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_network_matches_leader_registry(arg2, arg3);
        assert!(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::walk_is_active(arg2, arg5), 13906834663970308107);
        let (v0, _, _) = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::active_walk_submission_context(arg2, arg5);
        assert!(v0 == arg6, 13906834672560242699);
        lock(arg1, arg2, arg6, arg7);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::consume_verified_submission_payment(arg2, arg8, arg10);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::mark_walk_request_emitted_in_tx(arg2, arg10);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::request_normal_walk_execution(arg1, arg2, arg3, arg5, 0x2::clock::timestamp_ms(arg9), arg10);
        assert!(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::walk_request_authority_is_for_vertex(arg2, arg5, arg6), 13906834732689522695);
    }

    public fun new_request(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: &0x2::clock::Clock) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::InvocationRequest {
        assert_vertex_can_authorize(arg1, arg2, arg3);
        assert_cashier_is_for_vertex(arg0, arg1, arg3);
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_runtime_vertex_tool_fqn(arg1, arg3);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::new_invocation_request(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_payment_ref(arg2), 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::payment_vertex_key(arg2, arg3, v0), 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::tool(arg0), 0x1::ascii::into_bytes(v0), 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), arg4)
    }

    public fun settle<T0>(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimePermit<T0>, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>) {
        if (!0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::has_pending_payment_settlement(arg2, &arg3)) {
            return
        };
        let v0 = 0x1::option::destroy_some<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_failure::VertexPaymentSettlement>(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::pop_pending_payment_settlement(arg2, arg3));
        resolve(arg1, arg2, arg3, arg4, 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_failure::vertex_payment_settlement_is_refund(&v0));
    }

    // decompiled from Move bytecode v7
}

