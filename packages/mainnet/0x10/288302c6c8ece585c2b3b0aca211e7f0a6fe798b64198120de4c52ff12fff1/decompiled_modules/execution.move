module 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::execution {
    public fun execute(arg0: &mut 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::proposal::Proposal, arg1: &mut 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::timelock::Timelock, arg2: &mut 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::treasury::Treasury, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::proposal::is_active(arg0), 0);
        assert!(0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::timelock::proposal_id(arg1) == 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::proposal::id(arg0), 1);
        assert!(0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::timelock::is_ready(arg1, arg5), 2);
        0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::timelock::consume(arg1, arg5);
        0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::treasury::transfer(arg2, arg3, arg4, arg6);
        0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::proposal::mark_executed(arg0);
    }

    // decompiled from Move bytecode v6
}

