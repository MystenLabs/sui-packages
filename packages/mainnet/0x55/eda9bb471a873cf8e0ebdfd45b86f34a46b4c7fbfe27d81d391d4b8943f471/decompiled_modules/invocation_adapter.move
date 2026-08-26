module 0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::invocation_adapter {
    public fun abort_expired(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimeAuthority, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::scheduler::runtime_permit(arg0);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::invocation_adapter::abort_expired<0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::era::RuntimeV1>(&v0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun lock_and_request(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimeAuthority, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg4: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg5: u64, arg6: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg7: 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::scheduler::runtime_permit(arg0);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::invocation_adapter::lock_and_request<0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::era::RuntimeV1>(&v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun settle(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimeAuthority, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg4: 0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>) {
        let v0 = 0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::scheduler::runtime_permit(arg0);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::invocation_adapter::settle<0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::era::RuntimeV1>(&v0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

