module 0xb3b98d4fda36acc2c2e66dba61f9149b341c38e97a532af802ebbb0c037b9d1f::voting_escrow {
    struct Summary has copy, drop, store {
        total_locked: u64,
        total_voting_power: u64,
        rebase_apr: u64,
        current_epoch_end: u64,
        current_epoch_vote_end: u64,
        team_emission_rate: u64,
    }

    struct LockSummary has copy, drop, store {
        voting_power: u64,
        reward_distributor_claimable: u64,
        fee_incentive_total: u64,
        voted_pools: vector<0x2::object::ID>,
    }

    public fun transfer<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock>(arg1, arg2);
    }

    public fun create_lock<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::create_lock<T0>(arg0, 0xb3b98d4fda36acc2c2e66dba61f9149b341c38e97a532af802ebbb0c037b9d1f::utils::merge_coins<T0>(arg1, arg5), arg2, arg3, arg4, arg5);
    }

    public fun create_lock_single_coin<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        create_lock<T0>(arg0, v0, arg2, arg3, arg4, arg5);
    }

    public fun increase_amount<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg2: vector<0x2::coin::Coin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::increase_amount<T0>(arg0, arg1, 0xb3b98d4fda36acc2c2e66dba61f9149b341c38e97a532af802ebbb0c037b9d1f::utils::merge_coins<T0>(arg2, arg4), arg3, arg4);
    }

    public fun increase_amount_single_coin<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::increase_amount<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun increase_unlock_time<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::increase_unlock_time<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun lock_permanent<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::lock_permanent<T0>(arg0, arg1, arg2, arg3);
    }

    public fun lock_summary<T0>(arg0: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter::Voter, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::RebaseDistributor<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0x2::event::emit<LockSummary>(lock_summary_internal<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun lock_summary_internal<T0>(arg0: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter::Voter, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::RebaseDistributor<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) : LockSummary {
        let v0 = 0;
        let v1 = 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter::voted_pools(arg0, arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            v0 = v0 + 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::fee_voting_reward::earned<T0>(0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter::borrow_fee_voting_reward(arg0, 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter::pool_to_gauge(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2))), arg3, arg4);
            v2 = v2 + 1;
        };
        LockSummary{
            voting_power                 : 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::balance_of_nft_at<T0>(arg1, arg3, 0x2::clock::timestamp_ms(arg4) / 1000),
            reward_distributor_claimable : 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::claimable<T0>(arg2, arg1, arg3),
            fee_incentive_total          : v0,
            voted_pools                  : v1,
        }
    }

    public fun max_bps() : u64 {
        100000000
    }

    public fun merge_locks<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg2: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::merge<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun summary<T0>(arg0: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::Minter<T0>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::distribution_config::DistributionConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg3);
        let v1 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::total_locked<T0>(arg1);
        let v2 = 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::o_sail_epoch_emissions<T0>(arg0, arg2);
        let v3 = 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::calculate_rebase_growth(v2, 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::sail_total_supply<T0>(arg0), v1);
        let v4 = Summary{
            total_locked           : v1,
            total_voting_power     : 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::total_supply_at<T0>(arg1, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg3)),
            rebase_apr             : 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(v3, max_bps(), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(v2 + v3, 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::rate_denom(), 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::rate_denom() - 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::team_emission_rate<T0>(arg0))),
            current_epoch_end      : 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_next(v0),
            current_epoch_vote_end : 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_vote_end(v0),
            team_emission_rate     : 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::minter::team_emission_rate<T0>(arg0),
        };
        0x2::event::emit<Summary>(v4);
    }

    public fun unlock_permanent<T0>(arg0: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::unlock_permanent<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

