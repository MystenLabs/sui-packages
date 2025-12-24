module 0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::execution {
    public fun execute(arg0: &mut 0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::proposal::Proposal, arg1: &mut 0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::timelock::Timelock, arg2: &mut 0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::treasury::Treasury, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::proposal::is_active(arg0), 0);
        assert!(0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::timelock::proposal_id(arg1) == 0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::proposal::id(arg0), 1);
        assert!(0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::timelock::is_ready(arg1, arg5), 2);
        0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::timelock::consume(arg1, arg5);
        0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::treasury::transfer(arg2, arg3, arg4, arg6);
        0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::proposal::mark_executed(arg0);
    }

    // decompiled from Move bytecode v6
}

