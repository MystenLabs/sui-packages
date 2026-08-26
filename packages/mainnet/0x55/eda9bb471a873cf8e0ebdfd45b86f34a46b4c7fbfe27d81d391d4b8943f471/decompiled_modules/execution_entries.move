module 0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::execution_entries {
    public fun start_and_share(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimeAuthority, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::scheduler::runtime_permit(arg0);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_entries::start_and_share<0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::era::RuntimeV1>(&v0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun start_execution(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimeAuthority, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::scheduler::runtime_permit(arg0);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_entries::start_execution<0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::era::RuntimeV1>(&v0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

