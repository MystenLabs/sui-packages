module 0x4307327d839e5a8f3e6ea6f069ef9b2112577219be25668875d97deb35ec0193::minter_script {
    public fun create_lock_from_o_sail<T0, T1>(arg0: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T0>, arg1: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T1>(&arg3) > 0) {
            0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::create_lock_from_o_sail<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
    }

    public fun deposit_o_sail_into_lock<T0, T1>(arg0: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T0>, arg1: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T1>(&arg4) > 0) {
            0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::deposit_o_sail_into_lock<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        } else {
            0x2::coin::destroy_zero<T1>(arg4);
        };
    }

    // decompiled from Move bytecode v6
}

