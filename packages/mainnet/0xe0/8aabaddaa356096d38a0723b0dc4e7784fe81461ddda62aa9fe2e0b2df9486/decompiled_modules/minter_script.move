module 0xe08aabaddaa356096d38a0723b0dc4e7784fe81461ddda62aa9fe2e0b2df9486::minter_script {
    public fun deposit_o_sail_into_lock<T0, T1>(arg0: &mut 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::Minter<T0>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::distribution_config::DistributionConfig, arg3: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T1>(&arg4) > 0) {
            0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::deposit_o_sail_into_lock<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        } else {
            0x2::coin::destroy_zero<T1>(arg4);
        };
    }

    // decompiled from Move bytecode v6
}

