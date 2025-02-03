module 0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::Vault<T0, T1, T2>, arg1: &0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::assert_current_version(arg1);
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg2);
    }

    public entry fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &mut 0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::assert_current_version(arg2);
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0, arg1, arg3);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::Vault<T0, T1, T2>, arg1: &0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::assert_current_version(arg1);
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

